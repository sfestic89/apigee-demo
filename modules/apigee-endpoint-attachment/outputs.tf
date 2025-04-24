output "apigee_endpoint_hosts" {
  value       = [for ea in google_apigee_endpoint_attachment.default : ea.host]
  description = "List of Endpoint hosts"
}
