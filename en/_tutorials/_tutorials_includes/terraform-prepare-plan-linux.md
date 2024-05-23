According to the plan, the following resources are created:
* `network-1` [cloud network](../../vpc/concepts/network.md#network) with a [subnet](../../vpc/concepts/network.md#subnet) named `subnet-1` in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md).
* Two Linux [VMs](../../compute/concepts/vm.md): `terraform1` (2 cores and 2 GB of RAM) and `terraform2` (4 cores and 4 GB of RAM). They will automatically get [public and private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in `subnet-1`.
1. Get the ID of the boot disk [image](../../compute/concepts/image.md) from {{ marketplace-full-name }}, such as [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts), that will be installed on the VM. Get a list of available public images by running the following command in the [CLI](../../cli/):

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
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = "fd87va5cc00gaq2f5qfb"
   }

   resource "yandex_compute_disk" "boot-disk-2" {
     name     = "boot-disk-2"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = "fd87va5cc00gaq2f5qfb"
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

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
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }

   resource "yandex_compute_instance" "vm-2" {
     name = "terraform2"

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
   ```

   {% endcut %}