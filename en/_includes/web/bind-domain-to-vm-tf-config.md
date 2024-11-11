```hcl
# Declaring variables for custom parameters

variable "folder_id" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

# Adding other variables

locals {
  network_name     = "webserver-network"
  subnet_name      = "webserver-subnet-{{ region-id }}-b"
  sg_name          = "webserver-sg"
  vm_name          = "mywebserver"
  domain_zone_name = "my-domain-zone"
}

# Configuring a provider 

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

# Creating a cloud network

resource "yandex_vpc_network" "webserver-network" {
  name = local.network_name
}

# Creating a subnet

resource "yandex_vpc_subnet" "webserver-subnet-b" {
  name           = local.subnet_name
  zone           = "{{ region-id }}-b"
  network_id     = "${yandex_vpc_network.webserver-network.id}"
  v4_cidr_blocks = ["192.168.1.0/24"]
}

# Creating a security group

resource "yandex_vpc_security_group" "webserver-sg" {
  name        = local.sg_name
  network_id  = "${yandex_vpc_network.webserver-network.id}"
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

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Creating a VM instance

resource "yandex_compute_instance" "mywebserver" {
  name        = local.vm_name
  platform_id = "standard-v2"
  zone        = "{{ region-id }}-b"

  resources {
    cores  = "2"
    memory = "2"
  }

  boot_disk {
    initialize_params {
      image_id = "fd8jtn9i7e9ha5q25niu"
    }
  }

  network_interface {
    subnet_id          = "${yandex_vpc_subnet.webserver-subnet-b.id}"
    nat                = true
    security_group_ids = ["${yandex_vpc_security_group.webserver-sg.id}"]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: yc-user\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Creating a DNS zone

resource "yandex_dns_zone" "my-domain-zone" {
  name    = local.domain_zone_name
  zone    = "${var.domain_name}."
  public  = true
}

# Creating a type А resource record

resource "yandex_dns_recordset" "rsА1" {
  zone_id = yandex_dns_zone.my-domain-zone.id
  name    = "${yandex_dns_zone.my-domain-zone.zone}"
  type    = "A"
  ttl     = 600
  data    = ["${yandex_compute_instance.mywebserver.network_interface.0.nat_ip_address}"]
}
```