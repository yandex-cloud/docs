```hcl
# Declaring variables for custom parameters

variable "folder_id" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "domain_name" {
  type = string
}

# Adding other variables

locals {
  network_name       = "joomla-network"
  subnet_name1       = "joomla-subnet-a"
  subnet_name2       = "joomla-subnet-b"
  subnet_name3       = "joomla-subnet-d"
  subnet_cidr1       = "192.168.2.0/24"
  subnet_cidr2       = "192.168.1.0/24"
  subnet_cidr3       = "192.168.3.0/24" 
  sg_vm_name         = "joomla-sg"
  sg_pgsql_name      = "postgresql-sg"
  vm_name            = "joomla-web-server"
  cluster_name       = "joomla-pg-cluster"
  db_name            = "joomla_db"
  dns_zone_name      = "joomla-zone"
  vm_user            = "yc-user"
  db_user            = "joomla"
  cert_name          = "joomla-cert"
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

resource "yandex_vpc_network" "joomla-pg-network" {
  name = local.network_name
}

# Creating a subnet in the {{ region-id }}-a availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-a" {
  name           = local.subnet_name1
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = [local.subnet_cidr1]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a subnet in the {{ region-id }}-b availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-b" {
  name           = local.subnet_name2
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = [local.subnet_cidr2]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a subnet in the {{ region-id }}-d availability zone

resource "yandex_vpc_subnet" "joomla-pg-network-subnet-d" {
  name           = local.subnet_name3
  zone           = "{{ region-id }}-d"
  v4_cidr_blocks = [local.subnet_cidr3]
  network_id     = yandex_vpc_network.joomla-pg-network.id
}

# Creating a security group for a {{ PG }} database cluster

resource "yandex_vpc_security_group" "pgsql-sg" {
  name       = local.sg_pgsql_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  ingress {
    description    = "port-6432"
    port           = 6432
    protocol       = "TCP"
    v4_cidr_blocks = [local.subnet_cidr2]
  }

  ingress {
    description       = "self"
    protocol          = "ANY"
    from_port         = 0
    to_port           = 65535
    predefined_target = "self_security_group"
  }

  egress {
    description    = "any"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

}

# Creating a security group for a VM

resource "yandex_vpc_security_group" "vm-sg" {
  name       = local.sg_vm_name
  network_id = yandex_vpc_network.joomla-pg-network.id

  egress {
    description    = "any"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }

  ingress {
    description    = "http"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }

  ingress {
    description    = "https"
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }

  ingress {
    description    = "ssh"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }

  ingress {
    description       = "self"
    protocol          = "ANY"
    from_port         = 0
    to_port           = 65535
    predefined_target = "self_security_group"
  }
}

# Reserving a public IP address

resource "yandex_vpc_address" "addr" {
  name = "joomla-address"

  external_ipv4_address {
    zone_id = "{{ region-id }}-b"
  }
}


# Adding a prebuilt VM image

resource "yandex_compute_image" "joomla-pg-vm-image" {
  source_family = "ubuntu-2404-lts-oslogin"
}

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootvmdisk"
  type     = "network-hdd"
  zone     = "{{ region-id }}-b"
  size     = "10"
  image_id = yandex_compute_image.joomla-pg-vm-image.id
}

# Creating a VM instance

resource "yandex_compute_instance" "joomla-pg-vm" {
  name               = local.vm_name
  platform_id        = "standard-v3"
  zone               = "{{ region-id }}-b"

  resources {
    cores         = 2
    memory        = 4
  }

  boot_disk {
    disk_id = yandex_compute_disk.boot-disk.id
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.joomla-pg-network-subnet-b.id
    nat                = true
    nat_ip_address     = yandex_vpc_address.addr.external_ipv4_address[0].address
    security_group_ids = [ yandex_vpc_security_group.vm-sg.id ]
  }

  metadata = {
    user-data = "#cloud-config\nusers:\n  - name: ${local.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
  }
}

# Creating a {{ PG }} database cluster

resource "yandex_mdb_postgresql_cluster" "joomla-pg-cluster" {
  name                = local.cluster_name
  environment         = "PRODUCTION"
  network_id          = yandex_vpc_network.joomla-pg-network.id
  security_group_ids  = [ yandex_vpc_security_group.pgsql-sg.id ]

  config {
    version = "17"
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
    zone      = "{{ region-id }}-d"
    subnet_id = yandex_vpc_subnet.joomla-pg-network-subnet-d.id
  }
}

# Creating a database

resource "yandex_mdb_postgresql_database" "joomla-pg-tutorial-db" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = local.db_name
  owner      = local.db_user
}

# Creating a database user

resource "yandex_mdb_postgresql_user" "joomla-user" {
  cluster_id = yandex_mdb_postgresql_cluster.joomla-pg-cluster.id
  name       = local.db_user
  password   = var.db_password
}

# Creating a DNS zone

resource "yandex_dns_zone" "joomla-pg" {
  name    = local.dns_zone_name
  zone    = "${var.domain_name}."
  public  = true
}

# Adding a Let's Encrypt certificate

resource "yandex_cm_certificate" "le-certificate" {
  name    = local.cert_name
  domains = [var.domain_name]

  managed {
  challenge_type = "DNS_CNAME"
  challenge_count = 1
  }
}

# Creating CNAME records for domain validation when issuing a certificate

resource "yandex_dns_recordset" "validation-record" {
  count   = yandex_cm_certificate.le-certificate.managed[0].challenge_count
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_name
  type    = yandex_cm_certificate.le-certificate.challenges[count.index].dns_type
  ttl     = 600
  data    = [yandex_cm_certificate.le-certificate.challenges[count.index].dns_value]
}

# Creating a type A resource record

resource "yandex_dns_recordset" "joomla-pg-a" {
  zone_id = yandex_dns_zone.joomla-pg.id
  name    = "${yandex_dns_zone.joomla-pg.zone}"
  type    = "A"
  ttl     = 600
  data    = [ yandex_compute_instance.joomla-pg-vm.network_interface.0.nat_ip_address ]
}
```
