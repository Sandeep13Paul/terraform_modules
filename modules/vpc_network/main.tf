terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      configuration_aliases = [google.project]
    }
  }
}

provider "google" {
  alias = "project"
}