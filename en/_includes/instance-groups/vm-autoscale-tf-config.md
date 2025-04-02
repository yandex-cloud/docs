```hcl
# Declaring variables for confidential parameters

variable "folder_id" {
  type = string
}

variable "vm_user" {
  type = string
}

variable "ssh_key" {
  type      = string
  sensitive = true
}

# Configuring a provider

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.47.0"
    }
  }
}

provider "yandex" {
  zone = "{{ region-id }}-a"
}

# Creating a service account and assigning roles to it

resource "yandex_iam_service_account" "for-autoscale" {
  name = "for-autoscale"
}

resource "yandex_resourcemanager_folder_iam_member" "vm-autoscale-sa-role-compute" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.for-autoscale.id}"
}

# Creating a cloud network and subnets

resource "yandex_vpc_network" "vm-autoscale-network" {
  name = "vm-autoscale-network"
}

resource "yandex_vpc_subnet" "vm-autoscale-subnet-a" {
  name           = "vm-autoscale-subnet-a"
  zone           = "{{ region-id }}-a"
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.vm-autoscale-network.id
}

resource "yandex_vpc_subnet" "vm-autoscale-subnet-b" {
  name           = "vm-autoscale-subnet-b"
  zone           = "{{ region-id }}-b"
  v4_cidr_blocks = ["192.168.2.0/24"]
  network_id     = yandex_vpc_network.vm-autoscale-network.id
}

# Creating a security group

resource "yandex_vpc_security_group" "sg-1" {
  name                = "sg-autoscale"
  network_id          = yandex_vpc_network.vm-autoscale-network.id
  egress {
    protocol          = "ANY"
    description       = "any"
    v4_cidr_blocks    = ["0.0.0.0/0"]
  }
  ingress {
    protocol          = "TCP"
    description       = "ext-http"
    v4_cidr_blocks    = ["0.0.0.0/0"]
    port              = 80
  }
  ingress {
    protocol          = "TCP"
    description       = "healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    port              = 80
  }
}

# Specifying a prebuilt VM image

data "yandex_compute_image" "autoscale-image" {
  family = "container-optimized-image"
}

# Creating an instance group

resource "yandex_compute_instance_group" "autoscale-group" {
  name                = "autoscale-vm-ig"
  folder_id           = var.folder_id
  service_account_id  = yandex_iam_service_account.for-autoscale.id
  instance_template {

    platform_id = "standard-v3"
    resources {
      memory = 2
      cores  = 2
    }
  
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.autoscale-image.id
        size     = 30
      }
    }

    network_interface {
      network_id = yandex_vpc_network.vm-autoscale-network.id
      subnet_ids = [
        yandex_vpc_subnet.vm-autoscale-subnet-a.id,
        yandex_vpc_subnet.vm-autoscale-subnet-b.id
      ]
      security_group_ids = [ yandex_vpc_security_group.sg-1.id ]
      nat                = true
    }

    metadata = {
      user-data = templatefile("config.tpl", {
        VM_USER = var.vm_user
        SSH_KEY = var.ssh_key
      })
      docker-container-declaration = file("declaration.yaml")
    }
  }

  scale_policy {
    auto_scale {
      initial_size           = 2
      measurement_duration   = 60
      cpu_utilization_target = 40
      min_zone_size          = 1
      max_size               = 6
      warmup_duration        = 120
    }
  }

  allocation_policy {
    zones = [
      "{{ region-id }}-a",
      "{{ region-id }}-b"
    ]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  load_balancer {
    target_group_name        = "auto-group-tg"
    target_group_description = "load balancer target group"
  }
}

# Creating a network load balancer

resource "yandex_lb_network_load_balancer" "balancer" {
  name = "group-balancer"

  listener {
    name        = "http"
    port        = 80
    target_port = 80
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.autoscale-group.load_balancer[0].target_group_id
    healthcheck {
      name = "tcp"
      tcp_options {
        port = 80
      }
    }
  }
}
```
