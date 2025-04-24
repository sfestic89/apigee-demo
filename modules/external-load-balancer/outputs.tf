# In external-load-balancer IP
output "lb_ip_address" {
  value = google_compute_global_address.apigee_external_ip.address
}