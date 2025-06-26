# resource "google_compute_network" "auto-vpc-tf-unique-names" {
#   name                    = var.name
#   auto_create_subnetworks = var.auto_create_subnetworks
#   description             = var.description
# }

# resource "google_compute_network" "custom-vpc-tf-uniques" {
#   name                    = var.name
#   description             = var.description
#   auto_create_subnetworks = var.auto_create_subnetworks
# }

# resource "google_compute_subnetwork" "subnet-custom-vpc-tfv" {
#   name    = "custom-subnet-${random_id.suffix.hex}"
#   region  = var.region
#   network = google_compute_network.custom-vpc-tf-uniques.id
#   ip_cidr_range = "10.1.0.0/24"
#   private_ip_google_access = true
# }

# resource "google_compute_firewall" "allow-icmp" {
#     name = "icmp-rule-${random_id.suffix.hex}"
#     network = google_compute_network.custom-vpc-tf-uniques.id
#     direction = "INGRESS"
#     priority = 1000
#     source_ranges = ["14.97.94.230/32"]
#     allow {
#         protocol = "icmp"
#     }

# }

# resource "random_id" "suffix" {
#   byte_length = 4
# }

resource "google_compute_network" "vpc" {
  for_each = { for net in var.networks : net.name => net }

  name                     = each.value.name
  auto_create_subnetworks = each.value.auto_create_subnetworks
  description              = lookup(each.value, "description", null)
}

resource "google_compute_subnetwork" "subnets" {
  for_each = {
    for net in var.networks :
    net.name => net.subnets != null ? [
      for s in net.subnets : {
        name                     = s.name
        region                   = s.region
        ip_cidr_range            = s.ip_cidr_range
        private_ip_google_access = s.private_ip_google_access
        network_name             = net.name
      }
    ] : []
  }

  count = length(each.value)

  name                     = each.value[count.index].name
  region                   = each.value[count.index].region
  ip_cidr_range            = each.value[count.index].ip_cidr_range
  private_ip_google_access = each.value[count.index].private_ip_google_access
  network                  = google_compute_network.vpc[each.value[count.index].network_name].self_link
}