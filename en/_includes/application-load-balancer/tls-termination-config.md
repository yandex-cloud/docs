```hcl
# Declaring variables with sensitive data

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key_path" {
  type = string
}

variable "domain" {
  type = string
}

variable "certificate" {
  type = string
}

variable "private_key" {
  type = string
}

# Declaring other variables

locals {
  sa_name          = "ig-sa"
  network_name     = "network-1"
  subnet_name_a    = "subnet-a"
  subnet_name_b    = "subnet-b"
  sg_name_balancer = "sg-balancer"
  sg_name_vms      = "sg-vms"
  cert_name        = "imported-cert"
  site_ig_name     = "site-ig"
  alb_bg_name      = "alb-bg"
  alb_host_name    = "alb-host"
  alb_router_name  = "alb-router"
  alb_name         = "alb"
  alb_zone_name    = "alb-zone"
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

# Creating a service account for an instance group

resource "yandex_iam_service_account" "ig-sa" {
  name        = local.sa_name
  description = "service account to manage IG"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
}

# Creating a cloud network

resource "yandex_vpc_network" "network-1" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "subnet-a" {
  name           = local.subnet_name_a
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.network-1.id
}

resource "yandex_vpc_subnet" "subnet-b" {
  name           = local.subnet_name_b
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = ["192.168.2.0/24"]
  network_id     = yandex_vpc_network.network-1.id
}

# Creating a static public IP address

resource "yandex_vpc_address" "stat_address" {
  name = "alb-static-address"
  external_ipv4_address {
    zone_id = "{{ region-id }}-a"
  }
}

# Creating security groups

resource "yandex_vpc_security_group" "sg-balancer" {
  name        = local.sg_name_balancer
  network_id  = yandex_vpc_network.network-1.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 65535
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
    protocol          = "TCP"
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 30080
 }
}

resource "yandex_vpc_security_group" "sg-vms" {
  name        = local.sg_name_vms
  network_id  = yandex_vpc_network.network-1.id

  ingress {
    protocol          = "TCP"
    description       = "balancer"
    security_group_id = yandex_vpc_security_group.sg-balancer.id
    port              = 80
    }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
}

# Importing the website’s TLS certificate

resource "yandex_cm_certificate" "imported-cert" {
  name    = local.cert_name

  self_managed {
    certificate = "${file("${var.certificate}")}"
    private_key = "${file("${var.private_key}")}"
  }
}

# Creating an instance group for a website

resource "yandex_compute_image" "lemp-image" {
  source_family = "lemp"
}

resource "yandex_compute_instance_group" "site-ig" {
  name                = local.site_ig_name
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  instance_template {
    platform_id = "standard-v2"
    resources {
      memory        = 1
      cores         = 2
      core_fraction = 5
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = yandex_compute_image.lemp-image.id
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.network-1.id
      subnet_ids         = [yandex_vpc_subnet.subnet-a.id,yandex_vpc_subnet.subnet-b.id]
      security_group_ids = [yandex_vpc_security_group.sg-vms.id]
      nat                = true
    }

    metadata = {
      user-data = "#cloud-config\nusers:\n  - name: ${var.vm_user}\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("${var.ssh_key_path}")}"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = ["{{ region-id }}-a","{{ region-id }}-b"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  application_load_balancer {
    target_group_name        = "alb-tg"
  }
}

# Creating a backend group

resource "yandex_alb_backend_group" "alb-bg" {
  name                     = local.alb_bg_name

  http_backend {
    name                   = "alb-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_compute_instance_group.site-ig.application_load_balancer[0].target_group_id]
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthcheck_port     = 80
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

# Creating an HTTP router

resource "yandex_alb_http_router" "alb-router" {
  name          = local.alb_router_name
}

resource "yandex_alb_virtual_host" "alb-host" {
  name                    = local.alb_host_name
  authority               = ["${var.domain}"]
  http_router_id          = yandex_alb_http_router.alb-router.id
  route {
    name                  = "alb-route"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.alb-bg.id
        timeout           = "60s"
      }
    }
  }
}    

# Creating an L7 load balancer

resource "yandex_alb_load_balancer" "alb" {
  name        = local.alb_name
  network_id  = yandex_vpc_network.network-1.id
  security_group_ids = [yandex_vpc_security_group.sg-balancer.id]

  allocation_policy {
    location {
      zone_id   = "{{ region-id }}-a"
      subnet_id = yandex_vpc_subnet.subnet-a.id
    }
    location {
      zone_id   = "{{ region-id }}-b"
      subnet_id = yandex_vpc_subnet.subnet-b.id
    }
  }

  listener {
    name = "list-http"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.stat_address.external_ipv4_address[0].address
        }
      }
    ports = [ 80 ]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "listener-http"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.stat_address.external_ipv4_address[0].address
        }
      }
      ports = [ 443 ]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.alb-router.id
        }
        certificate_ids = [yandex_cm_certificate.imported-cert.id]
      }
      sni_handler {
        name         = "mysite-sni"
        server_names = ["${var.domain}"]
        handler {
          http_handler {
            http_router_id = yandex_alb_http_router.alb-router.id
          }
          certificate_ids = [yandex_cm_certificate.imported-cert.id]
        }
      }
    }
  }
}

# Creating a DNS zone

resource "yandex_dns_zone" "alb-zone" {
  name        = local.alb_zone_name
  description = "Public zone"
  zone        = "${var.domain}."
  public      = true
}

# Creating a DNS zone resource record

resource "yandex_dns_recordset" "alb-record" {
  zone_id = yandex_dns_zone.alb-zone.id
  name    = "${var.domain}."
  ttl     = 600
  type    = "A"
  data    = [yandex_alb_load_balancer.alb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}
```