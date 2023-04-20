```hcl
variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

locals {
  network_name     = "ddos-network"
  subnet_name1     = "subnet-1"
  subnet_name2     = "subnet-2"
  sa_name          = "ig-sa"
  sg_balancer_name = "ddos-sg-balancer"
  sg_vm_name       = "ddos-sg-vms"
  vm_name          = "ddos-group"
  tg_name          = "tg-ddos"
  address_name     = "ddos-addr"
  abg_name         = "ddos-backend-group"
  backend_name     = "backend-1"
  router_name      = "ddos-router"
  vh_name          = "ddos-host"
  authority_domain = ["alb-with-ddos.com"]
  route_name       = "route-1"
  alb_name         = "ddos-protect-alb"
  listener_name    = "ddos-listener"
}

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
}

resource "yandex_iam_service_account" "ig-sa" {
  name = local.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

resource "yandex_vpc_network" "ddos-network" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.ddos-network.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.ddos-network.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_security_group" "ddos-sg-balancer" {
  name       = local.sg_balancer_name
  network_id = yandex_vpc_network.ddos-network.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol          = "TCP"
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 30080
  }
}

resource "yandex_vpc_security_group" "ddos-sg-vms" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.ddos-network.id

  ingress {
    protocol          = "TCP"
    description       = "balancer"
    security_group_id = yandex_vpc_security_group.ddos-sg-balancer.id
    port              = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

resource "yandex_compute_image" "lemp" {
  source_family = "lemp"
}

resource "yandex_compute_instance_group" "ddos-group" {
  name               = local.vm_name
  folder_id          = var.folder_id
  service_account_id = yandex_iam_service_account.ig-sa.id
  instance_template {
    platform_id        = "standard-v2"
    service_account_id = yandex_iam_service_account.ig-sa.id
    resources {
      core_fraction = 5
      memory        = 1
      cores         = 2
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = yandex_compute_image.lemp.id
        type     = "network-hdd"
        size     = 3
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.ddos-network.id
      subnet_ids         = [yandex_vpc_subnet.subnet-1.id,yandex_vpc_subnet.subnet-2.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.ddos-sg-vms.id]
    }

    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["{{ region-id }}-a", "{{ region-id }}-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name = local.tg_name
  }
}

resource "yandex_vpc_address" "ddos-addr" {
  name = local.address_name

  external_ipv4_address {
    zone_id                  = "{{ region-id }}-a"
    ddos_protection_provider = "qrator"
  }
}

resource "yandex_alb_backend_group" "ddos-backend-group" {
  name = local.abg_name

  http_backend {
    name             = local.backend_name
    port             = 80
    target_group_ids = [yandex_compute_instance_group.ddos-group.application_load_balancer.0.target_group_id]
    healthcheck {
      timeout          = "10s"
      interval         = "2s"
      healthcheck_port = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "ddos-router" {
  name   = local.router_name
}

resource "yandex_alb_virtual_host" "ddos-host" {
  name           = local.vh_name
  http_router_id = yandex_alb_http_router.ddos-router.id
  authority      = local.authority_domain
  route {
    name = local.route_name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.ddos-backend-group.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "ddos-protect-alb" {
  name               = local.alb_name
  network_id         = yandex_vpc_network.ddos-network.id
  security_group_ids = [yandex_vpc_security_group.ddos-sg-balancer.id]

  allocation_policy {
    location {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }

    location {
      zone_id   = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.subnet-2.id
    }
  }

  listener {
    name = local.listener_name
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.ddos-addr.external_ipv4_address[0].address
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.ddos-router.id
      }
    }
  }
}
```
