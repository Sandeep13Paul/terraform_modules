resource "google_compute_instance" "vm-sandeep-tf" {
  count        = length(var.instances)
  name         = var.instances[count.index].name
  machine_type = var.instances[count.index].machine_type
  zone         = var.instances[count.index].zone
  can_ip_forward = false
  tags           = ["sandeep-tf"]
  boot_disk {
    initialize_params {
      image = var.instances[count.index].image
      size  = 20
    }
  }

  network_interface {
    network    = "default"
  }
}