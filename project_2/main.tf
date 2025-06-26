module "vpc_network" {
  source = "../modules/vpc_network"

  networks = var.services["vpc_network"].networks

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS2
}

module "buckets" {
  source   = "../modules/buckets"
  buckets = var.services["bucket"].enabled ? var.services["bucket"].buckets : []

  project_id         = var.project_id
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS2
  region     = var.region
  zone       = var.zone
}

module "vm_instance" {
  source   = "../modules/vm_instance"
  instances = var.services["vm_instance"].enabled ? var.services["vm_instance"].instances : []

  project_id         = var.project_id
  region             = var.region
  zone = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS2
}

module "service_accounts" {
  source = "../modules/service_accounts"
  service_accounts =var.services["service_account"].service_accounts

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS2
}