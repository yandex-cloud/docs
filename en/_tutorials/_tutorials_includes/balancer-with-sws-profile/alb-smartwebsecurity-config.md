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

variable "allowed_ip" {
  type = string
}

# Adding other variables

locals {
  zone               = "{{ region-id }}-a"
  network_name       = "web-network"
  subnet_name        = "subnet1"
  sg_vm_name         = "sg-web"
  vm_name            = "test-vm1"
  vm_image_family    = "lemp"
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

# Creating a subnet

resource "yandex_vpc_subnet" "subnet-1" {
  name           = local.subnet_name
  v4_cidr_blocks = ["192.168.1.0/24"]
  zone           = local.zone
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
    from_port      = 1
    to_port        = 65535
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

# Adding a prebuilt VM image

resource "yandex_compute_image" "lamp-vm-image" {
  source_family = local.vm_image_family
}

resource "yandex_compute_disk" "boot-disk" {
  name     = "bootvmdisk"
  type     = "network-hdd"
  zone     = local.zone
  size     = "20"
  image_id = yandex_compute_image.lamp-vm-image.id
}

# Creating a VM instance

resource "yandex_compute_instance" "vm" {
  name        = local.vm_name
  platform_id = "standard-v3"
  zone        = local.zone
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

# Creating a security profile

resource "yandex_sws_security_profile" "demo-profile-simple" {
  name           = "test-profile"
  default_action = "DENY"
  
  # Smart Protection rule providing full protection
  security_rule {
    name     = "smart-protection"
    priority = 999900

    smart_protection {
      mode = "FULL"
    }
  }

  # Basic rule, allows traffic from the specified IP address without checking by the Smart Protection rule
  security_rule {
    name     = "my-rule"
    priority = 999800

    rule_condition {
      action = "ALLOW"
      condition {
        source_ip {
          ip_ranges_match {
            ip_ranges = [var.allowed_ip]

          }
        }
      }
    }
  }
}

# Creating a target group

resource "yandex_alb_target_group" "foo" {
  name           = "test-target-group"

  target {
    subnet_id    = yandex_vpc_subnet.subnet-1.id
    ip_address   = yandex_compute_instance.vm.network_interface.0.ip_address
  }
}

# Creating a backend group

resource "yandex_alb_backend_group" "alb-bg" {
  name                     = "test-backend-group"

  http_backend {
    name                   = "backend-1"
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.foo.id]
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
  name   = "test-http-router"
}

resource "yandex_alb_virtual_host" "alb-host" {
  name           = "test-virtual-host"
  http_router_id = yandex_alb_http_router.alb-router.id
  authority      = ["*"]
  route {
    name = "route-1"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.alb-bg.id
      }
    }
  }
  route_options {
    security_profile_id   = yandex_sws_security_profile.demo-profile-simple.id
  }
}


# Creating an L7 load balancer

resource "yandex_alb_load_balancer" "sws-balancer" {
  name               = "test-load-balancer"
  network_id         = yandex_vpc_network.network-1.id
  security_group_ids = [yandex_vpc_security_group.sg-1.id]

  allocation_policy {
    location {
      zone_id   = local.zone
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
  }

  listener {
    name = "listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.alb-router.id
      }
    }
  }
}
```