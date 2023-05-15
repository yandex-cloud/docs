# Getting started with {{ TF }}

{% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

To create your first infrastructure in {{ yandex-cloud }} using {{ TF }}:
1. [Prepare your cloud](#before-you-begin).
1. [Install {{ TF }}](#install-terraform).
1. [Get the authentication data](#get-credentials)
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure a provider](#configure-provider).
1. [Prepare an infrastructure plan](#prepare-plan).
1. [Check and format your configuration files](#check-resources).
1. [Create resources](#create-resources).

If you no longer need the resources, [delete them](#delete-resources).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of resources created with {{ TF }} includes:
* Fee for continuously running [virtual machines](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Install {{ TF }} {#install-terraform}

{% include [terraform_install](../../_tutorials/terraform-install.md) %}

## Get the authentication credentials {#get-credentials}

{% include [terraform-credentials-sa](../../_tutorials/terraform-credentials-sa.md) %}


{% cut "Managing resources on behalf of a Yandex account or a federated account" %}

{% include [terraform-credentials-user](../../_tutorials/terraform-credentials-user.md) %}

{% endcut %}



## Create a {{ TF }} configuration file {#configure-terraform}

{% include [terraform-configure](../../_tutorials/terraform-configure.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Prepare an infrastructure plan {#prepare-plan}

Using {{ TF }} in {{ yandex-cloud }}, you can create cloud resources of any type, such as VMs, [disks](../../compute/concepts/disk.md), and [images](../../compute/concepts/image.md). For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

To create a resource, specify a set of required and optional parameters that define the resource properties. Such resource descriptions make up an infrastructure plan.

The plan includes creating two VMs: `terraform1` and `terraform2`, as well as a [cloud network](../../vpc/concepts/network.md#network) called `network-1` with a [subnet](../../vpc/concepts/network.md#subnet) named `subnet-1`.

Resource names must meet the following requirements:

{% include [names](../../_includes/name-format.md) %}

The VMs will have different [vCPU and memory configurations](../../compute/concepts/vm.md#types): 2 vCPUs and 2 GB of RAM for `terraform1` and 4 vCPUs and 4 GB of RAM for `terraform2`. The VMs will be automatically assigned public and [private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in `subnet-1` located in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md) and belonging to the `network-1` cloud network. The VMs will run Ubuntu OS and host the public part of the key to enable SSH access to the VMs.

In the VM configuration, you will need to specify the boot disk image ID. You can get a list of available public images using this [CLI](../../cli/quickstart.md) command:

```bash
yc compute image list --folder-id standard-images
```

To access the VMs over SSH, [generate an SSH key pair](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) and include the public key to the VM in the `ssh-keys` parameter in the `metadata` section.

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
  zone = "<default availability zone>"
}

resource "yandex_compute_instance" "vm-1" {
  name = "terraform1"
}
```



{% list tabs %}

- Creating a Linux VM

   {% include [terraform-prepare-plan-linux](../../_tutorials/terraform-prepare-plan-linux.md) %}

- Creating a Windows VM

   {% include [terraform-prepare-plan-windows](../../_tutorials/terraform-prepare-plan-windows.md) %}

{% endlist %}

### Create users {#users}

{% list tabs %}

- Linux

   {% include [terraform-vm-user-linux](../../_tutorials/terraform-vm-user-linux.md) %}

- Windows

   {% include [terraform-vm-user-windows](../../_tutorials/terraform-vm-user-windows.md) %}

{% endlist %}

## Check and format the configuration files {#check-resources}

{% include [check-resources](../../_tutorials/terraform-check-resources.md) %}

## Create resources {#create-resources}

{% include [create-resources](../../_tutorials/terraform-create-resources.md) %}

## How to delete the resources you created {#delete-resources}

{% include [delete-resources](../../_tutorials/terraform-delete-resources.md) %}

You can use the [management console]({{ link-console-main }}) to check that the resources have been deleted.


## See also {#see-also}

* [{#T}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [{#T}](../../tutorials/infrastructure-management/terraform-state-lock.md).

