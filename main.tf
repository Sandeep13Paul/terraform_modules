provider "google" {
  alias = "project"
  credentials = base64decode(local.GOOGLE_CREDENTIALS)
  project     = local.project_id
  region      = var.region
  zone        = var.zone
}

# module "vpc_network" {
#   source = "./modules/vpc_network"
#   count  = var.enable_vpc ? var.service_count : 0

#   project_id = local.project_id
#   region     = var.region
#   zone       = var.zone
#   GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

#   providers = {
#     google = google.project
#   }
# }

# locals {
#   vpc_networks = var.services["vpc_network"].enabled ? var.services["vpc_network"].networks : []
# }

# module "vpc_network" {
#   source = "./modules/vpc_network"
#   # for_each = { for idx, network in local.vpc_networks : idx => network }

#   # name          = each.value.name
#   # auto_create_subnetworks      = each.value.auto_create_subnetworks
#   # description = each.value.description

#   networks = var.services["vpc_network"].enabled ? var.services["vpc_network"].networks : []

#   project_id = local.project_id
#   region     = var.region
#   zone       = var.zone
#   GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

#   providers = {
#     google = google.project
#   }
}

# module "buckets" {
#   source = "./modules/buckets"
#   count  = var.enable_storage ? var.service_count : 0

#   project_id = local.project_id
#   region     = var.region
#   zone       = var.zone
#   GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

#   providers = {
#     google = google.project
#   }
# }

locals {
  buckets = var.services["bucket"].enabled ? var.services["bucket"].buckets : []
}

module "buckets" {
  source   = "./modules/buckets"
  buckets = var.services.bucket.enabled ? var.services.bucket.buckets : []

  project_id         = local.project_id
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS
  region     = var.region
  zone       = var.zone

  providers = {
    google = google.project
  }
}

# module "vm_instance" {
#   source = "./modules/vm_instance"
#   count  = var.enable_vm ? var.service_count : 0

#   project_id = local.project_id
#   region     = var.region
#   zone       = var.zone
#   GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

#   providers = {
#     google = google.project
#   }
# }

locals {
  vm_instances = var.services["vm_instance"].enabled ? var.services["vm_instance"].instances : []
}

module "vm_instance" {
  source   = "./modules/vm_instance"
  # for_each = { for idx, inst in local.vm_instances : idx => inst }

  # name         = each.value.name
  # machine_type = each.value.machine_type
  # image        = each.value.image
  # zone         = each.value.zone

  instances = var.services["vm_instance"].enabled ? var.services["vm_instance"].instances : []

  project_id         = local.project_id
  region             = var.region
  zone = var.zone
  GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS
  providers = {
    google = google.project
  }
}

# module "service_accounts" {
#   source = "./modules/service_accounts"
#   count  = var.enable_service_account ? var.service_count : 0

#   project_id = local.project_id
#   region     = var.region
#   zone       = var.zone
#   GOOGLE_CREDENTIALS = local.GOOGLE_CREDENTIALS

#   providers = {
#     google = google.project
#   }
# }

locals {
  GOOGLE_CREDENTIALS = var.project_selector == "project1" ? var.GOOGLE_CREDENTIALS1 : var.GOOGLE_CREDENTIALS2
  project_id = var.project_selector == "project1" ? var.project_id_1 : var.project_id_2
}