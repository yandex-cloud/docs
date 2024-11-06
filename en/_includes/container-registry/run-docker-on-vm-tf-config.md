```hcl
# Declaring variables for confidential parameters

locals {
  zone             = "<default_availability_zone>"
  username         = "<VM_user_name>"
  ssh_key_path     = "<path_to_public_SSH_key>"
  target_folder_id = "<ID_of_folder_to_place_VM_in>"
  registry_name    = "<registry_name>"
  sa_name          = "<service_account_name>"
  network_name     = "<cloud_network_name>"
  subnet_name      = "<subnet_name>"
  vm_name          = "<VM_name>"
  image_id         = "<image_ID>"
}

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
  zone = local.zone
}

# Creating a Container Registry repository

resource "yandex_container_registry" "my-registry" {
  name       = local.registry_name
  folder_id  = local.target_folder_id
}

# Creating a service account

resource "yandex_iam_service_account" "registry-sa" {
  name      = local.sa_name
  folder_id = local.target_folder_id
}

# Assigning roles to a service account

resource "yandex_resourcemanager_folder_iam_member" "registry-sa-role-images-puller" {
  folder_id = local.target_folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.registry-sa.id}"
}

# Creating a cloud network

resource "yandex_vpc_network" "docker-vm-network" {
  name = local.network_name
}

# Creating a subnet

resource "yandex_vpc_subnet" "docker-vm-network-subnet-a" {
  name           = local.subnet_name
  zone           = local.zone
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.docker-vm-network.id
}

# Creating a boot disk

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootvmdisk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "10"
  image_id = local.image_id
}

# Creating a VM instance

resource "yandex_compute_instance" "docker-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = local.zone
  service_account_id = "${yandex_iam_service_account.registry-sa.id}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.docker-vm-network-subnet-a.id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${local.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${local.ssh_key_path}")}"
  }
}
```