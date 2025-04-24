output "service_account_apigee_infra" {
  value       = module.service_account_apigee_infra.email
  description = "Service account for provisioning of infrastructure resources (to replace workload-identity-service-account to replace on request.yaml)"
}

output "wif_provider_id" {
  value       = module.gh_oidc.provider_name
  description = "Workload Identity Federation Provider name (to replace workload-identity-provider-id on infra-plan.yaml, infra-apply.yaml)"
}

output "state_bucket" {
  value       = module.tf_state_bucket.name
  description = "State bucket name"
}

output "kms_key_ring_id" {
  value = module.apigee_kms.key_ring_id
}

output "kms_crypto_key_id" {
  value = module.apigee_kms.crypto_key_id
}