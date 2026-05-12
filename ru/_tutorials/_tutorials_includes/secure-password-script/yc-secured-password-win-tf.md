```hcl
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

# Объявление переменных для конфиденциальных параметров

variable "zone" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "admin_pass" {
  type = string
  sensitive = true
}

variable "username" {
  type = string
}

variable "user_pass" {
  type = string
  sensitive = true
}

variable "image_family" {
  type = string
}

# Создание облачной сети и подсети

resource "yandex_vpc_network" "network-1" {
  name = "win-network"
}

# Создание подсети

resource "yandex_vpc_subnet" "subnet-a" {
  name           = "win-subnet"
  zone           = var.zone
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.network-1.id
}

# Создание группы безопасности

resource "yandex_vpc_security_group" "vm-sg" {
  name        = "vm_security_group"
  network_id  = yandex_vpc_network.network-1.id
  egress {
    protocol       = "ANY"
    description    = "any"
    from_port      = 0
    to_port        =  65535
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
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3389
  }
}

# Создание сервисного аккаунта

resource "yandex_iam_service_account" "my-sa" {
  name = "win-secret-sa"
}

# Назначение прав сервисному аккаунту

resource "yandex_resourcemanager_folder_iam_member" "view-keys" {
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.my-sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "view-payload" {
  folder_id = var.folder_id
  role      = "lockbox.payloadViewer"
  member    = "serviceAccount:${yandex_iam_service_account.my-sa.id}"
}

# Создание симметричного KMS-ключа шифрования

resource "yandex_kms_symmetric_key" "key-a" {
  name                = "win-secret-key"
  default_algorithm   = "AES_128"
  rotation_period     = "8760h"
}

# Создание секрета

resource "yandex_lockbox_secret" "win_secret" {
    name                = "win-secret"
    folder_id           = var.folder_id
    kms_key_id          = yandex_kms_symmetric_key.key-a.id
}

# Создание версии секрета

resource "yandex_lockbox_secret_version_hashed" "win_secret_version" {
  secret_id = yandex_lockbox_secret.win_secret.id
  key_1        = "Administrator"
  text_value_1 = var.admin_pass
  key_2        = var.username
  text_value_2 = var.user_pass
}

# Создание загрузочного диска для ВМ

data "yandex_compute_image" "default" {
  family = var.image_family
}

resource "yandex_compute_disk" "boot-disk" {
  type     = "network-ssd"
  zone     = var.zone
  size     = "100"
  image_id = data.yandex_compute_image.default.id
}

# Создание ВМ

resource "yandex_compute_instance" "my-vm" {
  name               = "win-test"
  platform_id        = "standard-v2"
  zone               = var.zone
  service_account_id = yandex_iam_service_account.my-sa.id

  resources {
    cores  = "2"
    memory = "4"
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-a.id
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.vm-sg.id}"]
  }

  metadata = {
    serial-port-enable = 1
    user-data = templatefile("script.tpl", { MYSECRET_ID = yandex_lockbox_secret.win_secret.id })
  } 
}
```
