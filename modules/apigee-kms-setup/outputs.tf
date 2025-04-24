output "key_ring_id" {
  description = "The ID of the KMS key ring"
  value       = google_kms_key_ring.apigee_kms_key_ring.id
}

output "crypto_key_id" {
  description = "The ID of the KMS cryptographic key"
  value       = google_kms_crypto_key.apigee_kms_key.id
}