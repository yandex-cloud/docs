1. Describe the new `vm-net` cloud network with subnet `vm-subnet-{{ region-id }}-a`: CIDR `172.17.1.0/24`, availability zone `{{ region-id }}-a`.

    To do this, add the following lines to the `networks.tf` configuration file:

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
    * `cluster-vm`: On the `cluster-net` cloud network (`cluster-subnet-{{ region-id }}-a` subnet) with the `cluster-vm-sg` security group.
    * `other-vm`: On the `vm-net` cloud network (`vm-subnet-{{ region-id }}-a` subnet) with the `other-vm-sg` security group.

    To do this, create a configuration file called `vms.tf` with a description of the virtual machines.

    
    You also need to [add the public parts of the SSH keys](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to this file to be able to connect to virtual machines via SSH.


    {% cut "vms.tf" %}

    ```hcl
    resource "yandex_compute_instance" "cluster-vm" {
      name        = "cluster-vm"
      platform_id = "standard-v3"
      zone        = "{{ region-id }}-a"
    
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
        subnet_id          = yandex_vpc_subnet.cluster-subnet-a.id
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
      zone        = "{{ region-id }}-a"
    
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
        subnet_id          = yandex_vpc_subnet.vm-subnet-a.id
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

    {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

1. Apply your changes:

    {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

