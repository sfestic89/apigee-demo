output "org_id" {
  value = google_apigee_organization.apigee_org.id
}

output "apigee_environments" {
  value = google_apigee_environment.apigee_env
}