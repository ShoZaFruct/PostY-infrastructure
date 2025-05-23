resource "yandex_compute_instance" "backend_vm" {
  name        = "posty-backend"
  zone        = var.zone
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 20
    }
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.default.id
    nat            = true
    nat_ip_address = yandex_vpc_address.static_ip.external_ipv4_address[0].address
  }

  metadata = {
    ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    user-data = file("cloud-init.yaml")
  }
}
