resource "google_compute_network" "auto-vpc-tf-unique-names" {
  name                    = var.name
  auto_create_subnetworks = var.auto_create_subnetworks
  description             = var.description
}

resource "google_compute_network" "custom-vpc-tf-uniques" {
  name                    = var.name
  description             = var.description
  auto_create_subnetworks = var.auto_create_subnetworks
}

resource "google_compute_subnetwork" "subnet-custom-vpc-tfv" {
  name    = "custom-subnet-${random_id.suffix.hex}"
  region  = var.region
  network = google_compute_network.custom-vpc-tf-uniques.id
  ip_cidr_range = "10.1.0.0/24"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-icmp" {
    name = "icmp-rule-${random_id.suffix.hex}"
    network = google_compute_network.custom-vpc-tf-uniques.id
    direction = "INGRESS"
    priority = 1000
    source_ranges = ["14.97.94.230/32"]
    allow {
        protocol = "icmp"
    }

}

resource "random_id" "suffix" {
  byte_length = 4
}