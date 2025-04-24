# Network Endpoint Group for Private Service Connect
resource "google_compute_region_network_endpoint_group" "neg" {
  project               = var.project_id
  name                  = var.name
  region                = var.region
  network               = var.network
  subnetwork            = var.subnetwork
  network_endpoint_type = "PRIVATE_SERVICE_CONNECT"
  psc_target_service    = var.psc_target_service
  lifecycle {
    create_before_destroy = true
  }
}