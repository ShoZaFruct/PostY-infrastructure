resource "yandex_alb_target_group" "backend_group" {
  name = "posty-target-group"

  target {
    subnet_id  = yandex_vpc_subnet.default.id
    ip_address = yandex_compute_instance.backend_vm.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "backend_group" {
  name = "posty-backend-group"

  http_backend {
    name             = "backend1"
    port             = 80
    target_group_ids = [yandex_alb_target_group.backend_group.id]

    load_balancing_config {
      panic_threshold = 50
    }

    healthcheck {
      timeout  = "1s"
      interval = "10s"

      http_healthcheck {
        path = "/api/doc"
      }
    }
  }
}

resource "yandex_alb_http_router" "router" {
  name = "posty-http-router"
}

resource "yandex_alb_virtual_host" "vhost" {
  name           = "posty-virtual-host"
  http_router_id = yandex_alb_http_router.router.id

  route {
    name = "route1"

    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend_group.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "alb" {
  name       = "posty-lb"
  network_id = yandex_vpc_network.main.id

  allocation_policy {
    location {
      zone_id = var.zone
      subnet_id = yandex_vpc_subnet.default.id
    }
  }

  listener {
    name = "http-listener"

    endpoint {
      address {
          external_ipv4_address {
            address = yandex_vpc_address.static_ip.external_ipv4_address[0].address
          }
      }
      ports = [80]
    }

    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }
}
