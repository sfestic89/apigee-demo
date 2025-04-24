# Create Private Service Access Connection
resource "google_compute_global_address" "apigee_peering_range" {
  project       = var.project_id
  name          = "apigee-peering-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 22
  network       = var.network
}

resource "google_service_networking_connection" "apigee_connection" {
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.apigee_peering_range.name]
  network                 = var.network
}
