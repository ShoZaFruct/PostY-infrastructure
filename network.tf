resource "yandex_vpc_network" "main" {
  name = "posty-network"
}

resource "yandex_vpc_subnet" "db_subnet" {
  name           = "posty-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_subnet" "default" {
  name           = "another-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

resource "yandex_vpc_address" "static_ip" {
  name = "posty-static-ip"

  external_ipv4_address {
    zone_id = "ru-central1-a"
  }
}