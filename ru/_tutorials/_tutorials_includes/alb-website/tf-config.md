```hcl
# Объявление переменных для конфиденциальных параметров

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type      = string
  sensitive = true
}

variable "domain" {
  type      = string
}

# Добавление прочих переменных

locals {
  sa_name      = "ig-sa"
  network_name = "network1"
  subnet_name1 = "subnet-1"
  subnet_name2 = "subnet-2"
  subnet_name3 = "subnet-3"
}

# Настройка провайдера

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  zone = "{{ region-id }}-a"
}

# Создание сервисного аккаунта и назначение прав

resource "yandex_iam_service_account" "ig-sa" {
  name = local.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

# Создание облачной сети и подсетей

resource "yandex_vpc_network" "network-1" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = local.subnet_name3
  zone           = "{{ region-id }}-d"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}

# Создание групп безопасности

resource "yandex_vpc_security_group" "alb-sg" {
  name        = "alb-sg"
  network_id  = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 1
    to_port        = 65535
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

resource "yandex_vpc_security_group" "alb-vm-sg" {
  name        = "alb-vm-sg"
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol          = "TCP"
    description       = "balancer"
    security_group_id = yandex_vpc_security_group.alb-sg.id
    port              = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Создание группы ВМ для сайта

resource "yandex_compute_image" "lemp" {
  source_family = "lemp"
}

resource "yandex_compute_instance_group" "alb-vm-group" {
  name               = "alb-vm-group"
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
      network_id         = yandex_vpc_network.network-1.id
      subnet_ids         = [yandex_vpc_subnet.subnet-1.id,yandex_vpc_subnet.subnet-2.id,yandex_vpc_subnet.subnet-3.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.alb-vm-sg.id]
    }

    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["{{ region-id }}-a", "{{ region-id }}-b", "{{ region-id }}-d"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name = "alb-tg"
  }
}

# Создание группы бэкендов

resource "yandex_alb_backend_group" "alb-bg" {
  name                     = "alb-bg"
  http_backend {
    name                   = "backend-1"
    port                   = 80
    target_group_ids       = [yandex_compute_instance_group.alb-vm-group.application_load_balancer.0.target_group_id]
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthcheck_port     = 80
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

# Создание HTTP-роутера и виртуального хоста

resource "yandex_alb_http_router" "alb-router" {
  name   = "alb-router"
}

resource "yandex_alb_virtual_host" "alb-host" {
  name           = "alb-host"
  http_router_id = yandex_alb_http_router.alb-router.id
  authority      = [var.domain, "www.${var.domain}"]
  route {
    name = "route-1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb-bg.id
      }
    }
  }
}

# Создание L7-балансировщика

resource "yandex_alb_load_balancer" "alb-1" {
  name               = "alb-1"
  network_id         = yandex_vpc_network.network-1.id
  security_group_ids = [yandex_vpc_security_group.alb-sg.id]

  allocation_policy {
    location {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }

    location {
      zone_id   = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.subnet-2.id
    }

    location {
      zone_id   = "{{ region-id }}-d"
      subnet_id = yandex_vpc_subnet.subnet-3.id
    }
  }

  listener {
    name = "alb-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-router.id
      }
    }
  }
}

# Создание DNS-зоны

resource "yandex_dns_zone" "alb-zone" {
  name        = "alb-zone"
  description = "Public zone"
  zone        = "${var.domain}."
  public      = true
}

# Создание ресурсных записей в DNS-зоне

resource "yandex_dns_recordset" "rs-1" {
  zone_id = yandex_dns_zone.alb-zone.id
  name    = "${var.domain}."
  ttl     = 600
  type    = "A"
  data    = [yandex_alb_load_balancer.alb-1.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}

resource "yandex_dns_recordset" "rs-2" {
  zone_id = yandex_dns_zone.alb-zone.id
  name    = "www"
  ttl     = 600
  type    = "CNAME"
  data    = [ var.domain ]
}
```
