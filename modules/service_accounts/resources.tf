resource "google_service_account" "service_account" {
  account_id   = "service-account-id-${random_id.suffix.hex}"
  display_name = "Service-Account-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 4
}