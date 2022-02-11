# Getting started with Terraform

{% include [terraform-definition](../terraform-definition.md) %}

To create your first Terraform configuration:

1. [Install Terraform](#install-terraform)
1. [Create a Terraform configuration file](#configure-terraform)
1. [Configure a provider](#configure-provider)
1. [Prepare an infrastructure plan](#prepare-plan)
1. [Check and format the configuration files](#check-resources)
1. [Create resources](#create-resources)
1. [Delete resources](#delete-resources)

## Before you start {#before-you-begin}

Before deploying your infrastructure, register in {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page]{% if lang == "ru" %}(https://console.cloud.yandex.ru/cloud){% endif %}{% if lang == "en" %}(https://console.cloud.yandex.com/cloud){% endif %}.

[Learn more about clouds and folders](../../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

The cost of Terraform-created resources includes:

* A fee for continuously running VMs (see [pricing for {{ compute-full-name }}](../../../compute/pricing.md)).
* A fee for using dynamic public IP addresses (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).

## Install Terraform {#install-terraform}

{% include [terraform_install](../terraform-install.md) %}

## Create a Terraform configuration file {#configure-terraform}

{% include [terraform-configure](../terraform-configure.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../terraform-configure-provider.md) %}

## Prepare an infrastructure plan {#prepare-plan}

By using Terraform in {{ yandex-cloud }}, you can create all kinds of cloud resources, such as VMs, disks, and images. For more information about resources that can be created with Terraform, see the [provider's documentation](https://www.terraform.io/docs/providers/yandex/index.html).

To create a resource, specify a set of required and optional parameters that define the resource properties. Such resource descriptions make up an infrastructure plan.

Two VMs, `terraform1` and `terraform2`, as well as the `network-1` cloud network with the `subnet-1` subnet will be created according to the plan.

Resource names must meet the following requirements:

{% include [names](../../name-format.md) %}

The VMs have a different number of cores and amount of RAM: 2 cores and 2 GB of RAM for `terraform1` and 4 cores and 4 GB of RAM for `terraform2`. The VMs will automatically get public and private IP addresses from the `192.168.10.0/24` range in the `subnet-1` subnet located in the `ru-central1-a` [availability zone](../../../overview/concepts/geo-scope.md) and belonging to the `network-1` cloud network. The Ubuntu OS will be installed on the VMs and the public part of the key used to access the VMs via SSH will be stored on them.

In the VM configuration, you'll need to specify the boot disk image ID. You can get a list of available public images using the [CLI](../../../cli/quickstart.md) `yc compute image list --folder-id standard-images` command.

To access the VM via SSH, [generate an SSH key pair](../../../compute/operations/vm-connect/ssh#creating-ssh-keys) and pass the public part of the key to the VM in the  `ssh-keys` parameter under `metadata`.

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
}
```

{% list tabs %}

- Creating a Linux VM

  {% include [terraform-prepare-plan-linux](../terraform-prepare-plan-linux.md) %}

- Creating a Windows VM

  {% include [terraform-prepare-plan-windows](../terraform-prepare-plan-windows.md) %}

{% endlist %}

### Create users {#users}

{% list tabs %}

- Linux

  {% include [terraform-vm-user-linux](../terraform-vm-user-linux.md) %}

- Windows

  {% include [terraform-vm-user-windows](../terraform-vm-user-windows.md) %}

{% endlist %}

## Check and format the configuration files {#check-resources}

{% include [check-resources](../terraform-check-resources.md) %}

## Create resources {#create-resources}

{% include [create-resources](../terraform-create-resources.md) %}

## Delete resources {#delete-resources}

{% include [delete-resources](../terraform-delete-resources.md) %}

