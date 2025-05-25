resource "yandex_vpc_security_group" "allow_alb" {
  name       = "allow-from-alb"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP from ALB"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow SSH from bastion internal"
    port           = 22
    v4_cidr_blocks = ["10.0.2.0/24"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "bastion_ssh" {
  name       = "allow-ssh-from-my-ip"
  network_id = yandex_vpc_network.main.id

  ingress {
    protocol       = "TCP"
    description    = "SSH from your IP"
    port           = 22
    v4_cidr_blocks = ["178.46.78.15/32"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
