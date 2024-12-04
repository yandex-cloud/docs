According to the plan, the following resources are created:
* `ya-network` [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) named `ya-network` in the default [availability zone](../../overview/concepts/geo-scope.md).
* Windows [VM](../../compute/concepts/vm.md): 2 vCPUs and 4 GB of RAM for `terraform1` and 4 vCPUs and 4 GB of RAM for `terraform2`. It will automatically get public and [private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in the `ya-network` subnet.

Create the following files:
1. `main.tf`: Main infrastructure description file.

  {% cut "Contents of the main.tf file" %}

  ```hcl
  terraform {
    required_providers {
      yandex = {
        source = "yandex-cloud/yandex"
      }
    }
  }

  provider "yandex" {
    zone      = var.zone
  }

  resource "yandex_vpc_network" "default" {
    name = var.network
  }

  resource "yandex_vpc_subnet" "default" {
    network_id     = yandex_vpc_network.default.id
    name           = var.subnet
    v4_cidr_blocks = var.subnet_v4_cidr_blocks
    zone           = var.zone
  }

  data "yandex_compute_image" "default" {
    family = var.image_family
  }

  data "template_file" "default" {
    template = file("${path.module}/init.ps1")
    vars = {
      user_name  = var.user_name
      user_pass  = var.user_pass
      admin_pass = var.admin_pass
    }
  }

  resource "yandex_compute_instance" "default" {
    name     = var.name
    hostname = var.name
    zone     = var.zone

    resources {
      cores  = var.cores
      memory = var.memory
    }

    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.default.id
        size     = var.disk_size
        type     = var.disk_type
      }
    }

    network_interface {
      subnet_id = yandex_vpc_subnet.default.id
      nat       = var.nat
    }

    metadata = {
      user-data = data.template_file.default.rendered
    }

    timeouts {
      create = var.timeout_create
      delete = var.timeout_delete
    }
  }

  output "name" {
    value = yandex_compute_instance.default.name
  }

  output "address" {
    value = yandex_compute_instance.default.network_interface.0.nat_ip_address
  }
  ```

  {% endcut %}

1. `variables.tf`: File describing the variables for the new resources.

   {% cut "variables.tf" %}

   ```hcl
   variable "zone" {
     type    = string
     default = "{{ region-id }}-d"
   }

   variable "network" {
     type    = string
     default = "ya-network"
   }

   variable "subnet" {
     type    = string
     default = "ya-network"
   }

   variable "subnet_v4_cidr_blocks" {
     type    = list(string)
     default = ["192.168.10.0/16"]
   }

   variable "nat" {
     type    = bool
     default = true
   }

   variable "image_family" {
     type    = string
     default = "windows-2019-dc-gvlk"
   }

   variable "name" {
     type    = string
   }

   variable "cores" {
     type    = number
     default = 2
   }

   variable "memory" {
     type    = number
     default = 4
   }

   variable "disk_size" {
     type    = number
     default = 50
   }

   variable "disk_type" {
     type    = string
     default = "network-nvme"
   }

   variable "user_name" {
     default = ""
     type    = string
   }

   variable "user_pass" {
     default = ""
     type    = string
   }

   variable "admin_pass" {
     default = ""
     type    = string
   }

   variable "timeout_create" {
     default = "10m"
   }

   variable "timeout_delete" {
     default = "10m"
   }
   ```

   {% endcut %}

1. `terraform.tfvars`: File storing access tokens and variable values for accounts created inside the VM.

   {% cut "terraform.tfvars" %}

   ```hcl
   name       = "<my_server_name>"
   user_name  = "<my_user>"
   user_pass  = "<my_password>"
   admin_pass = "<my_password>"
   ```

   {% endcut %}