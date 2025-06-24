# provider "google" {
#   alias = "project"
#   credentials = local.GOOGLE_CREDENTIALS
#   project     = var.project_id
#   region      = var.region
#   zone        = var.zone
# }

module "vm_instance" {
  source = "./modules/vm_instance"
#   count  = var.enable_vm ? var.service_count : 0

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS
}

module "vpc_network" {
  source = "./modules/vpc_network"
#   count  = var.enable_vpc ? var.service_count : 0

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS
}

module "buckets" {
  source = "./modules/buckets"
#   count  = var.enable_storage ? var.service_count : 0

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS
}

locals {
  GOOGLE_CREDENTIALS = var.project_selector == "project1" ? var.GOOGLE_CREDENTIALS1 : var.GOOGLE_CREDENTIALS2
}