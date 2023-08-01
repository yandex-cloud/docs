```hcl
locals {
  zone             = "<default_availability_zone>"
  username         = "<VM_username>"
  ssh_key_path     = "<path_to_public_SSH_key>"
  target_folder_id = "<VM_target_folder>"
  registry_name    = "<registry_name>"
  sa_name          = "<service_account_name>"
  network_name     = "<cloud_network_name>"
  subnet_name      = "<subnet_name>"
  vm_name          = "<VM_name>"
  image_id         = "<image_ID>"
}

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

resource "yandex_container_registry" "my-registry" {
  name       = local.registry_name
  folder_id  = local.target_folder_id
  labels     = {
    my-label = "my-label-value"
  }
}

resource "yandex_iam_service_account" "registry-sa" {
  name      = local.sa_name
  folder_id = local.target_folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "registry-sa-role-images-puller" {
  folder_id = local.target_folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.registry-sa.id}"
}

resource "yandex_vpc_network" "docker-vm-network" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "docker-vm-network-subnet-a" {
  name           = local.subnet_name
  zone           = local.zone
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.docker-vm-network.id
}

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
    initialize_params {
      image_id = local.image_id
      size     = 5
    }
  }

  network_interface {
    subnet_id = "${yandex_vpc_subnet.docker-vm-network-subnet-a.id}"
    nat       = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${local.username}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${local.ssh_key_path}")}"
  }
}
```
