```hcl
# Configuring the provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = "{{ region-id }}-a"
}

# Creating a service account

resource "yandex_iam_service_account" "my_sa" {
  name = "backup-sa"
}

# Assigning roles to a service account

resource "yandex_resourcemanager_folder_iam_member" "my_binding" {
  folder_id = yandex_iam_service_account.my_sa.folder_id
  role      = "backup.editor"
  member    = "serviceAccount:${yandex_iam_service_account.my_sa.id}"
}

# Creating a cloud network

resource "yandex_vpc_network" "my_backup_network" {
  name = "cloud-network"
}

# Creating a cloud subnet

resource "yandex_vpc_subnet" "my_backup_subnet" {
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.my_backup_network.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}

# Creating a security group
# https://yandex.cloud/ru/docs/backup/concepts/vm-connection#vm-network-access

resource "yandex_vpc_security_group" "my_backup_security_group" {
  name       = "backup-sg"
  network_id = yandex_vpc_network.my_backup_network.id
  egress {
    protocol       = "TCP"
    from_port      = 7770
    to_port        = 7800
    v4_cidr_blocks = ["84.47.172.0/24"]
  }
  egress {
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["213.180.204.0/24", "213.180.193.0/24", "178.176.128.0/24", "84.201.181.0/24", "84.47.172.0/24"]
  }
  egress {
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["213.180.204.0/24", "213.180.193.0/24"]
  }
  egress {
    protocol       = "TCP"
    port           = 8443
    v4_cidr_blocks = ["84.47.172.0/24"]
  }
  egress {
    protocol       = "TCP"
    port           = 44445
    v4_cidr_blocks = ["51.250.1.0/24"]
  }
  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Getting information about an image for a VM boot disk

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

# Creating a VM boot disk

resource "yandex_compute_disk" "boot-disk" {
  type     = "network-ssd"
  zone     = "{{ region-id }}-a"
  size     = "20"
  image_id = data.yandex_compute_image.ubuntu.id
}

# Creating a VM

resource "yandex_compute_instance" "my_backup_compute" {
  name               = "backup-instance"
  platform_id        = "standard-v3"
  zone               = "{{ region-id }}-a"
  service_account_id = yandex_iam_service_account.my_sa.id
  network_interface {
    subnet_id          = yandex_vpc_subnet.my_backup_subnet.id
    security_group_ids = [yandex_vpc_security_group.my_backup_security_group.id]
    nat                = true
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  resources {
    cores  = 2
    memory = 4
  }

  metadata = {
    user-data = "${file("cloud-init.yaml")}"
  }
}

# Creating a backup policy

resource "yandex_backup_policy" "my_policy" {
  name                = "weekly-backup"
  fast_backup_enabled = true
  retention {
    after_backup = false
  }
  reattempts {
    enabled      = true
    interval     = "1m"
    max_attempts = 10
  }
  scheduling {
    scheme            = "ALWAYS_INCREMENTAL"
    weekly_backup_day = "FRIDAY"
    backup_sets {
      execute_by_time {
        repeat_at = ["03:00"]
        type      = "WEEKLY"
        weekdays  = ["FRIDAY"]
      }
    }
  }
  vm_snapshot_reattempts {
    enabled      = true
    interval     = "1m"
    max_attempts = 10
  }
}

# Associating a backup policy with a VM

resource "yandex_backup_policy_bindings" "my_backup_binding" {
  instance_id = yandex_compute_instance.my_backup_compute.id
  policy_id   = yandex_backup_policy.my_policy.id
}
```