# Getting started with Packer


Packer enables you to create [virtual machine disk images](../../compute/concepts/image.md) with parameters specified in a configuration file. This guide describes how to create a disk image using Packer.

In this scenario, Packer will create and launch a virtual machine with [Debian 11](/marketplace/products/yc/debian-11) from {{ marketplace-name }} and nginx web server. Then, it will delete the VM and create an image of its boot disk. After that, the disk will also be deleted.

To create an image:

1. [Prepare your cloud](#before-you-begin).
1. [Install Packer](#install-packer).
1. [Prepare the image configuration](#prepare-image-config).
1. [Create an image](#create-image).
1. [Check the image](#check-image).

If you no longer need the image you created, [delete it](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Configure the environment and infrastructure {#prepare-environment}

1. Install the {{ yandex-cloud }} [command line interface](../../cli/quickstart.md#install).

   {% note tip %}

   If you access the cloud using a [federated account](../../iam/concepts/users/accounts.md#saml-federation) and want to use the CLI from within your VM, [authenticate with the CLI as a service account](../../cli/operations/authentication/service-account.md#vm-auth-as-sa).

   {% endnote %}

1. [Create](../../vpc/quickstart.md) a cloud network with a single subnet in your folder.
1. Get an [OAuth token]({{ link-cloud-oauth }}) for a [Yandex account](../../iam/concepts/users/accounts.md#passport) or an [IAM token](../../iam/operations/iam-token/create-for-federation.md) for a [federated account](../../iam/concepts/users/accounts.md#saml-federation).


### Required paid resources {#paid-resources}

The cost of creating a disk image using Packer includes:
* Fee for storing created images (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-instance-resources)).


## Install and configure Packer {#install-packer}

{% note info %}

{{ yandex-cloud }} requires Packer 1.5 or higher.

{% endnote %}

### From a mirror {#from-y-mirror}

You can download a Packer distribution for your platform from this [mirror](https://hashicorp-releases.yandexcloud.net/packer/). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```bash
export PATH=$PATH:/path/to/packer
```

{% cut "Example of installing Packer from the mirror" %}

{% list tabs group=operating_system %}

- Ubuntu {#ubuntu}

   1. Download the Packer distribution from the mirror and extract it into the `packer` directory:

      ```bash
      mkdir packer
      wget https://hashicorp-releases.yandexcloud.net/packer/1.10.3/packer_1.10.3_linux_amd64.zip -P ~/packer
      unzip ~/packer/packer_1.10.3_linux_amd64.zip -d ~/packer
      ```

   1. Edit the `~/.profile` file:

      1. Open the file:

         ```bash
         nano ~/.profile
         ```

      1. Add the following line to the file:

         ```
         export PATH="$PATH:/home/<username>/packer"
         ```

      1. Save the changes: press **Ctrl** + **X** (**Cmd** + **X**) and select **Y** (`Yes`).

   1. Restart the shell:

      ```bash
      exec -l $SHELL
      ```

{% endlist %}

{% endcut %}

### From the HashiCorp website {#from-hashicorp-site}

Download and install a Packer distribution following the [instructions on the official website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).

### Configure the Yandex Compute Builder plugin {#configure-plugin}

To configure the [plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

1. Create a `config.pkr.hcl` file with the following contents:

   ```hcl
   packer {
     required_plugins {
       yandex = {
         version = ">= 1.1.2"
         source  = "{{ packer-source-link }}"
       }
     }
   }
   ```

1. Install the plugin:

   ```bash
   packer init <config.pkr.hcl_file_path>
   ```

   Result:

   ```text
   Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
   ```

## Prepare the image configuration {#prepare-image-config}

1. Get the folder ID by running the `yc config list` command.
1. Get the subnet ID by running the `yc vpc subnet list` command.
1. Create a JSON file with any name, e.g., `image.json`. This will be your template. Enter the following parameters:


    ```json
    {
      "builders": [
        {
          "type":      "yandex",
          "token":     "<OAuth_or_IAM_token>",
          "folder_id": "<folder_ID>",
          "zone":      "{{ region-id }}-a",

          "image_name":        "debian-11-nginx-not_var{{isotime | clean_resource_name}}",
          "image_family":      "debian-web-server",
          "image_description": "my custom debian with nginx",

          "source_image_family": "debian-11",
          "subnet_id":           "<subnet_ID>",
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

    Where:
    * `token`: OAuth token for a Yandex account or an IAM token for a federated account.
    * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id) to create a VM and its image in.
    * `subnet_id`: ID of the subnet to create a VM and its image in.

{% include [warning-provisioner-metadata](../../_includes/tutorials/infrastructure-management/warning-provisioner-metadata.md) %}

Learn more about image configuration parameters in the [Yandex Compute Builder documentation](https://www.packer.io/docs/builders/yandex).



## Create an image {#create-image}

Build the image using the template:

```
packer build image.json
```

## Check the image {#check-image}

Make sure the image was created:

1. Go to the [management console]({{ link-console-main }}).
1. Select **{{ compute-short-name }}**.
1. Open **Images**. Check if the new disk image is there.

### Delete the resources you created {#clear-out}

If you no longer need the created image, [delete it](../../compute/operations/image-control/delete.md).

Delete the [subnet](../../vpc/operations/subnet-delete.md) and [cloud network](../../vpc/operations/network-delete.md) if these were created specifically to complete the guide.
