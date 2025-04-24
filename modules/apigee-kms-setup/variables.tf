variable "project_id" {
  description = "The GCP project ID where the KMS key will be created"
  type        = string
}

variable "location" {
  description = "The location for the KMS key ring (e.g., europe-west1)"
  type        = string
}

variable "key_ring_name" {
  description = "The name of the KMS key ring"
  type        = string
}

variable "crypto_key_name" {
  description = "The name of the KMS cryptographic key"
  type        = string
}

variable "database_encryption_key" {
  description = "Cloud KMS"
  type        = string
  default     = null
}