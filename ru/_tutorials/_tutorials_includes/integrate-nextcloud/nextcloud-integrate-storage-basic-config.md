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
  subnet-a-cidr       = "192.168.11.0/24"
  sg_name             = "nextcloud-sg"
  gw_name             = "nextcloud-gateway"
  vm_name             = "nextcloud-vm"
  vm_image_id         = "fd8vsghfu10ev5gdatkh"
  ig_name             = "nexcloud-ig"
  cluster_name        = "nextcloud-db-cluster"
  db_name             = "nextcloud"
  db_username         = "user"
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

# Создание подсети

resource "yandex_vpc_subnet" "nextcloud-subnet-a" {
  name           = local.subnet_a_name
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.nextcloud-network.id
  v4_cidr_blocks = [local.subnet-a-cidr]
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

# Вывод данных статического ключа доступа на экран

output "Access_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.access_key
}

output "Secret_key" {
  value = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive = true
}
```