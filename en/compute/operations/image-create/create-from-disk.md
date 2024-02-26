---
title: "How to create an image from a disk in {{ compute-full-name }}"
description: "Follow this guide to create an image from a disk."
---

# Creating an image from a disk

To create an image from a disk:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create the image.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/hard-drive.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. In the line of the appropriate disk, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.compute.disks.button_action-image }}**.
   1. Enter the image name. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If required, provide a text description for the image.
   1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create an image:

      ```
      yc compute image create --help
      ```

   1. Get a list of disks in the default folder:

      {% include [compute-disk-list](../../../_includes/compute/disk-list.md) %}

   1. Select the identifier (`ID`) or the name (`NAME`) of the desired image.
   1. Create an image in the default folder:

      ```
      yc compute image create \
        --name first-image \
        --source-disk-name first-disk \
        --description "my first image via yc"
      ```

      This command will create an image named `first-image` and the description `my first image via yc` from the `first-disk` disk.

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

   1. Describe the resource parameters in the `yandex_compute_image` configuration file.

      Here is an example of the configuration file structure:

      ```
      resource "yandex_compute_image" "image-1" {
        name        = "<image_name>"
        source_disk = "<disk_ID>"
      }
      ```

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. Run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   1. Get the list of disks using the [list](../../api-ref/Disk/list.md) REST API method for the [Disk](../../api-ref/Disk/index.md) resource or the [DiskService/List](../../api-ref/grpc/disk_service.md#List) gRPC API call.
   1. Create an image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/image_service.md#Create) gRPC API call. Specify the disk ID in your request.

{% endlist %}

An image just created will have the `CREATING` status. Wait until the image status changes to `READY` before using it.
