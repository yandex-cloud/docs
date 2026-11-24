According to the plan, the following resources are created:
* `network1` [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) named `subnet1` in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md).
* Two Linux [VMs](../../compute/concepts/vm.md): 2 vCPUs and 2 GB of RAM for `terraform1` and 4 vCPUs and 4 GB of RAM for `terraform2`. They will automatically get [public and private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in the `subnet-1` subnet.
1. Select a boot disk [image](../../compute/concepts/image.md) in {{ marketplace-full-name }}, e.g., [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts). Get the list of available public images using this [CLI command](../../cli/):

   ```bash
   yc compute image list --folder-id standard-images
   ```

1. Generate an [SSH key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to your VM over SSH.
1. Describe the resource parameters in the `main.tf` file:
   * In the `ssh-keys` parameter under `metadata`, specify the path to the public part of the SSH key.
   * In the `image_id` parameter, set the boot disk image ID.

   {% cut "main.tf file" %}

   ```hcl
   <provider_settings>

   resource "yandex_compute_disk" "boot-disk-1" {
     name     = "boot-disk-1"
     type     = "network-hdd"
     zone     = "{{ region-id }}-d"
     size     = "20"
     image_id = "fd806c8slu9j********"
   }

   resource "yandex_compute_disk" "boot-disk-2" {
     name     = "boot-disk-2"
     type     = "network-hdd"
     zone     = "{{ region-id }}-d"
     size     = "20"
     image_id = "fd806c8slu9j********"
   }

   resource "yandex_compute_instance" "vm-1" {
     name        = "terraform1"
     platform_id = "standard-v3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-1.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("<path_to_public_part_of_SSH_key>")}"
     }
   }

   resource "yandex_compute_instance" "vm-2" {
     name        = "terraform2"
     platform_id = "standard-v3"

     resources {
       cores  = 4
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-2.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-d"
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
   ```

   {% endcut %}
