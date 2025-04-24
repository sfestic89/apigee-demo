resource "google_apigee_endpoint_attachment" "default" {
  count  = length(var.service_attachments)
  org_id = var.org_id

  endpoint_attachment_id = "ea-${count.index}"
  location               = var.location
  service_attachment     = var.service_attachments[count.index]
}
