resource "google_service_account" "service_account" {
  count = length(var.service_accounts)
  display_name = var.service_accounts[count.index].display_name
  account_id = var.service_accounts[count.index].account_id
  description = var.service_accounts[count.index].description
  project = var.service_accounts[count.index].project_id
}