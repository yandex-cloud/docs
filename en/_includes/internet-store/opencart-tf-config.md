```hcl
# Declaring variables for confidential parameters

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

# Adding other variables

locals {
  network_name = "network-1"
  subnet_name1 = "subnet-1"
  subnet_name2 = "subnet-2"
  sg_db_name   = "opencart-sg"
  sg_vm_name   = "opencart-sg-vm"
  vm_name      = "opencart"
  cluster_name = "opencart"
  db_name      = "db1"
}

# Configuring the provider

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

resource "yandex_vpc_network" "network-1" {
  name = local.network_name
}

# Creating subnets

resource "yandex_vpc_subnet" "subnet-1" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

resource "yandex_vpc_subnet" "subnet-2" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.2.0/24"]
}

# Creating security groups

resource "yandex_vpc_security_group" "opencart-sg" {
  name       = local.sg_db_name
  network_id = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 3306
  }
}

resource "yandex_vpc_security_group" "opencart-sg-vm" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    description    = "HTTP"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
}

# Specifying a ready-made VM image

resource "yandex_compute_image" "opencart-image" {
  source_family = "opencart"
}

# Creating a VM instance

resource "yandex_compute_instance" "opencart" {
  name        = "opencart"
  platform_id = "standard-v3"
  zone        = "{{ region-id }}-a"

  resources {
    core_fraction = 20
    cores         = 2
    memory        = 4
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.opencart-image.id
      type     = "network-ssd"
      size     = "13"
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.subnet-1.id
    security_group_ids = [yandex_vpc_security_group.opencart-sg-vm.id]
    nat                = true
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Creating a cluster {{ MY }}
# If you do not need a cluster, delete the code block creating the {{ MY }} cluster, database, and user

resource "yandex_mdb_mysql_cluster" "opencart-mysql" {
  name               = local.cluster_name
  environment        = "PRODUCTION"
  network_id         = yandex_vpc_network.network-1.id
  version            = "8.0"
  security_group_ids = [yandex_vpc_security_group.opencart-sg.id]

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
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

# Creating a database for {{ MY }}


resource "yandex_mdb_mysql_database" "db1" {
  cluster_id = yandex_mdb_mysql_cluster.opencart-mysql.id
  name       = local.db_name
}

# Creating a user for {{ MY }}

resource "yandex_mdb_mysql_user" "user1" {
  cluster_id = yandex_mdb_mysql_cluster.opencart-mysql.id
  name       = var.db_user
  password   = var.db_password
  permission {
    database_name = yandex_mdb_mysql_database.db1.name
    roles         = ["ALL"]
  }
}
```
