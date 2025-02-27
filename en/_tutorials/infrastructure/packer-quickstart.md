# Getting started with Packer


[Packer](https://www.packer.io/) enables you to create [VM disk images](../../compute/concepts/image.md) and set their properties in a configuration file. This guide describes how to create a disk image in [{{ compute-full-name }}](../../compute/) using Packer.

In this scenario, Packer will create and launch a [Debian 11](/marketplace/products/yc/debian-11) virtual machine from {{ marketplace-name }}, with a [nginx](https://nginx.org/en/) web server installed on it. Following that, it will delete the VM and create an image of its boot disk. After that, it will also delete the disk.

To create an image:

1. [Get your cloud ready](#before-you-begin).
1. [Install Packer](#install-packer).
1. [Prepare the image configuration](#prepare-image-config).
1. [Create an image](#create-image).
1. [Check the image](#check-image).

If you no longer need the image you created, [delete it](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Configure the environment and infrastructure {#prepare-environment}

1. Install the {{ yandex-cloud }} [command line interface](../../cli/quickstart.md#install) (CLI).

    {% note tip %}

    If you access the cloud with a [federated account](../../iam/concepts/users/accounts.md#saml-federation) and want to use the CLI from within your VM, [get authenticated in the CLI as a service account](../../cli/operations/authentication/service-account.md#vm-auth-as-sa).

    {% endnote %}

1. [Create](../../vpc/quickstart.md) a cloud network with a single subnet in your folder.
1. Get an [OAuth token]({{ link-cloud-oauth }}) for a [Yandex account](../../iam/concepts/users/accounts.md#passport) or an [IAM token](../../iam/operations/iam-token/create-for-federation.md) for a [federated account](../../iam/concepts/users/accounts.md#saml-federation).


### Required paid resources {#paid-resources}

The cost of creating a disk image using Packer includes:

* Fee for storing created images (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-storage)).
* Fee for VM computing resources (see [{{ compute-full-name }} pricing](../../compute/pricing.md#prices-instance-resources)).


## Install and configure Packer {#install-packer}

{% note warning %}

{{ yandex-cloud }} requires Packer 1.5 or higher.

Do not use popular package managers, such as Homebrew or APT, to install Packer. Their repositories may contain obsolete versions.

{% endnote %}

You can install Packer from a [mirror](#from-y-mirror) or the [HashiCorp website](#from-hashicorp-site):


### From a mirror {#from-y-mirror}

Install a Packer distribution kit for your platform from a [mirror](https://hashicorp-releases.yandexcloud.net/packer/):

{% list tabs group=operating_system %}

- Linux {#linux}

  1. Download a Packer distribution kit from the [mirror](https://hashicorp-releases.yandexcloud.net/packer/) and extract it into the `packer` directory:

      ```bash
      mkdir packer
      wget https://hashicorp-releases.yandexcloud.net/packer/1.11.2/packer_1.11.2_linux_amd64.zip -P ~/packer
      unzip ~/packer/packer_1.11.2_linux_amd64.zip -d ~/packer
      ```

      This example uses version `1.11.2`. For the latest Packer version, see the [mirror](https://hashicorp-releases.yandexcloud.net/packer/).

  1. Add Packer to the `PATH` variable: 

      1. Add the following line to the `.profile` file:

          ```bash
          export PATH="$PATH:/home/<username>/packer"
          ```

      1. Save your changes.

      1. Restart the shell:

          ```bash
          exec -l $SHELL
          ```

  1. Make sure you installed Packer:

      ```bash
      packer --version
      ```

      Result:
      
      ```text
      Packer v1.11.2
      ```


- Windows {#windows}

  1. Create the `packer` folder.
  1. Download a Packer distribution kit from the [mirror](https://hashicorp-releases.yandexcloud.net/packer/) and extract it into the `packer` folder:
  1. Add `packer` to the `PATH` variable:

      1. Click **Start** and type **Change system environment variables** in the Windows search bar.
      1. Click **Environment Variables...** at the bottom right.
      1. In the window that opens, find the `PATH` parameter and click **Edit**.
      1. Add the `packer` folder path to the list.
      1. Click **OK**.

  1. Run a new command line session and make sure you installed Packer:

      ```bash
      packer --version
      ```

      Result:

      ```text
      Packer v1.11.2
      ```

- macOS {#macos}

  1. Download a Packer distribution kit from the [mirror](https://hashicorp-releases.yandexcloud.net/packer/) and extract it into the `packer` directory:

      ```bash
      mkdir packer
      curl --location --output ~/packer/packer_1.11.2_darwin_amd64.zip https://hashicorp-releases.yandexcloud.net/packer/1.11.2/packer_1.11.2_darwin_amd64.zip
      unzip ~/packer/packer_1.11.2_darwin_amd64.zip -d ~/packer
      ```

      This example uses version `1.11.2`. For the latest Packer version, see the [mirror](https://hashicorp-releases.yandexcloud.net/packer/).

  1. Add Packer to the `PATH` variable: 

      ```bash
      echo 'export PATH="$PATH:$HOME/<username>/packer"' >> ~/.bash_profile
      source ~/.bash_profile
      ```

  1. Restart the shell:

      ```bash
      exec -l $SHELL
      ```

  1. Make sure you installed Packer:

      ```bash
      packer --version
      ```

      Result:
      
      ```text
      Packer v1.11.2
      ```

{% endlist %}


### From the HashiCorp website {#from-hashicorp-site}

Download and install a Packer distribution kit following [this guide on the Packer website](https://www.packer.io/intro/getting-started/install.html#precompiled-binaries).


### Configure the Yandex Compute Builder plugin {#configure-plugin}

To configure the [plugin](https://developer.hashicorp.com/packer/plugins/builders/yandex):

1. Create a file named `config.pkr.hcl` with the following contents:

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
    packer init <path_to_config.pkr.hcl>
    ```

    Result:

    ```text
    Installed plugin github.com/hashicorp/yandex v1.1.2 in ...
    ```

## Prepare the image configuration {#prepare-image-config}

1. [Get](../../resource-manager/operations/folder/get-id.md) the folder ID.
1. [Get](../../vpc/operations/subnet-get-info.md) the subnet ID and the [availability zone](../../overview/concepts/geo-scope.md) it resides in.
1. Prepare the subnet ID by running the `yc vpc subnet list` command.
1. Create a JSON file with any name, e.g., `image.json`. Add this configuration to it:

    
    ```json
    {
      "builders": [
        {
          "type":      "yandex",
          "token":     "<OAuth_token_or_IAM_token>",
          "folder_id": "<folder_ID>",
          "zone":      "<availability_zone>",

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
    * `<availability_zone>`: [Availability zone](../../overview/concepts/geo-scope.md) where you are going to create the VM, e.g., `{{ region-id }}-d`.
    * `token`: OAuth token for a Yandex account or an IAM token for a federated account.
    * `folder_id`: ID of the folder where you are going to create the VM and its image.
    * `subnet_id`: ID of the subnet where you are going to create the VM and its image.

{% include [warning-provisioner-metadata](../../_includes/tutorials/infrastructure-management/warning-provisioner-metadata.md) %}

You can learn more about image configuration properties in [this Yandex Compute Builder overview article](https://www.packer.io/docs/builders/yandex).


## Create an image {#create-image}

1. Build the image using the configuration properties:

    ```bash
    packer build image.json
    ```

1. Wait for the build to complete:

    ```bash
    ...
    ==> Wait completed after 2 minutes 43 seconds
    ==> Builds finished. The artifacts of successful builds are:
    --> yandex: A disk image was created: debian-11-nginx-2024-08-26t15-30-39z (id: fd82d63b9bgc********) with family name debian-web-server
    ```


## Check the image {#check-image}

Make sure you created the image:

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. Open the ![image](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}** section. Make sure the new disk image is there.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Run this command:

  ```bash
  yc compute image list
  ```

  Result:

  ```text
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  |          ID          |                 NAME                 |      FAMILY       |     PRODUCT IDS      | STATUS |
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  | fd82d63b9bgc******** | debian-11-nginx-2024-08-26t15-30-39z | debian-web-server | f2eerqfup7lg******** | READY  |
  +----------------------+--------------------------------------+-------------------+----------------------+--------+
  ```

{% endlist %}


### Delete the resources you created {#clear-out}

If you no longer need the image you created, [delete it](../../compute/operations/image-control/delete.md).

Delete the [subnet](../../vpc/operations/subnet-delete.md) and [cloud network](../../vpc/operations/network-delete.md) if you created them specifically to follow this tutorial.
