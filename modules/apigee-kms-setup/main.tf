resource "google_kms_key_ring" "apigee_kms_key_ring" {
  name     = var.key_ring_name
  location = var.location
  project  = var.project_id
}

resource "google_kms_crypto_key" "apigee_kms_key" {
  name     = var.crypto_key_name
  key_ring = google_kms_key_ring.apigee_kms_key_ring.id

  lifecycle {
    prevent_destroy = false # Prevent accidental deletion
  }
}

resource "google_kms_crypto_key_version" "apigee_kms_key_version" {
  crypto_key = google_kms_crypto_key.apigee_kms_key.id
  #algorithm  = "GOOGLE_SYMMETRIC_ENCRYPTION"

  lifecycle {
    prevent_destroy = false # Prevent accidental deletion
  }
}

resource "google_project_service_identity" "apigee_sa" {
  provider = google-beta
  project  = var.project_id
  service  = "apigee.googleapis.com"
}

resource "google_kms_crypto_key_iam_binding" "apigee_sa_keyuser" {
  crypto_key_id = google_kms_crypto_key.apigee_kms_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${google_project_service_identity.apigee_sa.email}",
  ]
}