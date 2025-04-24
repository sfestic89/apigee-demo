variable "apigee_org_id" {
  description = "Apigee Organization ID."
  type        = string
}

variable "apigee_instance" {
  description = "Map of Apigee instances with their configurations"
  type = map(object({
    region               = string
    ip_range             = string
    disk_encryption_key  = string
    consumer_accept_list = list(string)
  }))
}

variable "apigee_envgroups" {
  description = "Apigee Environment Groups."
  type = map(object({
    environments = list(string)
    hostnames    = list(string)
  }))
  default = {}
}

variable "apigee_environments" {
  description = "Mapping of environments to their respective instances"
  type = map(object({
    instance = string
  }))
}