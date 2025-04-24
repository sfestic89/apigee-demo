variable "project_id" {
  type        = string
  description = "The ID of the Google Cloud project"
}

variable "analytics_region" {
  type        = string
  description = "Region for analytics storage"
}

variable "display_name" {
  type        = string
  description = "Apigee organization display name"
}

variable "description" {
  type        = string
  description = "Apigee organization description"
}

variable "domains" {
  type        = string
  description = "Apigee organization description"
}

variable "runtime_type" {
  type        = string
  description = "Apigee runtime type"
}

variable "billing_type" {
  type        = string
  description = "Apigee billing type"
}

variable "authorized_network" {
  type        = string
  description = "Authorized VPC network"
}

variable "apigee_environments" {
  type = map(object({
    display_name = string
    role         = string
    users        = list(string)
    type         = string
  }))
  description = "A map of Apigee environments"
}

variable "database_encryption_key" {
  description = "Cloud KMS"
  type        = string
  default     = null
}

variable "envgroup_name" {
  description = "Name for the Apigee environment group."
  type        = string
}

variable "lb_ip_address" {
  description = "Load balancer IP address."
  type        = any
}