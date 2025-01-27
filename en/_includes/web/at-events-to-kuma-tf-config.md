```hcl
# Configuring a provider

terraform {
  required_providers {
    yandex    = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  folder_id = var.folder_id
}

# Declaring variables for custom parameters

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "object_prefix" {
  type = string
}

# Adding other variables

locals {
  sa_bucket_name = "kuma-bucket-sa"
  sa_trail_name  = "kuma-trail-sa"
  sym_key_name   = "kuma-key"
  trail_name     = "kuma-trail"
  zone           = "{{ region-id }}-b"
  network_name   = "kuma-network"
  subnet_name    = "kuma-network-{{ region-id }}-b"
  vm_name        = "kuma-server"
  image_id       = "fd8ulbhv5dpakf3io1mf"
}

# Creating service accounts

resource "yandex_iam_service_account" "sa-bucket" {
  name        = local.sa_bucket_name
  folder_id   = "${var.folder_id}"
}

resource "yandex_iam_service_account" "sa-trail" {
  name        = local.sa_trail_name
  folder_id   = "${var.folder_id}"
}

# Creating a static access key

resource "yandex_iam_service_account_static_access_key" "sa-bucket-static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
}

output "access_key" {
  value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.access_key
  sensitive = true
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.sa-bucket-static-key.secret_key
  sensitive = true
}

# Creating a symmetric encryption key

resource "yandex_kms_symmetric_key" "sym_key" {
  name              = local.sym_key_name
  default_algorithm = "AES_256"
}

# Assigning roles to service accounts

resource "yandex_resourcemanager_folder_iam_member" "sa-bucket-storage-viewer" {
  folder_id   = "${var.folder_id}"
  role        = "storage.admin"
  member      = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-trail-storage-uploader" {
  folder_id   = "${var.folder_id}"
  role        = "storage.uploader"
  member      = "serviceAccount:${yandex_iam_service_account.sa-trail.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa-trail-at-viewer" {
  folder_id   = "${var.folder_id}"
  role        = "audit-trails.admin"
  member      = "serviceAccount:${yandex_iam_service_account.sa-trail.id}"
}

resource "yandex_kms_symmetric_key_iam_binding" "encrypter-decrypter" {
  symmetric_key_id = "${yandex_kms_symmetric_key.sym_key.id}"
  role             = "kms.keys.encrypterDecrypter"
  members          = [
    "serviceAccount:${yandex_iam_service_account.sa-bucket.id}","serviceAccount:${yandex_iam_service_account.sa-trail.id}"
  ]
}

# Creating a bucket

resource "yandex_storage_bucket" "kuma-bucket" {
  folder_id = "${var.folder_id}"
  bucket                = "${var.bucket_name}"
  default_storage_class = "standard"
  anonymous_access_flags {
    read        = false
    list        = false
    config_read = false
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = "${yandex_kms_symmetric_key.sym_key.id}"
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Creating a trail

resource "yandex_audit_trails_trail" "kuma-trail" {
  depends_on         = [yandex_storage_bucket.kuma-bucket, yandex_resourcemanager_folder_iam_member.sa-trail-at-viewer, yandex_resourcemanager_folder_iam_member.sa-trail-storage-uploader]
  name               = local.trail_name
  folder_id          = "${var.folder_id}"
  service_account_id = "${yandex_iam_service_account.sa-trail.id}"
  storage_destination {
    bucket_name   = "${var.bucket_name}"
    object_prefix = "${var.object_prefix}"
  }
  filtering_policy {
    management_events_filter {
      resource_scope {
        resource_id   = "${var.folder_id}"
        resource_type = "resource-manager.folder"
      }
    }
  }
}

# Creating a cloud network and a subnet

resource "yandex_vpc_network" "kuma-network" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "kuma-network-subnet-b" {
  name           = local.subnet_name
  zone           = local.zone
  v4_cidr_blocks = ["10.1.0.0/24"]
  network_id     = yandex_vpc_network.kuma-network.id
}

# Creating a VM instance

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootvmdisk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "20"
  image_id = local.image_id
}

resource "yandex_compute_instance" "kuma-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = local.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kuma-network-subnet-b.id
    nat                = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}
```