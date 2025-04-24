resource "google_apigee_instance" "apigee_instance" {
  for_each                 = var.apigee_instance
  org_id                   = var.apigee_org_id
  name                     = each.key
  location                 = each.value.region
  ip_range                 = each.value.ip_range
  disk_encryption_key_name = each.value.disk_encryption_key
  consumer_accept_list     = each.value.consumer_accept_list
}

resource "google_apigee_instance_attachment" "apigee_instance_attachment" {
  for_each    = var.apigee_environments
  instance_id = google_apigee_instance.apigee_instance[each.value.instance].id
  environment = each.key
}