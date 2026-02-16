```hcl
# Объявление переменных для пользовательских параметров

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "vm_user_nat" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

# Добавление прочих переменных

locals {
  network_name     = "my-vpc"
  subnet_name1     = "public-subnet"
  subnet_name2     = "private-subnet"
  sg_nat_name      = "nat-instance-sg"
  vm_test_name     = "test-vm"
  vm_nat_name      = "nat-instance"
  route_table_name = "nat-instance-route"
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
  folder_id = var.folder_id
}

# Создание облачной сети

resource "yandex_vpc_network" "my-vpc" {
  name = local.network_name
}

# Создание подсетей

resource "yandex_vpc_subnet" "public-subnet" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.my-vpc.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "private-subnet" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.my-vpc.id
  v4_cidr_blocks = ["192.168.2.0/24"]
  route_table_id = yandex_vpc_route_table.nat-instance-route.id
}

# Создание группы безопасности

resource "yandex_vpc_security_group" "nat-instance-sg" {
  name       = local.sg_nat_name
  network_id = yandex_vpc_network.my-vpc.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
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
}

# Добавление готового образа ВМ

resource "yandex_compute_image" "ubuntu-1804-lts" {
  source_family = "ubuntu-1804-lts"
}

resource "yandex_compute_image" "nat-instance-ubuntu" {
  source_family = "nat-instance-ubuntu"
}

# Создание загрузочных дисков

resource "yandex_compute_disk" "boot-disk-ubuntu" {
  name     = "boot-disk-ubuntu"
  type     = "network-hdd"
  zone     = "{{ region-id }}-a"
  size     = "20"
  image_id = yandex_compute_image.ubuntu-1804-lts.id
}

resource "yandex_compute_disk" "boot-disk-nat" {
  name     = "boot-disk-nat"
  type     = "network-hdd"
  zone     = "{{ region-id }}-a"
  size     = "20"
  image_id = yandex_compute_image.nat-instance-ubuntu.id
}

# Создание ВМ

resource "yandex_compute_instance" "test-vm" {
  name        = local.vm_test_name
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-ubuntu.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private-subnet.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание ВМ NAT

resource "yandex_compute_instance" "nat-instance" {
  name        = local.vm_nat_name
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk-nat.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public-subnet.id
    security_group_ids = [yandex_vpc_security_group.nat-instance-sg.id]
    nat                = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user_nat}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание таблицы маршрутизации и статического маршрута

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.my-vpc.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nat-instance.network_interface.0.ip_address
  }
}
```
