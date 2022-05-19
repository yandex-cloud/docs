According to the plan, the following resources are created:

* A cloud network named `ya-network` with a subnet named `ya-network` in the default availability zone.
* Two Windows VMs: `terraform1` (2 cores and 4 GB of RAM) and `terraform2` (4 cores and 4 GB of RAM). The VM will automatically get public and private IP addresses from the range `192.168.10.0/24` in the `ya-network` subnet.

Create the following files:

1. `main.tf`: The main file with the infrastructure description.

    {% cut "Content of file main.tf " %}

    ```hcl
    terraform {
    required_providers {
        yandex = {
        source = "yandex-cloud/yandex"
        }
    }
    }
    
    provider "yandex" {
    cloud_id  = var.cloud_id
    folder_id = var.folder_id
    zone      = var.zone
    token     = var.token
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

1. `variables.tf`: A file that describes variables for the resources being created.

    {% cut "File variables.tf " %}

    ```hcl
    variable "cloud_id" {
    type    = string
    }
    
    variable "folder_id" {
    type    = string
    }
    
    variable "zone" {
    type    = string
    default = "ru-central1-a"
    }
    
    variable "token" {
    type    = string
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

1. `terraform.tfvars`: A file that stores the values of variables for accounts created inside the VM and access tokens.

    {% cut "File terraform.tfvars " %}

    ```
    token      = "<token>"
    cloud_id   = "<cloud_id>"
    folder_id  = "<folder_id>"
    
    name       = "<my_server_name>"
    user_name  = "<my_user>"
    user_pass  = "<my_password>"
    admin_pass = "<my_password>"
    ```

    {% endcut %}

