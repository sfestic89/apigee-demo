
#######################################
########## Common resources ###########
#######################################

# APIs
module "apis" {
  source = "" #api_enablement_module

  project_id    = var.project_id
  activate_apis = var.activate_apis
}

# Service Account - Apigee Infrastructure
module "service_account_apigee_infra" {
  source = "" #service_account_module

  project_id   = var.project_id
  names        = ["sa-wif-apigee-infra"]
  display_name = "Service account for provisioning of infrastructure resources"
  project_roles = [
    for r in var.service_account_apigee_infra_roles : "${var.project_id}=>${r}"
  ]

  depends_on = [
    module.apis
  ]
}

# Service Account - Apigee Proxy
module "service_account_apigee_proxy" {
  source = "" #service_account_module

  project_id    = var.project_id
  names         = ["sa-apigee-proxy"]
  display_name  = "Service account for Apigee Proxy"
  project_roles = []

  depends_on = [
    module.apis
  ]
}

# Workload Identity Federation
module "gh_oidc" {
  source = "" #wif_module

  project_id            = var.project_id
  pool_display_name     = "Apigee WIF Pool"
  pool_description      = "Apigee WIF Pool"
  provider_display_name = "Apigee WIF Provider"
  provider_description  = "Apigee WIF Provider"
  issuer_uri            = var.issuer_uri

  sa_mapping = {
    ("sa-wif-apigee-infra") = {
      sa_name   = module.service_account_apigee_infra.service_account.name
      attribute = "attribute.repository/${var.infra_repository_full_name}"
    }
  }

  depends_on = [
    module.service_account_apigee_infra
  ]
}

# Call VPC creation module
module "apigee_vpc" {
  source = "" #vpc_creation_module
  vpc = {
    "apigee-vpc" = {
      project     = var.project_id
      name        = "apigee-vpc"
      description = "VPC for Private Service Access for Apigee"
    }
  }

  depends_on = [
    module.gh_oidc
  ]
}

module "apigee_subnet" {
  source       = "" #subnet_creation_module
  project_id   = var.project_id
  network_name = module.apigee_vpc.vpc_name["apigee-vpc"]
  subnets = [
    {
      subnet_name           = "apigee-prod-new"
      subnet_region         = var.region
      subnet_ip             = "192.168.0.0/24"
      subnet_private_access = true
      subnet_flow_logs      = false
    }
  ]

  depends_on = [
    module.gh_oidc
  ]
}

module "apigee_kms" {
  source          = "./modules/apigee-kms-setup"
  project_id      = var.project_id
  location        = var.region
  crypto_key_name = "apigee-ccoe-crypto-key"
  key_ring_name   = "apigee-ccoe-keyring"

  depends_on = [
    module.gh_oidc
  ]
}

module "apigee_peering" {
  source       = "./modules/apigee-network"
  peering_name = "apigee peering"
  network      = module.apigee_vpc.vpc_name["apigee-vpc"]
  project_id   = var.project_id
  env_name     = var.env_name
}

module "apigee_organization" {
  source                  = "./modules/apigee-org"
  project_id              = var.project_id
  analytics_region        = var.region
  display_name            = "apigee ccoe org"
  description             = "Mercedes Benz CCoE Team Apigee"
  runtime_type            = "CLOUD"
  billing_type            = "PAYG"
  domains                 = var.domains
  lb_ip_address           = module.apigee_external_load_balancer.lb_ip_address
  authorized_network      = module.apigee_vpc.vpc_name["apigee-vpc"]
  database_encryption_key = module.apigee_kms.crypto_key_id
  envgroup_name           = "prodenvgroup"
  apigee_environments = {
    prod = {
      display_name = "PROD"
      role         = "roles/apigee.environmentAdmin"
      users        = var.users
      type         = "BASE"
    }
  }
  depends_on = [
    module.apigee_kms
  ]
}

module "apigee_instance" {
  source        = "./modules/apigee-instance"
  apigee_org_id = module.apigee_organization.org_id

  apigee_instance = {
    ccoe-instance = {
      name                 = "ccoe instance"
      region               = var.region
      ip_range             = "10.10.10.0/28"
      disk_encryption_key  = module.apigee_kms.crypto_key_id
      consumer_accept_list = var.consumer_accept_list
    }
  }
  apigee_environments = {
    prod = { instance = "ccoe-instance" }
  }

  depends_on = [module.apigee_peering]
}

module "apigee_external_load_balancer" {
  source        = "./modules/external-load-balancer"
  project_id    = var.project_id
  apigee_vpc    = module.apigee_vpc.vpc_name["apigee-vpc"]
  apigee_subnet = module.apigee_subnet.subnets["europe-west4/apigee-prod-new"].name
  domains       = var.domains

  # SSL certificate creation and configuration
  apigee_ssl_cert        = "apigee-ssl-cert"
  apigee_https_proxy     = "apigee-https-proxy"
  apigee_forwarding_rule = "apigee-forwarding-rule"
  apigee_url_map         = "apigee-url-map"
  region                 = var.region
  network                = module.apigee_vpc.vpc_name["apigee-vpc"]
}
