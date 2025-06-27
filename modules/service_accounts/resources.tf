# resource "google_service_account" "service_account" {
#   count = length(var.service_accounts)
#   display_name = var.service_accounts[count.index].display_name
#   account_id = var.service_accounts[count.index].account_id
#   description = var.service_accounts[count.index].description
#   project = var.service_accounts[count.index].project_id
# }

resource "google_service_account" "service_account" {
  for_each = { for sa in var.service_accounts : sa.account_id => sa }

  display_name = each.value.display_name
  account_id   = each.value.account_id
  description  = each.value.description
  project      = each.value.project_id
}
