According to the plan, the following resources are created:

* `network-1` cloud network with a subnet named `subnet-1` in the `{{ region-id }}-a` availability zone.
* Two Linux VMs: `terraform1` (2 cores and 2 GB of RAM) and `terraform2` (4 cores and 4 GB of RAM). The VMs are automatically assigned public and private IP addresses from the `192.168.10.0/24` range in `subnet-1`.

1. From {{ marketplace-name }}, get the ID of the boot disk image, such as [Ubuntu 16.04 LTS](/marketplace/products/yc/ubuntu-16-04-lts), that will be installed on the VM. Get a list of available public images by running the following command in the [CLI](../cli/quickstart.md):

   ```
   yc compute image list --folder-id standard-images
   ```

1. Generate an [SSH key pair](../compute/operations/vm-connect/ssh#creating-ssh-keys) to connect to a virtual machine (VM) by SSH.
1. Describe the resource parameters in the `main.tf` file:

   * In the `ssh-keys` parameter under `metadata`, specify the path to the public part of the SSH key.
   * In the `image_id` parameter, set the boot disk image ID.

   {% cut "The main.tf file" %}

   ```hcl
   <provider settings>

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform1"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
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
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
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
