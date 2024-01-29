По плану будут созданы следующие ресурсы:

* Облачная сеть `ya-network` с подсетью `ya-network` в зоне доступности, указанной по умолчанию.
* Виртуальная машина Windows: `terraform1` (2 ядра и 4 Гб оперативной памяти) и `terraform2` (4 ядра и 4 Гб оперативной памяти). Она автоматически получит публичные и приватные IP-адреса из диапазона `192.168.10.0/24` в подсети `ya-network`.

Создайте следующие файлы:

1. `main.tf` — основной файл с описанием инфраструктуры.

    {% cut "Содержимое файла main.tf " %}

        
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

    resource "yandex_compute_disk" "boot-disk" {
      name     = "boot-disk"
      type     = var.disk_type
      zone     = "{{ region-id }}-a"
      size     = var.disk_size
      image_id = yandex_compute_image.default.id
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
        image_id = yandex_compute_disk.boot-disk.id
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


1. `variables.tf` — файл с описанием переменных для создаваемых ресурсов.

    {% cut "Файл variables.tf " %}

    ```hcl
    variable "zone" {
      type    = string
      default = "{{ region-id }}-a"
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

1. `terraform.tfvars` — файл, где хранятся значения переменных для создаваемых внутри ВМ учетных записей и токены доступа.

    {% cut "Файл terraform.tfvars" %}

    ```
    name       = "<my_server_name>"
    user_name  = "<my_user>"
    user_pass  = "<my_password>"
    admin_pass = "<my_password>"
    ```

    {% endcut %}

