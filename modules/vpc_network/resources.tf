# resource "google_compute_network" "vpc" {
#   count = length(var.networks)

#   name                    = var.networks[count.index].name
#   auto_create_subnetworks = var.networks[count.index].auto_create_subnetworks
#   description             = var.networks[count.index].description
# }

# locals {
#   subnets = flatten([
#     for i, vpc in var.networks : [
#       for subnet in vpc.subnets : {
#         vpc_index  = i
#         vpc_name   = vpc.name
#         name       = subnet.name
#         region     = subnet.region
#         cidr       = subnet.ip_cidr_range
#         private_ip_google_access = subnet.private_ip_google_access
#       }
#     ]
#   ])
# }

# resource "google_compute_subnetwork" "subnet" {
#   count = length(local.subnets)

#   name          = local.subnets[count.index].name
#   region        = local.subnets[count.index].region
#   network       = google_compute_network.vpc[local.subnets[count.index].vpc_index].id
#   ip_cidr_range = local.subnets[count.index].cidr
#   private_ip_google_access = local.subnets[count.index].private_ip_google_access
# }

resource "google_compute_network" "vpc" {
  for_each = { for net in var.networks : net.name => net }

  name                    = each.value.name
  auto_create_subnetworks = each.value.auto_create_subnetworks
  description             = each.value.description
}


locals {
  subnets = flatten([
    for vpc in var.networks : [
      for subnet in vpc.subnets : {
        vpc_name   = vpc.name
        name       = subnet.name
        region     = subnet.region
        cidr       = subnet.ip_cidr_range
        private_ip_google_access = subnet.private_ip_google_access
      }
    ]
  ])
}


resource "google_compute_subnetwork" "subnet" {
  for_each = {
    for subnet in local.subnets : "${subnet.vpc_name}-${subnet.name}" => subnet
  }

  name          = each.value.name
  region        = each.value.region
  network       = google_compute_network.vpc[each.value.vpc_name].id
  ip_cidr_range = each.value.cidr
  private_ip_google_access = each.value.private_ip_google_access
}
