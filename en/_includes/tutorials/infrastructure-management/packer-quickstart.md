# Getting started with Packer

Packer lets you create [virtual machine images](../../../compute/concepts/image.md) with parameters specified in the configuration file. Below, we describe how to create a disk image using Packer.

In this scenario, Packer will create and launch a virtual machine with Debian 9 and nginx web server. Then, it will delete the VM and create an image of its boot disk. After that, the disk will also be deleted.

To create an image:

1. [Install Packer](#install-packer)
1. [Prepare the image configuration](#prepare-image-config)
1. [Create the image](#create-image)
1. [Check the image](#check-image)

If you no longer need the created image, [delete it](#clear-out).

## Before you start {#before-you-begin}

Before deploying your applications, sign up for Yandex.Cloud and create a billing account:

{% include [prepare-register-billing](../_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [Yandex.Cloud page](https://console.cloud.yandex.com/cloud).

[Learn more about clouds and folders](../../../resource-manager/concepts/resources-hierarchy.md).

* Install the Yandex.Cloud [command line interface](../../../cli/quickstart.md#install).
* [Create](../../../vpc/quickstart.md) a cloud network with one subnet in your folder.
* [Get](../../../iam/concepts/authorization/oauth-token.md) an OAuth token.

### Required paid resources {#paid-resources}

You pay for storing created images (see [pricing for {{ compute-full-name }}](../../../compute/pricing#prices-storage)).

## Install Packer {#install-packer}

{% note info %}

Yandex.Cloud requires Packer 1.5 and higher.

{% endnote %}

Download and install Packer by following the [instructions on the official website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

## Prepare the image configuration {#prepare-image-config}

1. Get the folder ID by running the `yc config list` command.
1. Get the subnet ID by running the command `yc vpc subnet list`.
1. Create a JSON file with any name, like `image.json`. This will be your template. Enter the following parameters:

```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth token>",
      "folder_id": "<folder ID>",
      "zone":      "ru-central1-a",

      "image_name":        "debian-9-nginx-not_var{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-9",
      "subnet_id":           "<subnet ID>",
      "use_ipv4_nat":        true,
      "disk_type":           "network-ssd",
      "ssh_username":        "debian"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "inline": [
        "echo 'updating APT'",
        "sudo apt-get update -y",
        "sudo apt-get install -y nginx",
        "sudo su -",
        "sudo systemctl enable nginx.service",
        "curl localhost"
      ]
    }
  ]
}
```

## Create the image {#create-image}

Build the image using the template:

```
$ packer build image.json
```

## Check the image {#check-image}

Make sure the image was created:

1. Go to [management console]({{ link-console-main }}).
1. Open **Compute Cloud**.
1. Open **Images**. Check if the new disk image is there.

### Delete the created resources {#clear-out}

If you no longer need the created image, [delete it](../../../compute/operations/image-control/delete.md).

Delete the [subnet](../../../vpc/operations/subnet-delete.md) and [cloud network](../../../vpc/operations/network-delete.md) if you created them specifically for this scenario.

