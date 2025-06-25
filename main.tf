provider "google" {
  alias = "project"
  credentials = base64decode(local.GOOGLE_CREDENTIALS)
  project     = local.project_id
  region      = var.region
  zone        = var.zone
}

module "vpc_network" {
  source = "./modules/vpc_network"
  count  = var.enable_vpc ? var.service_count : 0

  project_id = local.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

  providers = {
    google = google.project
  }
}

module "buckets" {
  source = "./modules/buckets"
  count  = var.enable_storage ? var.service_count : 0

  project_id = local.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

  providers = {
    google = google.project
  }
}

module "vm_instance" {
  source = "./modules/vm_instance"
  count  = var.enable_vm ? var.service_count : 0

  project_id = local.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

  providers = {
    google = google.project
  }
}

module "service_account" {
  source = "./modules/service_accounts"
  count  = var.enable_vm ? var.service_count : 0

  project_id = local.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

  providers = {
    google = google.project
  }
}

locals {
  GOOGLE_CREDENTIALS = var.project_selector == "project1" ? var.GOOGLE_CREDENTIALS1 : var.GOOGLE_CREDENTIALS2
  project_id = var.project_selector == "project1" ? var.project_id_1 : var.project_id_2
}