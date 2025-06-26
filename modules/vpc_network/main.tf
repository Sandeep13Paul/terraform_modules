# provider "google" {
#   credentials = base64decode(var.GOOGLE_CREDENTIALS)
#   project     = var.project_id
#   region      = var.region
#   zone        = var.zone
# }

# provider "google" {
#   alias = "project"
# }

terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      configuration_aliases = [google.project]
    }
  }
}