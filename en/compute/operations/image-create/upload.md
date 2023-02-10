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

These instructions describe the procedure for uploading a Linux OS image file to {{ objstorage-full-name }} as well as for creating an [image](../../concepts/image.md) from it and a virtual machine in {{ compute-name }}.

Popular virtualization systems are supported.

{% note warning %}

In {{ compute-name }}, you can only create images using files uploaded to {{ objstorage-name }}. You can also migrate a VM using [Hystax Acura](../../../tutorials/infrastructure-management/hystax-migration.md).

{% endnote %}

## Prepare an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

For setup instructions, see [{#T}](custom-image.md).

## Upload an image file to {{ objstorage-name }} {#upload-file}

Upload your image to {{ objstorage-name }} and get a link to the uploaded image:
1. If you don't have a bucket in {{ objstorage-name }}, [create](../../../storage/operations/buckets/create.md) one.
1. Upload the image [using the management console](../../../storage/operations/objects/upload.md), the [AWS CLI](../../../storage/tools/aws-cli.md), or [WinSCP](../../../storage/tools/winscp.md), for example. In {{ objstorage-name }} terms, the uploaded image is called an _object_.
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ compute-name }}.

## Create an image in {{ compute-name }} {#create-image}

Create a new image from the link obtained in {{ objstorage-name }}:

{% list tabs %}

- Management console

   1. In the management console, select the folder where you want to create an image.
   1. Select **{{ compute-name }}**.
   1. On the left-hand panel, select ![image](../../../_assets/compute/image-pic.svg) **Images**.
   1. Click **Upload image**.
   1. Enter the image name.

      * Its length can be from 2 to 63 characters.
      * It may contain lowercase Latin letters, numbers, and hyphens.
      * The first character must be a letter. The last character can't be a hyphen.

   1. If necessary, add a description of the image.
   1. Insert the link to the image you received in {{ objstorage-name }}.
   1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **Optimize for deployment**.
   1. Click **Upload**.

- CLI

   To create a new image via the link, use the flag `--source-uri`. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag.

   ```bash
   yc compute image create --name <image-name> --source-uri <image-URL> --pooled
   ```

   Where:

   * `<image-name>` is the name to assign to the image.
   * `<image-URL>` is the link to the image obtained in {{ objstorage-name }}.

   Add a description as required and specify the [family](../../concepts/image.md#family) the image belongs to:

   ```bash
   yc compute image create \
     --name ubuntu-cosmic \
     --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
     --family ubuntu \
     --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
   ```

   If you know the minimum requirements for the size of a disk that will be created from this image, specify the size in GB:

   ```bash
   yc compute image create \
     --name big-image \
     --min-disk-size 20 \
     --source-uri "https://{{ s3-storage-host }}/mybucket/cosmic-server-cloudimg-amd64.vmdk"
   ```

   {% include [min-disk-size](../../_includes_service/min-disk-size.md) %}

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create an image:

   1. Describe the resource parameters in the `yandex_compute_image` configuration file.

      Example configuration file structure:

      ```
      resource "yandex_compute_image" "image-1" {
        name       = "ubuntu-cosmic"
        os_type    = "LINUX"
        source_url = "<link to image in {{ objstorage-name }}>"
        pooled     = "false"
      }
      ```

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. Run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

- API

   Create a new image using the [ImageService/Create](../../api-ref/grpc/image_service.md#Create) method of the gRPC API or the [create](../../api-ref/Image/create.md) method of the REST API `Image` resource. In the request, specify the link to the image.

{% endlist %}

After creation, the image will have the `CREATING` status. Wait until the image status changes to `READY` before using it.

## Delete the image from {{ objstorage-name }} {#delete-image}

If you have successfully created an image, you can [delete the image file](../../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if it doesn't contain any more objects.

## Create a VM from the prepared image {#create-vm-from-user-image}

{% include notitle [How to create a VM from custom image](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

For information about {{ objstorage-name }} pricing, see [{#T}](../../../storage/pricing.md).