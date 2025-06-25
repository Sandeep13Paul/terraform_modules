resource "google_compute_instance" "vm-sandeep-tf" {
  name           = var.name
  machine_type   = var.machine_type
  zone           = var.zone
  can_ip_forward = false
  tags           = ["sandeep-tf"]
  boot_disk {
    initialize_params {
      image = var.image
      size  = 20
    }
  }

  network_interface {
    network    = "default"
  }
}

# resource "random_id" "suffix" {
#   byte_length = 4
# }