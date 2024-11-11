
```hcl
# Declaring variables for custom parameters

variable "zone" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "vm_image_family" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "dns_zone" {
  type = string
}

# Adding other variables

locals {
  network_name       = "web-network"
  subnet_name        = "subnet1"
  sg_vm_name         = "sg-web"
  vm_name            = "lamp-vm"
  dns_zone_name      = "example-zone"
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
  folder_id = var.folder_id
}

# Creating a cloud network

resource "yandex_vpc_network" "network-1" {
  name = local.network_name
}

# Creating a subnet

resource "yandex_vpc_subnet" "subnet-1" {
  name           = local.subnet_name
  v4_cidr_blocks = ["192.168.1.0/24"]
  zone           = var.zone
  network_id     = yandex_vpc_network.network-1.id
}

# Creating a security group

resource "yandex_vpc_security_group" "sg-1" {
  name        = local.sg_vm_name
  network_id  = yandex_vpc_network.network-1.id
  egress {
    protocol       = "ANY"
    description    = "any"
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
}

# Adding a prebuilt VM image

resource "yandex_compute_image" "lamp-vm-image" {
  source_family = var.vm_image_family
}

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootvmdisk"
  type     = "network-hdd"
  zone     = "{{ region-id }}-a"
  size     = "20"
  image_id = yandex_compute_image.lamp-vm-image.id
}

# Creating a VM instance

resource "yandex_compute_instance" "vm-lamp" {
  name        = local.vm_name
  platform_id = "standard-v3"
  zone        = var.zone
  resources {
    core_fraction = 20
    cores         = 2
    memory        = 1
  }
  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.sg-1.id]
  }
  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Creating a DNS zone

resource "yandex_dns_zone" "zone1" {
  name    = local.dns_zone_name
  zone    = var.dns_zone
  public  = true
}

# Creating a type A resource record

resource "yandex_dns_recordset" "rs-a" {
  zone_id = yandex_dns_zone.zone1.id
  name    = var.dns_zone
  type    = "A"
  ttl     = 600
  data    = [ yandex_compute_instance.vm-lamp.network_interface.0.nat_ip_address ]
}

# Creating a CNAME resource record

resource "yandex_dns_recordset" "rs-cname" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "www"
  type    = "CNAME"
  ttl     = 600
  data    = [ var.dns_zone ]
}
```


