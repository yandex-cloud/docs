
```hcl
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

variable "db_user" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "dns_zone" {
  type = string
}

variable "dns_recordset_name" {
  type = string
}

# Adding other variables

locals {
  network_name       = "example-network"
  subnet_name1       = "subnet-1"
  subnet_name2       = "subnet-2"
  subnet_name3       = "subnet-3"
  sg_vm_name         = "sg-vm"
  sg_pgsql_name      = "sg-pgsql"
  vm_name            = "joomla-pg-tutorial-web"
  cluster_name       = "joomla-pg-tutorial-db-cluster"
  db_name            = "joomla-pg-tutorial-db"
  dns_zone_name      = "example-zone-1"
}

# Setting up the provider

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

resource "yandex_vpc_network" "joomla-pg-network" {
  name = local.network_name
}

# Creating a subnet in the {{ region-id }}-a availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-a" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = ["10.128.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a subnet in the {{ region-id }}-b availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-b" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = ["10.129.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a subnet in the {{ region-id }}-c availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-c" {
  name           = local.subnet_name3
  zone           = "{{ region-id }}-c"
  v4_cidr_blocks = ["10.130.0.0/24"]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a security group for the DB cluster {{ PG }}

resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = local.sg_pgsql_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  ingress {
    description    = "{{ PG }}"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating a security group for VM

resource "yandex_vpc_security_group" "vm-sg" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  egress {
    protocol       = "ANY"
    description    = "ANY"
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
    description    = "HTTPS"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    description    = "SSH"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Adding a ready-made VM image

resource "yandex_compute_image" "joomla-pg-vm-image" {
  source_family = "centos-stream-8"
}

# Creating a VM

resource "yandex_compute_instance" "joomla-pg-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = "{{ region-id }}-a"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = yandex_compute_image.joomla-pg-vm-image.id
      size     = 10
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
    nat                = true
    security_group_ids = [ yandex_vpc_security_group.vm-sg.id ]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Creating a DB cluster {{ PG }}

resource "yandex_mdb_postgresql_cluster" "joomla-pg-cluster" {
  name                = local.cluster_name
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.joomla-pg-network.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]

  config {
    version = "14"
    resources {
      resource_preset_id = "b2.medium"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
  }

  host {
    zone      = "{{ region-id }}-a"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-a.id
  }

  host {
    zone      = "{{ region-id }}-b"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
  }

  host {
    zone      = "{{ region-id }}-c"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-c.id
  }
}

# Creating a DB

resource "yandex_mdb_postgresql_database" "joomla-pg-tutorial-db" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = local.db_name
  owner      = var.db_user
}

# Creating a DB user

resource "yandex_mdb_postgresql_user" "joomla-user" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = var.db_user
  password   = var.db_password
}

# Creating a DNS zone

resource "yandex_dns_zone" "joomla-pg" {
  name    = local.dns_zone_name
  zone    = var.dns_zone
  public  = true
}

# Creating an A resource record

resource "yandex_dns_recordset" "joomla-pg-a" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = var.dns_recordset_name
  type    = "A"
  ttl     = 600
  data    = [ yandex_compute_instance.joomla-pg-vm.network_interface.0.nat_ip_address ]
}

# Creating a CNAME resource record

resource "yandex_dns_recordset" "joomla-pg-cname" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = "www"
  type    = "CNAME"
  ttl     = 600
  data    = [ var.dns_zone ]
}
```


