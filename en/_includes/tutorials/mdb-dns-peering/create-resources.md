1. Describe the new `vm-net` cloud network with its new subnets:
    * `vm-subnet-ru-central1-a`: `172.17.1.0/24`, availability zone `ru-central1-a`.
    * `vm-subnet-ru-central1-b`: `172.17.2.0/24`, availability zone `ru-central1-b`.
    * `vm-subnet-ru-central1-c`: `172.17.3.0/24`, availability zone `ru-central1-c`.

    To do this, add the following lines to the `networks.tf` configuration file:

    {% cut "networks.tf" %}

    ```hcl
    resource "yandex_vpc_network" "vm-net" { name = "vm-net" }
    
    resource "yandex_vpc_subnet" "vm-subnet-a" {
      name           = "vm-subnet-ru-central1-a"
      zone           = "ru-central1-a"
      network_id     = yandex_vpc_network.vm-net.id
      v4_cidr_blocks = ["172.17.1.0/24"]
    }
    
    resource "yandex_vpc_subnet" "vm-subnet-b" {
      name           = "vm-subnet-ru-central1-b"
      zone           = "ru-central1-b"
      network_id     = yandex_vpc_network.vm-net.id
      v4_cidr_blocks = ["172.17.2.0/24"]
    }
    
    resource "yandex_vpc_subnet" "vm-subnet-c" {
      name           = "vm-subnet-ru-central1-c"
      zone           = "ru-central1-c"
      network_id     = yandex_vpc_network.vm-net.id
      v4_cidr_blocks = ["172.17.3.0/24"]
    }
    ```

    {% endcut %}

1. Describe the security groups:
    * An additional security group named `cluster-vm-sg` on the `cluster-net` network for a virtual machine called `cluster-vm`.
    * The `other-vm-sg` default security group on the `vm-net` network for a virtual machine called `other-vm`.

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

    The above groups allow any traffic in any direction and serve for demonstration purposes. This enables you to install the utilities required for connecting to the virtual machines and to connect to the cluster.

    For real-world tasks, configure the security groups to allow only essential traffic.

    {% endnote %}

1. Describe the virtual machines that you will use for [migration](#do-actions-for-migration) and to [check DNS functionality](#check-cluster-availability):
    * `cluster-vm`: On the `cluster-net` cloud network (`cluster-subnet-ru-central1-c` subnet) with the `cluster-vm-sg` security group.
    * `other-vm`: On the `vm-net` cloud network (`vm-subnet-ru-central1-c` subnet) with the `other-vm-sg` security group.

    To do this, create a configuration file called `vms.tf` with a description of the virtual machines.

    You also need to [add the public parts of the SSH keys](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to this file to be able to connect to virtual machines via SSH.

    {% cut "vms.tf" %}

    ```hcl
    resource "yandex_compute_instance" "cluster-vm" {
      name        = "cluster-vm"
      platform_id = "standard-v3"
      zone        = "{{ zone-id }}"
    
      resources {
        cores  = 2
        memory = 2
      }
    
      boot_disk {
        initialize_params {
          image_id = "{{ compute-ubuntu-lts-image-id }}"
        }
      }
    
      network_interface {
        subnet_id          = yandex_vpc_subnet.cluster-subnet-c.id
        security_group_ids = [yandex_vpc_security_group.cluster-vm-sg.id]
        nat                = true
      }
    
      metadata = {
        ssh-keys = "<any username>:<SSH key contents>"
      }
    }
    
    resource "yandex_compute_instance" "other-vm" {
      name        = "other-vm"
      platform_id = "standard-v3"
      zone        = "{{ zone-id }}"
    
      resources {
        cores  = 2
        memory = 2
      }
    
      boot_disk {
        initialize_params {
          image_id = "{{ compute-ubuntu-lts-image-id }}"
        }
      }
    
      network_interface {
        subnet_id          = yandex_vpc_subnet.vm-subnet-c.id
        security_group_ids = [yandex_vpc_default_security_group.other-vm-sg.id]
        nat                = true
      }
    
      metadata = {
        ssh-keys = "<any username>:<SSH key contents>"
      }
    }
    ```

    {% endcut %}

    For more information about creating a virtual machine, see the [{{ compute-full-name }} documentation](../../../compute/operations/vm-create/create-linux-vm.md).

1. Check the {{ TF }} configuration files for errors:

    {% include [terraform-validate](../../mdb/terraform/validate.md) %}

1. Apply your changes:

    {% include [terraform-apply](../../mdb/terraform/apply.md) %}

