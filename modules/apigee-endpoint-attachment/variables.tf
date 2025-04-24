variable "org_id" {
  type        = string
  description = "The ID of the Google Cloud organization. Format: organizations/ORG_ID"
}

variable "location" {
  type        = string
  description = "Endpoint Attachment Location"
}

variable "service_attachments" {
  type        = list(string)
  description = "List of Service Attachment IDs. Format: projects/PROJECT_ID/regions/REGION/serviceAttachments/*"
}
