# Getting started with Packer

Packer lets you create [virtual machine images](../../compute/concepts/image.md) from configuration files called templates. Below, we describe how to create a disk image using Packer.

In this scenario, Packer will create and launch a virtual machine with Debian 9 and nginx web server. Then, it will delete the VM and create an image of its boot disk. After that, the disk will also be deleted.

To create an image:

1. [Install Packer](#install-packer)
1. [Prepare the template](#prepare-image-config)
1. [Create the image](#create-image)
1. [Check the image](#check-image)

## Before you start {#prepare}

1. Install the Yandex.Cloud [command line interface](../../cli/quickstart.md#install).
1. [Create](../../vpc/quickstart.md) a cloud network with one subnet in your folder.
1. [Get](../../iam/concepts/authorization/oauth-token.md) an OAuth token.

## 1. Install Packer {#install-packer}

{% note info %}

Yandex.Cloud requires Packer 1.4.1 or higher.

{% endnote %}

Download and install Packer by following the [instructions on the official website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

## 2. Prepare the template {#prepare-image-config}

1. Get the folder ID by running the `yc config list` command.
1. Get the subnet ID by running the `yc vpc subnet list` command.
1. Create a JSON file with any name, like `image.json`. This will be your template. Enter the following parameters:

```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth token>",
      "folder_id": "<folder ID>",
      "zone":      "ru-central1-a",

      "image_name":        "debian-9-nginx-{{isotime | clean_image_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-9",
      "subnet_id":           "<subnet ID>",
      "use_ipv4_nat":        true,
      "disk_type":           "network-nvme",
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

## 3. Create the image {#create-image}

Build the image using the template:

```
$ packer build image.json
```

## 4. Check the image {#check-image}

Make sure the image was created:

1. Go to the [management console](https://console.cloud.yandex.com/).
1. Open **Compute Cloud**.
1. Open **Images**. Check if the new disk image is there.

