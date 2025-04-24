variable "project_id" {
  description = "Project ID for the project to create the Apigee instance in"
  type        = string
}

variable "apigee_vpc" {
  description = "Apigee VPC ID."
  type        = string
}

variable "apigee_subnet" {
  description = "Apigee Subnet ID."
  type        = string
}

variable "random_certificate_suffix" {
  description = "Flag to determine if a random suffix should be appended to the SSL certificate name"
  type        = bool
  default     = true
}

variable "domains" {
  description = "Apigee Domain"
  type        = string
}

variable "apigee_ssl_cert" {
  description = "Apigee SSL Certificate"
  type        = string
}

variable "apigee_https_proxy" {
  description = "Apigee LB https proxy"
  type        = string
}

variable "apigee_forwarding_rule" {
  description = "Apigee LB forwarding rule"
  type        = string
}

variable "apigee_url_map" {
  description = "Apigee URL"
  type        = string
}

variable "region" {
  description = "Region where the instance runtime and analytics data will live"
  default     = "europe-west4"
}

variable "network" {
  description = "network for the private service connect"
  type        = string
}