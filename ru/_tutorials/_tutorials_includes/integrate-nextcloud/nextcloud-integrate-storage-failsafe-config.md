```hcl
# Объявление переменных

variable "folder_id" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "db_password" {
  type = string
  sensitive  = true
}

variable "domain_name" {
  type = string
}

locals {
  sa_name             = "nextcloud-sa"
  network_name        = "nextcloud-network"
  subnet_a_name       = "nextcloud-subnet-{{ region-id }}-a"
  subnet_b_name       = "nextcloud-subnet-{{ region-id }}-b"
  subnet_d_name       = "nextcloud-subnet-{{ region-id }}-d"
  subnet-a-cidr       = "192.168.11.0/24"
  subnet-b-cidr       = "192.168.12.0/24"
  subnet-d-cidr       = "192.168.13.0/24"
  sg_name             = "nextcloud-sg"
  gw_name             = "nextcloud-gateway"
  vm_name             = "nextcloud-vm"
  vm_image_id         = "fd8vsghfu10ev5gdatkh"
  ig_name             = "nextcloud-instance-group"
  cluster_name        = "nextcloud-db-cluster"
  db_name             = "nextcloud"
  db_username         = "user"
  domain_zone_name    = "nexcloud-domain-zone"
  certificate_name    = "mymanagedcert"
  snapshot_name       = "nextcloud-vm-snapshot"
  tg_name             = "nextcloud-target-group"
  backend_name        = "nextcloud-backend"
  bg_name             = "nextcloud-bg"
  http_router_name    = "nextcloud-router"
  vh_name             = "nextcloud-vh"
  route_name          = "nextcloud-route"
  alb_name            = "nextcloud-alb"
  listener_name       = "nextcloud-listener"
}

# Настройка провайдера

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  folder_id = var.folder_id
}

# Создание сети

resource "yandex_vpc_network" "nextcloud-network" {
  name = local.network_name
}

# Создание NAT-шлюза

resource "yandex_vpc_gateway" "nextcloud-gw" {
  name = local.gw_name
  shared_egress_gateway {}
}

# Создание таблицы маршрутизации

resource "yandex_vpc_route_table" "nextcloud-rt-table" {
  network_id  = yandex_vpc_network.nextcloud-network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nextcloud-gw.id
  }
}

# Создание подсетей

resource "yandex_vpc_subnet" "nextcloud-subnet-a" {
  name           = local.subnet_a_name
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.nextcloud-network.id
  v4_cidr_blocks = [local.subnet-a-cidr]
  route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
}

resource "yandex_vpc_subnet" "nextcloud-subnet-b" {
  name           = local.subnet_b_name
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.nextcloud-network.id
  v4_cidr_blocks = [local.subnet-b-cidr]
  route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
}

resource "yandex_vpc_subnet" "nextcloud-subnet-d" {
  name           = local.subnet_d_name
  zone           = "{{ region-id }}-d"
  network_id     = yandex_vpc_network.nextcloud-network.id
  v4_cidr_blocks = [local.subnet-d-cidr]
  route_table_id = yandex_vpc_route_table.nextcloud-rt-table.id
}

# Создание группы безопасности

resource "yandex_vpc_security_group" "nextcloud-sg" {
  name        = local.sg_name
  network_id  = yandex_vpc_network.nextcloud-network.id

  ingress {
    protocol       = "TCP"
    description    = "http"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "ANY"
    description    = "self"
    predefined_target = "self_security_group"
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "ANY"
    description    = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    from_port      = 0
    to_port        = 65535
  }

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Создание сервисного аккаунта

resource "yandex_iam_service_account" "nextcloud-sa" {
  name = local.sa_name
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.nextcloud-sa.id}"
}

# Создание статического ключа доступа для СА

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.nextcloud-sa.id
}

# Создание бакета

resource "yandex_storage_bucket" "nextcloud-bucket" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.bucket_name
}

# Создание загрузочного диска для ВМ

resource "yandex_compute_disk" "boot-disk" {
  type     = "network-ssd"
  zone     = "{{ region-id }}-a"
  size     = "24"
  image_id = local.vm_image_id
}

# Создание ВМ

resource "yandex_compute_instance" "nextcloud-vm" {
  name        = local.vm_name
  platform_id = "standard-v2"
  zone        = "{{ region-id }}-a"

  resources {
    cores  = "2"
    memory = "4"
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.nextcloud-subnet-a.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file(var.ssh_key_path)}"
  }
}

# Создание кластера MySQL

resource "yandex_mdb_mysql_cluster" "nextcloud-cluster" {
  name        = local.cluster_name
  environment = "PRODUCTION"
  network_id  = yandex_vpc_network.nextcloud-network.id
  version     = "8.0"
  security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 10
  }

  host {
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.nextcloud-subnet-a.id
  }

  host {
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.nextcloud-subnet-b.id
  }

  host {
    zone      = "{{ region-id }}-d"
    subnet_id = yandex_vpc_subnet.nextcloud-subnet-d.id
  }

  mysql_config = {
    sql_mode             = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    character_set_server = "utf8mb4"
    collation_server     = "utf8mb4_general_ci"
  }
}

# Создание базы данных в кластере MySQL

resource "yandex_mdb_mysql_database" "nextcloud-db" {
  cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
  name       = local.db_name
}

# Создание пользователя БД в кластере MySQL

resource "yandex_mdb_mysql_user" "my_user" {
  cluster_id = yandex_mdb_mysql_cluster.nextcloud-cluster.id
  name       = local.db_username
  password   = var.db_password

  permission {
    database_name = yandex_mdb_mysql_database.nextcloud-db.name
    roles         = ["ALL"]
  }
}

# Создание снимка диска

resource "yandex_compute_snapshot" "nextcloud-snapshot" {
  name           = local.snapshot_name
  source_disk_id = yandex_compute_disk.boot-disk.id
}

# Создание публичной DNS-зоны

resource "yandex_dns_zone" "nextcloud-domain-zone" {
  name    = local.domain_zone_name
  zone    = "${var.domain_name}."
  public  = true
}

# Добавление сертификата Let's Encrypt

resource "yandex_cm_certificate" "nextcloud-certificate" {
  name    = local.certificate_name
  domains = [var.domain_name]

  managed {
  challenge_type = "DNS_CNAME"
  challenge_count = 1
  }
}

# Создание CNAME-записей для валидации доменов при выпуске сертификата

resource "yandex_dns_recordset" "validation-record" {
  count   = yandex_cm_certificate.nextcloud-certificate.managed[0].challenge_count
  zone_id = yandex_dns_zone.nextcloud-domain-zone.id
  name    = yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_name
  type    = yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_type
  ttl     = 600
  data    = [yandex_cm_certificate.nextcloud-certificate.challenges[count.index].dns_value]
}

# Ожидание валидации домена и выпуска сертификата Let's Encrypt

data "yandex_cm_certificate" "wait-nextcloud-certificate" {
  depends_on      = [yandex_dns_recordset.validation-record]
  certificate_id  = yandex_cm_certificate.nextcloud-certificate.id
  wait_validation = true
}

# Создание группы виртуальных машин

resource "yandex_compute_instance_group" "nextcloud-ig" {
  name                = local.ig_name
  service_account_id  = yandex_iam_service_account.nextcloud-sa.id
  instance_template {
    platform_id = "standard-v2"
    resources {
      memory = 4
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        snapshot_id = yandex_compute_snapshot.nextcloud-snapshot.id
        size     = 24
      }
    }

    network_interface {
      subnet_ids         = [yandex_vpc_subnet.nextcloud-subnet-a.id,yandex_vpc_subnet.nextcloud-subnet-b.id,yandex_vpc_subnet.nextcloud-subnet-d.id]
      security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]
    }

    metadata = {
      ssh-keys = "yc-user:${file(var.ssh_key_path)}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["{{ region-id }}-a","{{ region-id }}-b","{{ region-id }}-d"]
  }

  deploy_policy {
    max_unavailable = 2
    max_expansion   = 1
  }

  application_load_balancer {
    target_group_name = local.tg_name
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.editor
  ]
}

# Создаем группу бэкендов

resource "yandex_alb_backend_group" "nextcloud-backend-group" {
  name = local.bg_name

  session_affinity {
    connection {
      source_ip = true
    }
  }

  http_backend {
    name             = local.backend_name
    weight           = 1
    port             = 80
    target_group_ids = [yandex_compute_instance_group.nextcloud-ig.application_load_balancer[0].target_group_id]
    load_balancing_config {
      mode = "MAGLEV_HASH"
    }
  }
}

# Создаем HTTP-роутер

resource "yandex_alb_http_router" "nextcloud-router" {
  name = local.http_router_name
}

# Создаем виртуальный хост

resource "yandex_alb_virtual_host" "nextcloud-vhost" {
  name           = local.vh_name
  http_router_id = yandex_alb_http_router.nextcloud-router.id
  route {
    name = local.route_name
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.nextcloud-backend-group.id
        timeout          = "60s"
      }
    }
  }
}

# Создаем L7-балансировщик

resource "yandex_alb_load_balancer" "nextcloud-alb" {
  name = local.alb_name

  network_id = yandex_vpc_network.nextcloud-network.id

  allocation_policy {
    location {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.nextcloud-subnet-a.id
    }
    location {
      zone_id   = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.nextcloud-subnet-b.id
    }
    location {
      zone_id   = "{{ region-id }}-d"
      subnet_id = yandex_vpc_subnet.nextcloud-subnet-d.id
    }
  }

  security_group_ids = [yandex_vpc_security_group.nextcloud-sg.id]

  listener {
    name = local.listener_name
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [443]
    }

    tls {
      default_handler {
        certificate_ids = [data.yandex_cm_certificate.wait-nextcloud-certificate.id]
        http_handler {
          http_router_id = yandex_alb_http_router.nextcloud-router.id
        }
      }
    }
  }
}

# Создание ресурсной A-записи для L7-балансировщика

resource "yandex_dns_recordset" "nextcloud-a-record" {
  zone_id = yandex_dns_zone.nextcloud-domain-zone.id
  name    = yandex_dns_zone.nextcloud-domain-zone.zone
  type    = "A"
  ttl     = 600
  data    = [yandex_alb_load_balancer.nextcloud-alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}
```