# Getting started with Packer

Packer enables you to create [virtual machine disk images](../../compute/concepts/image.md) with parameters specified in a configuration file. Below, we describe how to create a disk image using Packer.

In this scenario, Packer will create and launch a virtual machine with [Debian 9](/marketplace/products/yc/debian-9) from {{ marketplace-name }} and nginx web server. Then, it will delete the VM and create an image of its boot disk. After that, the disk will also be deleted.

To create an image:

1. [Install Packer](#install-packer).
1. [Prepare the image configuration](#prepare-image-config).
1. [Create the image](#create-image).
1. [Check the image](#check-image).

If you no longer need a created image, [delete it](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

* Install the {{ yandex-cloud }} [command-line interface](../../cli/quickstart.md#install).
* [Create](../../vpc/quickstart.md) a cloud network with a single subnet in your folder.
{% if product == "yandex-cloud" %}
* [Get](../../iam/concepts/authorization/oauth-token.md) an OAuth token.
{% endif %}
{% if product == "cloud-il" %}
* [Create](../../iam/operations/sa/create.md) a service account and [get](../../iam/operations/sa/create-access-key.md) a static key for it.
{% endif %}

{% if product == "yandex-cloud" %}

### Required paid resources {#paid-resources}

You pay for storing created images (see [pricing for {{ compute-full-name }}](../../compute/pricing#prices-storage)).

{% endif %}

## Install Packer {#install-packer}

{% note info %}

{{ yandex-cloud }} requires Packer 1.5 or higher.

{% endnote %}

Download a Packer distribution and install it by following the [instructions on the official website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

You can also download a Packer distribution for your platform from a [mirror](https://hashicorp-releases.website.yandexcloud.net/packer/). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```
export PATH=$PATH:/path/to/packer
```

## Prepare the image configuration {#prepare-image-config}

1. Get the folder ID by running the `yc config list` command.
1. Get the subnet ID by running the command `yc vpc subnet list`.
1. Create a JSON file with any name, like `image.json`. This will be your template. Enter the following parameters:

{% if product == "yandex-cloud" %}

```json
{
  "builders": [
    {
      "type":      "yandex",
      "token":     "<OAuth token>",
      "folder_id": "<folder ID>",
      "zone":      "{{ region-id }}-a",

      "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-11",
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

{% endif %}

{% if product == "cloud-il" %}

```json
{
  "builders": [
    {
      "type":                     "yandex",
      "endpoint":                 "{{ api-host }}:443",
      "service_account_key_file": "<path to the file with the service account static key>",
      "folder_id":                "<folder ID>",
      "zone":                     "{{ region-id }}-a",

      "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
      "image_family":      "debian-web-server",
      "image_description": "my custom debian with nginx",

      "source_image_family": "debian-11",
      "subnet_id":           "<subnet ID>",
      "platform_id":         "standard-v3",
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

{% endif %}


## Create an image {#create-image}

Build the image using the template:

```
packer build image.json
```

## Check the image {#check-image}

Make sure the image was created:

1. Go to the [management console]({{ link-console-main }}).
1. Open **Compute Cloud**.
1. Open **Images**. Check if the new disk image is there.

### Delete the resources you created {#clear-out}

If you no longer need the created image, [delete it](../../compute/operations/image-control/delete.md).

Delete the [subnet](../../vpc/operations/subnet-delete.md) and [cloud network](../../vpc/operations/network-delete.md) if you created them to run this scenario.
