```hcl
# Объявление переменных

variable "folder_id" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

locals {
  network_name    = "cr-private-net"
  subnet_name     = "cr-private-subnet"
  subnet_cidr     = "192.168.10.0/24"
  storage_pe_addr = "storage-pe-address"
  storage_pe_ip   = "192.168.10.10"
  cr_pe_addr      = "cr-pe-address"
  cr_pe_ip        = "192.168.10.11"
  vm_addr         = "private-vm-address"
  vm_ip           = "192.168.10.20"
  registry_name   = "cr-private-demo"
  sa_name         = "cr-pusher"
  storage_pe_name = "storage-pe"
  cr_pe_name      = "cloud-registry-pe"
  private_vm_name = "cr-private-vm"
  jump_vm_name    = "jump-vm"
  zone            = "{{ region-id }}-a"
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

# Получение образа {{ coi }}

data "yandex_compute_image" "coi" {
  family    = "container-optimized-image"
  folder_id = "standard-images"
}

# Получение образа Ubuntu 24.04

data "yandex_compute_image" "ubuntu" {
  family    = "ubuntu-2404-lts-oslogin"
  folder_id = "standard-images"
}

# Создание облачной сети

resource "yandex_vpc_network" "cr_private_net" {
  name = local.network_name
}

# Создание подсети

resource "yandex_vpc_subnet" "cr_private_subnet" {
  name           = local.subnet_name
  zone           = local.zone
  network_id     = yandex_vpc_network.cr_private_net.id
  v4_cidr_blocks = [local.subnet_cidr]
}

# Резервирование IP-адреса для сервисного подключения {{ objstorage-name }}

resource "yandex_vpc_address" "storage_pe_address" {
  name = local.storage_pe_addr

  internal_ipv4_address {
    subnet_id = yandex_vpc_subnet.cr_private_subnet.id
    address   = local.storage_pe_ip
  }
}

# Резервирование IP-адреса для сервисного подключения {{ cloud-registry-name }}

resource "yandex_vpc_address" "cr_pe_address" {
  name = local.cr_pe_addr

  internal_ipv4_address {
    subnet_id = yandex_vpc_subnet.cr_private_subnet.id
    address   = local.cr_pe_ip
  }
}

# Резервирование IP-адреса для тестовой виртуальной машины

resource "yandex_vpc_address" "private_vm_address" {
  name = local.vm_addr

  internal_ipv4_address {
    subnet_id = yandex_vpc_subnet.cr_private_subnet.id
    address   = local.vm_ip
  }
}

# Создание реестра {{ cloud-registry-name }}

resource "yandex_cloudregistry_registry" "cr_private_demo" {
  name      = local.registry_name
  folder_id = var.folder_id
  kind      = "DOCKER"
  type      = "LOCAL"
}

# Создание сервисного аккаунта

resource "yandex_iam_service_account" "cr_pusher" {
  name = local.sa_name
}

# Назначение роли сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "cr_pusher_role" {
  folder_id = var.folder_id
  role      = "cloud-registry.artifacts.pusher"
  member    = "serviceAccount:${yandex_iam_service_account.cr_pusher.id}"
}

# Создание сервисного подключения {{ objstorage-name }}

resource "yandex_vpc_private_endpoint" "storage_pe" {
  name         = local.storage_pe_name
  network_id   = yandex_vpc_network.cr_private_net.id
  service_name = "yandex.cloud.storage"

  dns_options {
    private_dns_records_enabled = true
  }

  endpoint_address {
    address_id = yandex_vpc_address.storage_pe_address.id
  }
}

# Создание сервисного подключения {{ cloud-registry-name }}

resource "yandex_vpc_private_endpoint" "cloud_registry_pe" {
  name         = local.cr_pe_name
  network_id   = yandex_vpc_network.cr_private_net.id
  service_name = "yandex.cloud.registry"

  dns_options {
    private_dns_records_enabled = true
  }

  endpoint_address {
    address_id = yandex_vpc_address.cr_pe_address.id
  }

  depends_on = [yandex_vpc_private_endpoint.storage_pe]
}

# Создание тестовой виртуальной машины

resource "yandex_compute_instance" "cr_private_vm" {
  name               = local.private_vm_name
  hostname           = local.private_vm_name
  platform_id        = "standard-v2"
  zone               = local.zone
  service_account_id = yandex_iam_service_account.cr_pusher.id

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.coi.id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.cr_private_subnet.id
    ip_address = yandex_vpc_address.private_vm_address.internal_ipv4_address[0].address
    nat        = false
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Создание промежуточной виртуальной машины

resource "yandex_compute_instance" "jump_vm" {
  name        = local.jump_vm_name
  hostname    = local.jump_vm_name
  platform_id = "standard-v2"
  zone        = local.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.cr_private_subnet.id
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Вывод идентификатора реестра {{ cloud-registry-name }}

output "registry_id" {
  description = "{{ cloud-registry-name }} ID"
  value       = yandex_cloudregistry_registry.cr_private_demo.id
}

# Вывод публичного IP-адреса промежуточной виртуальной машины

output "jump_vm_public_ip" {
  description = "Public IP address of jump VM"
  value       = yandex_compute_instance.jump_vm.network_interface[0].nat_ip_address
}
```
