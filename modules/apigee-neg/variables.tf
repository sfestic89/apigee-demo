variable "project_id" {
  description = "The GCP project ID where the NEG will be created."
  type        = string
}

variable "name" {
  description = "Name of the Network Endpoint Group."
  type        = string
}

variable "region" {
  description = "Region for the NEG."
  type        = string
}

variable "network" {
  description = "The VPC network self-link for the NEG."
  type        = string
}

variable "subnetwork" {
  description = "The subnet self-link within the VPC where the NEG will reside."
  type        = string
}

variable "psc_target_service" {
  description = "The service attachment URL for Private Service Connect."
  type        = string
}