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
    subnet_id = yandex_vpc_subnet.default.id
    nat       = false

    security_group_ids = [
      yandex_vpc_security_group.allow_alb.id
    ]
  }

  metadata = {
    ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
    user-data = file("cloud-init.yaml")
  }
}
