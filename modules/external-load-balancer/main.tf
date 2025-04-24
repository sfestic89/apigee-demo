resource "google_compute_global_address" "apigee_external_ip" {
  name    = "apigee-lb-ext-ip"
  project = var.project_id
}

resource "random_id" "certificate" {
  count       = var.random_certificate_suffix == true ? 1 : 0
  byte_length = 4
  prefix      = "${var.apigee_ssl_cert}-"

  keepers = {
    domains = join(",", [var.domains])
  }
}

resource "google_compute_managed_ssl_certificate" "lb_ssl_cert" {
  project = var.project_id
  count   = length(var.apigee_ssl_cert) > 0 ? 1 : 0
  name    = var.random_certificate_suffix == true ? random_id.certificate[0].hex : "${var.apigee_ssl_cert}"
  managed {
    domains = [var.domains]
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_compute_backend_service" "default" {
  project               = var.project_id
  name                  = "app-backend"
  protocol              = "HTTPS"
  load_balancing_scheme = "EXTERNAL_MANAGED"
}

resource "google_compute_url_map" "lb_url_map" {
  project         = var.project_id
  name            = var.apigee_url_map
  default_service = google_compute_backend_service.default.id
}
/**
resource "google_compute_target_https_proxy" "lb_https_proxy" {
  project          = var.project_id
  name             = var.apigee_https_proxy
  url_map          = google_compute_url_map.lb_url_map.id
  ssl_certificates = length(google_compute_managed_ssl_certificate.lb_ssl_cert) > 0 ? [google_compute_managed_ssl_certificate.lb_ssl_cert[0].id] : []
}

resource "google_compute_global_forwarding_rule" "lb_forwarding_rule" {
  project               = var.project_id
  name                  = var.apigee_forwarding_rule
  target                = google_compute_target_https_proxy.lb_https_proxy.self_link
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  ip_address            = google_compute_global_address.apigee_external_ip.address
}
**/