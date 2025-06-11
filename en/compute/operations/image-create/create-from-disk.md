---
title: How to create an image from a disk in {{ compute-full-name }}
description: Follow this guide to create an image from a disk.
---

# Creating an image from a disk

To create an image from a disk:

{% list tabs group=instructions %}

- Management console {#console}

  {% note info %}
  
  {% include [create-unreplicated-instance-via-cli-tf-api](../../_includes_service/create-unreplicated-instance-via-cli-tf-api.md) %}
  
  {% endnote %}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create an image.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.disks_ddfdb }}**.
  1. In the line with the disk, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-image }}**.
  1. Enter a name for the image. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Provide a text description for the image, if required.
  1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating an image:
  
      ```
      yc compute image create --help
      ```
  
  1. Get a list of disks in the default folder:
  
      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}
  
  1. Select `ID` or `NAME` of the disk you need.
  1. Create an image in the default folder:
  
      ```
      yc compute image create \
        --name first-image \
        --source-disk-name first-disk \
        --description "my first image via yc"
      ```
  
      This command will create an image named `first-image` described as `my first image via yc` from `first-disk`.

      To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag:

      ```
      yc compute image create \
        --name first-image \
        --source-disk-name first-disk \
        --description "my first image via yc" \
        --pooled
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Define the parameters of the `yandex_compute_image` resource in the configuration file.

     Here is an example of the configuration file structure:

     ```
     resource "yandex_compute_image" "image-1" {
       name        = "<image_name>"
       source_disk = "<disk_ID>"
     }
     ```

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

       If the configuration is correct, the terminal will display a list of resources to create and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. Run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  1. Get a list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/Disk/list.md) gRPC API call.
  1. Create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. Specify the disk ID in your request.

{% endlist %}

Once created, the image will get the `CREATING` status. Wait until its status changes to `READY` before using it.
