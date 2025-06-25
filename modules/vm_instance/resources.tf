resource "google_compute_instance" "vm-sandeep-tf" {
  name           = "vm-sandeep-${random_id.suffix.hex}"
  machine_type   = "n1-standard-1"
  zone           = var.zone
  can_ip_forward = false
  tags           = ["sandeep-tf"]
  boot_disk {
    initialize_params {
      image = "rocky-linux-cloud/rocky-linux-9"
      size  = 20
    }
  }

  network_interface {
    network    = "default"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}