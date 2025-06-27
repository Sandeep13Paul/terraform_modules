# resource "google_compute_instance" "vm-sandeep-tf" {
#   count        = length(var.instances)
#   name         = var.instances[count.index].name
#   machine_type = var.instances[count.index].machine_type
#   zone         = var.instances[count.index].zone
#   can_ip_forward = false
#   tags           = ["sandeep-tf"]
#   boot_disk {
#     initialize_params {
#       image = var.instances[count.index].image
#       size  = 20
#     }
#   }

#   network_interface {
#     network    = "default"
#   }
# }

resource "google_compute_instance" "vm_sandeep_tf" {
  for_each     = { for vm in var.instances : vm.name => vm }

  name         = each.value.name
  machine_type = each.value.machine_type
  zone         = each.value.zone
  can_ip_forward = false
  tags           = ["sandeep-tf"]

  boot_disk {
    initialize_params {
      image = each.value.image
      size  = 20
    }
  }

  network_interface {
    network = "default"
  }
}
