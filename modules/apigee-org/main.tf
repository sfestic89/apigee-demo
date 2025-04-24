resource "google_apigee_organization" "apigee_org" {
  project_id                           = var.project_id
  analytics_region                     = var.analytics_region
  display_name                         = var.display_name
  description                          = var.description
  runtime_type                         = var.runtime_type
  billing_type                         = var.billing_type
  authorized_network                   = var.authorized_network
  runtime_database_encryption_key_name = var.database_encryption_key

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_apigee_environment" "apigee_env" {
  for_each     = var.apigee_environments
  org_id       = google_apigee_organization.apigee_org.id
  name         = each.key
  display_name = each.value.display_name
  type         = each.value.type
}

resource "google_apigee_environment_iam_binding" "binding" {
  for_each = var.apigee_environments
  org_id   = google_apigee_organization.apigee_org.id
  env_id   = google_apigee_environment.apigee_env[each.key].name
  role     = each.value.role
  members  = each.value.users
}

# Apigee Environment Group with Dynamic nip.io Domain
resource "google_apigee_envgroup" "apigee_envgroup" {
  org_id = google_apigee_organization.apigee_org.id
  name   = var.envgroup_name
  #hostnames = [format("%s.nip.io", var.lb_ip_address)]
  hostnames = [var.domains]
}

# Attach each environment to the environment group
resource "google_apigee_envgroup_attachment" "apigee_envgroup_attachment" {
  for_each    = google_apigee_environment.apigee_env
  envgroup_id = google_apigee_envgroup.apigee_envgroup.id
  environment = each.value.name
}