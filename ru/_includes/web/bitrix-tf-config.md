```hcl
# Объявление переменных для конфиденциальных параметров

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "mysql_user" {
  type = string
}

variable "mysql_password" {
  type = string
  sensitive = true
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
  zone = var.folder_id
}

# Создание облачной сети и подсетей

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

resource "yandex_vpc_subnet" "subnet-3" {
  name           = "subnet3"
  zone           = "{{ region-id }}-d"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.3.0/24"]
}

# Создание групп безопасности

resource "yandex_vpc_security_group" "sg-vm" {
  name        = "bitrix-sg-vm"
  description = "Description for security group"
  network_id  = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "TCP"
    description    = "EXT-HTTP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "EXT-SSH"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "EXT-HTTPS"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}

resource "yandex_vpc_security_group" "sg-mysql" {
  name        = "bitrix-sg"
  description = "Security group for mysql"
  network_id  = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-msql"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
  }
}

# Добавление готового образа ВМ

data "yandex_compute_image" "ubuntu-image" {
  family = "ubuntu-2204-lts"
}

# Создание загрузочного диска

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootdisk"
  type     = "network-ssd"
  zone     = "{{ region-id }}-a"
  size     = "24"
  image_id = data.yandex_compute_image.ubuntu-image.id
}

# Создание ВМ

resource "yandex_compute_instance" "vm-bitrix" {
  name        = "bitrixwebsite"
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = ["${yandex_vpc_security_group.sg-vm.id}"]
    nat                = true
  }

  metadata = {
     user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание кластера Managed Service for MySQL

resource "yandex_mdb_mysql_cluster" "bitrix-cluster" {
  name               = "BitrixMySQL"
  environment        = "PRESTABLE"
  network_id         = yandex_vpc_network.network-1.id
  version            = "8.0"
  security_group_ids = ["${yandex_vpc_security_group.sg-mysql.id}"]

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-hdd"
    disk_size          = "10"
  }

  host {
    zone             = "{{ region-id }}-a"
    subnet_id        = yandex_vpc_subnet.subnet-1.id
    assign_public_ip = false
  }

  host {
    zone             = "{{ region-id }}-b"
    subnet_id        = yandex_vpc_subnet.subnet-2.id
    assign_public_ip = false
  }
}

# Создание БД MySQL

resource "yandex_mdb_mysql_database" "bitrix-db" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = "db1"
}

# Создание пользователя БД

resource "yandex_mdb_mysql_user" "bitrix-user" {
  cluster_id = yandex_mdb_mysql_cluster.bitrix-cluster.id
  name       = var.mysql_user
  password   = var.mysql_password
  permission {
    database_name = yandex_mdb_mysql_database.bitrix-db.name
    roles         = ["ALL"]
  }
}
```
