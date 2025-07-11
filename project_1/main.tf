terraform {
  backend "gcs" {
    bucket = "tfstate-sandeep-project1"
    prefix = "project_1/env1"
  }
}

module "vpc_network" {
  source = "../modules/vpc_network"
  networks = var.services.vpc_network.networks

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS1
}

module "buckets" {
  source   = "../modules/buckets"
  buckets = var.services.bucket.enabled ? var.services.bucket.buckets : []

  project_id         = var.project_id
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS1
  region     = var.region
  zone       = var.zone
}

module "vm_instance" {
  source   = "../modules/vm_instance"
  instances = var.services["vm_instance"].enabled ? var.services["vm_instance"].instances : []

  project_id         = var.project_id
  region             = var.region
  zone = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS1
  ssh_public_key = var.ssh_public_key
}

module "service_accounts" {
  source = "../modules/service_accounts"
  service_accounts = var.services["service_account"].service_accounts

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  GOOGLE_CREDENTIALS = var.GOOGLE_CREDENTIALS1
}