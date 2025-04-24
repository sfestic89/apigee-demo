variable "project_id" {
  description = "The GCP project ID to deploy to"
  type        = string
}

variable "env_name" {
  description = "Environment name"
  type        = string
}

variable "users" {
  description = "List of users or groups that are allowed access"
  type        = list(string)
  default     = []
}

variable "region" {
  description = "Region to deploy resources to"
  type        = string
}

variable "domains" {
  type        = string
  description = "Apigee organization description"
}

variable "consumer_accept_list" {
  description = "List of Project that are allowed access on the Apigee instance"
  type        = list(string)
  default     = []
}

variable "infra_repository_full_name" {
  description = "Full name of GitHub Repository that contains the infrastructure resources"
  type        = string
}

# APIs
variable "activate_apis" {
  description = "List of APIs to enable"
  type        = list(string)
  default = [
    "admin.googleapis.com",
    "bigquery.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
    "clouderrorreporting.googleapis.com",
    "cloudidentity.googleapis.com",
    "cloudtrace.googleapis.com",
    "iam.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "networkmanagement.googleapis.com",
    "servicecontrol.googleapis.com",
    "servicemanagement.googleapis.com",
    "servicenetworking.googleapis.com",
    "serviceusage.googleapis.com",
    "storage-api.googleapis.com",
    "storage-component.googleapis.com",
    "storage.googleapis.com",
    "compute.googleapis.com",
    "iap.googleapis.com",
    "apigee.googleapis.com",
    "cloudkms.googleapis.com",
    "networkconnectivity.googleapis.com"
  ]
}

variable "issuer_uri" {
  description = "Workload Identity Pool Issuer URL"
  type        = string
  default     = ""
}

variable "service_account_apigee_infra_roles" {
  description = "Project roles to be granted to the Service Account used to deploy the Infrastructure"
  type        = list(string)
  default = [
    "roles/artifactregistry.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.workloadIdentityPoolAdmin",
    "roles/monitoring.editor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/serviceusage.serviceUsageAdmin",
    "roles/storage.admin",
    "roles/apigee.admin",
    "roles/cloudkms.admin",
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin"
  ]
}
