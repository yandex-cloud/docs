1. Describe the new `vm-net` [cloud network](../../../vpc/concepts/network.md#network) with the `vm-subnet-{{ region-id }}-a` [subnet](../../../vpc/concepts/network.md#subnet): CIDR `172.17.1.0/24`, `{{ region-id }}-a` [availability zone](../../../overview/concepts/geo-scope.md). To do this, add the following lines to the `networks.tf`configuration file:

   {% cut "networks.tf" %}

   ```hcl
   resource "yandex_vpc_network" "vm-net" { name = "vm-net" }

   resource "yandex_vpc_subnet" "vm-subnet-a" {
     name           = "vm-subnet-{{ region-id }}-a"
     zone           = "{{ region-id }}-a"
     network_id     = yandex_vpc_network.vm-net.id
     v4_cidr_blocks = ["172.17.1.0/24"]
   }
   ```

   {% endcut %}

1. Describe the [security groups](../../../vpc/concepts/security-groups.md):
   * Additional security group named `cluster-vm-sg` in the `cluster-net` network for the `cluster-vm` [virtual machine](../../../compute/concepts/vm.md).
   * Default security group named `other-vm-sg` in the `vm-net` network for the `other-vm` virtual machine.

   To do this, add the following lines to the `security-groups.tf` configuration file:

   {% cut "security-groups.tf" %}

   ```hcl
   resource "yandex_vpc_security_group" "cluster-vm-sg" {
     name       = "cluster-vm-sg"
     network_id = yandex_vpc_network.cluster-net.id

     ingress {
       description    = "Allow any ingress traffic"
       protocol       = "ANY"
       v4_cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
       description    = "Allow any egress traffic"
       protocol       = "ANY"
       v4_cidr_blocks = ["0.0.0.0/0"]
     }
   }

   resource "yandex_vpc_default_security_group" "other-vm-sg" {
     network_id = yandex_vpc_network.vm-net.id

     ingress {
       description    = "Allow any ingress traffic"
       protocol       = "ANY"
       v4_cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
       description    = "Allow any egress traffic"
       protocol       = "ANY"
       v4_cidr_blocks = ["0.0.0.0/0"]
     }
   }
   ```

   {% endcut %}

   {% note warning %}

   The above security groups allow any traffic in any direction and serve for demonstration purposes. This enables you to install the utilities required for connection on the VM and to connect to the cluster.

   For real-world tasks, configure the security groups to allow only essential traffic.

   {% endnote %}

1. Describe the VMs to use for [migration](#do-actions-for-migration) and [DNS functionality check](#check-cluster-availability):
   * `cluster-vm`: On the `cluster-net` cloud network (`cluster-subnet-{{ region-id }}-a` subnet) with the `cluster-vm-sg` security group.
   * `other-vm`: On the `vm-net` cloud network (`vm-subnet-{{ region-id }}-a` subnet) with the `other-vm-sg` security group.

   To do this, create a configuration file called `vms.tf` describing the VMs.


   You also need to [add the public parts of the SSH keys](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to this file to be able to connect to VMs via SSH.


   {% cut "vms.tf" %}

   ```hcl
   resource "yandex_compute_disk" "boot-disk-1" {
     name     = "boot-disk"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = {{ compute-ubuntu-lts-image-id }}
   }

   resource "yandex_compute_disk" "boot-disk-2" {
     name     = "boot-disk"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
     size     = "20"
     image_id = {{ compute-ubuntu-lts-image-id }}
   }

   resource "yandex_compute_instance" "cluster-vm" {
     name        = "cluster-vm"
     platform_id = "standard-v3"
     zone        = "{{ region-id }}-a"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-1.id
     }

     network_interface {
       subnet_id          = yandex_vpc_subnet.cluster-subnet-a.id
       security_group_ids = [yandex_vpc_security_group.cluster-vm-sg.id]
       nat                = true
     }

     metadata = {
       ssh-keys = "<any_username>:<SSH_key_contents>"
     }
   }

   resource "yandex_compute_instance" "other-vm" {
     name        = "other-vm"
     platform_id = "standard-v3"
     zone        = "{{ region-id }}-a"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk-2.id
     }

     network_interface {
       subnet_id          = yandex_vpc_subnet.vm-subnet-a.id
       security_group_ids = [yandex_vpc_default_security_group.other-vm-sg.id]
       nat                = true
     }

     metadata = {
       ssh-keys = "<any_username>:<SSH_key_contents>"
     }
   }
   ```

   {% endcut %}


   For more information about creating a VM, see the [{{ compute-full-name }} documentation](../../../compute/operations/vm-create/create-linux-vm.md).


1. Check the {{ TF }} configuration files for errors:

   {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

1. Apply your changes:

   {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}