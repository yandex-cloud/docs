---
title: "Uploading a disk image to the cloud"
description: "This tutorial describes the procedure for uploading a Linux OS image file to an {{ objstorage-name }} storage as well as for creating an image from it and a virtual machine in {{ compute-name }}."
keywords:
  - upload image
  - upload disk image
  - upload to cloud
  - disk image
  - OS Linux image
---

# Uploading a disk image to {{ yandex-cloud }}

In this tutorial, you will learn how to upload a Linux OS image file to [{{ objstorage-full-name }}](../../../storage/) and use it to create an [image](../../concepts/image.md) and a [VM](../../concepts/vm.md) in {{ compute-name }}.

Major virtualization systems are supported.

{% note warning %}

In {{ compute-name }}, you can only create images using files uploaded to {{ objstorage-name }}. You can also migrate a VM using [Hystax Acura](../../../tutorials/infrastructure-management/hystax-migration.md).

{% endnote %}

## Prepare an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

For setup instructions, see [{#T}](custom-image.md).

## Upload an image file to {{ objstorage-name }} {#upload-file}

Upload your image to {{ objstorage-name }} and get a link to the uploaded image:
1. If you do not have a [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }}, [create](../../../storage/operations/buckets/create.md) one with restricted access.
1. Upload the image [using the management console](../../../storage/operations/objects/upload.md), the [AWS CLI](../../../storage/tools/aws-cli.md), or [WinSCP](../../../storage/tools/winscp.md), for example. In {{ objstorage-name }} terms, the uploaded image is called an _object_.
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ compute-name }}.

## Create an image in {{ compute-name }} {#create-image}

Create a new image from the link obtained in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an image.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.switch_images }}**.
   1. Click **{{ ui-key.yacloud.compute.images.button_upload }}**.
   1. Enter the image name. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

   1. If necessary, add a description of the image.
   1. Paste the link to the image you got in {{ objstorage-name }}.
   1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
   1. Click **{{ ui-key.yacloud.compute.images.popup-upload_button_upload }}**.

- CLI {#cli}

   To create a new image via the link, use the `--source-uri` flag. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag.

   ```bash
   yc compute image create --name <image_name> --source-uri <image_URL> --pooled
   ```

   Where:
   * `--name`: Name to assign to the image.
   * `--source-uri`: Image link you got in {{ objstorage-name }}.

   Add a description as required and specify the [family](../../concepts/image.md#family) the image belongs to:

   ```bash
   yc compute image create \
     --name ubuntu-cosmic \
     --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
     --family ubuntu \
     --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
   ```

   If you know the minimum requirements for the size of a [disk](../../concepts/disk.md) that will be created from this image, specify the size in GB:

   ```bash
   yc compute image create \
     --name big-image \
     --min-disk-size 20 \
     --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
   ```

   {% include [min-disk-size](../../_includes_service/min-disk-size.md) %}

- {{ TF }} {#tf}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To create an image:
   1. Describe the resource parameters in the `yandex_compute_image` configuration file.

      Here is an example of the configuration file structure:

      ```hcl
      resource "yandex_compute_image" "image-1" {
        name       = "ubuntu-cosmic"
        os_type    = "LINUX"
        source_url = "<image_link>"
        pooled     = "false"
      }
      ```

      Where `source_url` is the link to the image in {{ objstorage-name }}.

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).
   1. Make sure the configuration files are correct.
      1. In the command line, go to the folder where you created the configuration file.
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

   Create a new image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/image_service.md#Create) gRPC API call. In the request, specify the link to the image.

{% endlist %}

Once created, the image will have the `CREATING` status. Wait until the image status changes to `READY` before using it.

## Delete the image from {{ objstorage-name }} {#delete-image}

If you have successfully created an image, you can [delete the image file](../../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if it does not contain any more objects.

## Create a VM from the prepared image {#create-vm-from-user-image}

{% include notitle [How to create a VM from custom image](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

For information about {{ objstorage-name }} pricing, see [{#T}](../../../storage/pricing.md).