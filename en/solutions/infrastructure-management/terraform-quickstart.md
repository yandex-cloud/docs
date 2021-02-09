# Getting started with Terraform

{% include [terraform-definition](../_solutions_includes/terraform-definition.md)  %}

Configurations for Terraform are written to `.tf` files in HashiCorp Configuration Language (HCL).

To install and configure Terraform and create your first configuration:

1. [Install Terraform](#install-terraform)
1. [Create a Terraform configuration file](#configure-terraform)
1. [Configure a provider](#configure-provider)
1. [Prepare an infrastructure plan](#prepare-plan)
1. [Create resources](#create-resources)
1. [Delete resources](#delete-resources)

## Before you start {#before-you-begin}

Before deploying your infrastructure, register in {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../_solutions_includes/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of Terraform-created resources includes:

* A fee for continuously running VMs (see [pricing for {{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Install Terraform {#install-terraform}

{% include [terraform_install](../_solutions_includes/terraform-install.md) %}

## Create a Terraform configuration file {#configure-terraform}

{% include [terraform-configure](../_solutions_includes/terraform-configure.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../_solutions_includes/terraform-configure-provider.md) %}

## Prepare an infrastructure plan {#prepare-plan}

By using Terraform in {{ yandex-cloud }}, you can create all kinds of cloud resources, such as VMs, disks, and images. For more information about resources that can be created with Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/index.html).

To create a resource, specify a set of required and optional parameters that define the resource properties. Such resource descriptions make up an infrastructure plan.

Two VMs, `terraform1` and `terraform2`, as well as the `network-1` cloud network with the `subnet-1` subnet will be created according to the plan.

Resource names must meet the following requirements:

{% include [names](../../_includes/name-format.md) %}

The VMs have a different number of cores and amount of RAM: 2 cores and 2 GB of RAM for `terraform1` and 4 cores and 4 GB of RAM for `terraform2`. The VMs will automatically get public and private IP addresses from the `192.168.10.0/24` range in the `subnet-1` subnet located in the `ru-central1-a` availability zone and belonging to the `network-1` cloud network. The Ubuntu OS will be installed on the VMs and the public part of the key used to access the VMs via SSH will be stored on them.

In the VM configuration, you'll need to specify the boot disk image ID. You can get a list of available public images using the [CLI](../../cli/quickstart.md) `yc compute image list --folder-id standard-images` command.

To access the VM via SSH, [generate an SSH key pair](../../compute/operations/vm-connect/ssh#creating-ssh-keys) and pass the public part of the key to the VM in the  `ssh-keys` parameter under `metadata`.

Resource configurations are specified immediately after the provider's configuration:

```hcl
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token     = "OAuth_token"
  cloud_id  = "cloud-id"
  folder_id = "folder-id"
  zone      = "ru-central1-a"
}

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
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
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

### Creating users {#users}

If you create another user, instead of passing `ssh-keys` in the `metadata` block, you can pass the user metadata in the `user-data` parameter. To do this:

1. Create a text metadata file, for example:

   {% include [user-data](../../_includes/compute/user-data.md) %}

1. Add the `user-data` parameter to the configuration by specifying the  the metadata file path:

   ```
     metadata = {
       user-data = "${file("<file path>/meta.txt")}"
     }
   ```

To learn more about working with metadata, see [VM instance metadata](../../compute/concepts/vm-metadata).

## Create resources {#create-resources}

After the configuration is completed, run the `terraform plan` command. If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out. This is a test step. No resources are created.

{% note alert %}

All resources created via Terraform are charged, therefore check the plan carefully.

{% endnote %}

If there are no errors in the configuration, run the `terraform apply` command. Terraform will ask you to confirm the resource creation: type `yes` in the terminal and press Enter. After this, all the necessary resources will be created in the specified folder and the IP addresses of the VMs will be displayed in the terminal. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

## Delete resources {#delete-resources}

To delete all resources created via Terraform, run the `terraform destroy` command. After the command has been executed, the terminal will display a list of resources that will be deleted. Type `yes` to confirm them and press Enter.
