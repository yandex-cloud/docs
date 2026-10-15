По плану будут созданы следующие ресурсы:
* [Облачная сеть](../../vpc/concepts/network.md#network) `ya-network` с [подсетью](../../vpc/concepts/network.md#subnet) `ya-network` в [зоне доступности](../../overview/concepts/geo-scope.md), указанной по умолчанию.
* Две [виртуальные машины](../../compute/concepts/vm.md) Windows: `terraform1` (2 ядра и 4 ГБ оперативной памяти) и `terraform2` (4 ядра и 4 ГБ оперативной памяти). Они автоматически получат публичные и [внутренние IP-адреса](../../vpc/concepts/address.md#internal-addresses) из диапазона `192.168.10.0/16` в подсети `ya-network`.

Создайте следующие файлы:
1. `main.tf` — основной файл с описанием инфраструктуры.

    {% cut "Содержимое файла main.tf" %}

    ```hcl
    terraform {
      required_providers {
        yandex = {
          source = "yandex-cloud/yandex"
        }
      }
    }

    provider "yandex" {
      zone = var.zone
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

    resource "yandex_compute_instance" "vm-1" {
      name        = "terraform1"
      hostname    = "terraform1"
      zone        = var.zone
      platform_id = "standard-v3"

      resources {
        cores = 2
        memory = 4
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

    resource "yandex_compute_instance" "vm-2" {
      name        = "terraform2"
      hostname    = "terraform2"
      zone        = var.zone
      platform_id = "standard-v3"

      resources {
        cores = 4
        memory = 4
      }

      boot_disk {
        initialize_params {
          image_id = data.yandex_compute_image.default.id
          size = var.disk_size
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

    output "internal_ip_address_vm_1" {
      value = yandex_compute_instance.vm-1.network_interface.0.ip_address
    }

    output "internal_ip_address_vm_2" {
      value = yandex_compute_instance.vm-2.network_interface.0.ip_address
    }

    output "external_ip_address_vm_1" {
      value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
    }

    output "external_ip_address_vm_2" {
      value = yandex_compute_instance.vm-2.network_interface.0.nat_ip_address
    }
    ```

    {% endcut %}

1. `variables.tf` — файл с описанием переменных для создаваемых ресурсов.

    {% cut "Файл variables.tf" %}

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

    variable "disk_size" {
      type    = number
      default = 50
    }

    variable "disk_type" {
      type    = string
      default = "network-nvme"
    }

    variable "user_name" {
      type    = string
      default = ""
    }

    variable "user_pass" {
      type    = string
      default = ""
    }

    variable "admin_pass" {
      type    = string
      default = ""
    }

    variable "timeout_create" {
      default = "10m"
    }

    variable "timeout_delete" {
      default = "10m"
    }
    ```

    {% endcut %}

1. `terraform.tfvars` — файл, где хранятся значения переменных для создаваемых внутри ВМ учетных записей.

    {% cut "Файл terraform.tfvars" %}

    ```hcl
    user_name  = "<my_user>"
    user_pass  = "<my_password>"
    admin_pass = "<my_password>"
    ```

    {% endcut %}
