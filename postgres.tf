resource "yandex_mdb_postgresql_cluster" "db" {
  name        = "posty-db"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.main.id

  config {
    version = "15"

    resources {
      resource_preset_id = "s2.micro"
      disk_size          = 20
      disk_type_id       = "network-hdd"
    }

    postgresql_config = {
      max_connections                   = 100
      enable_parallel_hash              = true
      default_transaction_isolation = "TRANSACTION_ISOLATION_READ_COMMITTED"
      timezone                           = "UTC"
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.db_subnet.id
    name      = "host1"
  }
}

resource "yandex_mdb_postgresql_user" "user" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = "posty_user"
  password   = var.db_password
}

resource "yandex_mdb_postgresql_database" "database" {
  cluster_id = yandex_mdb_postgresql_cluster.db.id
  name       = "posty"
  owner      = yandex_mdb_postgresql_user.user.name
}
