## Deploy the configuration {#deploy}

In this example, we will create two [VMs](../../compute/concepts/vm.md): `terraform1` and `terraform2`. They will be connected to a [subnet](../../vpc/concepts/network.md#subnet) named `subnet-1` in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md). The subnet will belong to the `network-1` [cloud network](../../vpc/concepts/network.md#network).

The VMs will have different [vCPU and RAM](../../compute/concepts/vm-platforms.md) configurations: 1 vCPU and 2 GB of RAM for `terraform1` and 2 vCPUs and 4 GB of RAM for `terraform2`. The VMs will automatically get [public](../../vpc/concepts/address.md#public-addresses) and [private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in `subnet-1`. The VMs will run Ubuntu OS and host the public part of the key to enable SSH access to the VMs.
1. Save the following configuration to `example.tf`:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }

     backend "s3" {
       endpoints = {
         s3 = "{{ s3-storage-host }}"
       }
       bucket = "<bucket_name>"
       region = "{{ region-id }}"
       key    = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # This option is required to describe backend for {{ TF }} version 1.6.1 or higher.
       skip_s3_checksum            = true # This option is required to describe backend for {{ TF }} version 1.6.3 or higher.
     }
   }

   provider "yandex" {
     zone      = "{{ region-id }}-a"
   }

   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk-vm1" {
     name     = "boot-disk-1"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_disk" "boot-disk-vm2" {
     name     = "boot-disk-2"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm1.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<path_to_public_SSH_key>")}"
     }
   }

   resource "yandex_compute_instance" "vm-2" {
     name = "terraform2"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-vm2.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<path_to_public_SSH_key>")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
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

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```

   Where:
   * `bucket`: [Bucket](../../storage/concepts/bucket.md) name.
   * `key`: Object key in the bucket (name and path to the {{ TF }} state file in the bucket).
   * `ssh-keys`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).

1. Check the configuration using the `terraform plan` command.
1. Deploy the configuration using the `terraform apply` command.