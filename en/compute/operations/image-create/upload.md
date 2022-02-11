---
title: Uploading a disk image to the cloud
description: This guide describes how to upload a disk image file to Object Storage with Linux OS, and create an image and a virtual machine from it in the Compute Cloud service.
keywords:
  - image download
  - loading a disk image
  - upload to the cloud
  - disk image
  - Linux OS image
---
# Uploading a disk image to {{ yandex-cloud }}

The following instructions describe how to upload an image file with Linux OS to {{ objstorage-full-name }} and use it to create an [image](../../concepts/image.md) and VM in {{ compute-name }}.

Popular virtualization systems are supported.

{% note warning %}

In {{ compute-name }}, you can only create images using links to files uploaded to {{ objstorage-name }}.

{% endnote %}

## Prepare an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

For setup instructions, see [{#T}](custom-image.md).

## Upload an image file to {{ objstorage-name }} {#upload-file}

Upload your image to {{ objstorage-name }} and get a link to the uploaded image:

1. If you don't have a bucket in {{ objstorage-name }}, [create](../../../storage/operations/buckets/create.md) one.
1. Upload the image to your bucket, for example, [via the management console](../../../storage/operations/objects/upload.md), using the [AWS CLI](../../../storage/tools/aws-cli.md) or [WinSCP](../../../storage/tools/winscp.md). In {{ objstorage-name }} terms, the uploaded image is called an _object_.
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ compute-name }}.

## Create an image in {{ compute-name }} {#create-image}

Create a new image from the link obtained in {{ objstorage-name }}:

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create an image.

  1. Select **{{ compute-name }}**.

  1. On the **Virtual machines** page, go to the **Images** tab.

  1. Click **Upload image**.

  1. Enter the image name.

     {% include [name-format](../../../_includes/name-format.md) %}

  1. If necessary, add a description of the image.

  1. Insert the link to the image you received in {{ objstorage-name }}.

  1. Click **Upload**.

- CLI

  To create a new image via the link, use the flag `--source-uri`.

  ```bash
  yc compute image create --name <image-name> --source-uri <image-URL>
  ```

  Where:
  * `<image-name>` is the name to assign to the image.
  * `<image-URL>` is the link to the image obtained in {{ objstorage-name }}.

  If necessary, add a description and specify the [family](../../concepts/image.md#family) that the image belongs to:

  ```bash
  yc compute image create \
    --name ubuntu-cosmic \
    --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
    --family ubuntu \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  If you know the minimum requirements for the size of a disk that will be created from this image, specify the size in GB:

  ```bash
  yc compute image create \
    --name big-image \
    --min-disk-size 20 \
    --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../_includes_service/min-disk-size.md) %}

- API

  To create a new image via the link, use the [Create](../../api-ref/Image/create.md) method for the `Image` resource. Pass the link to the image in the `uri` parameter.

- Terraform

  If you don't have Terraform, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create an image:

  1. Describe the resource parameters in the `yandex_compute_image` configuration file.

     Example configuration file structure:

     ```
     resource "yandex_compute_image" "image-1" {
       name = "ubuntu-cosmic"
       os_type = "LINUX"
       source_url = "<link to the image in {{ objstorage-name }}>"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

       If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.

     1. Run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

After being created, the image will have the `CREATING` status. Wait until the image status changes to `READY` before using it.

## Delete the image from {{ objstorage-name }} {#delete-image}

If the image was created successfully, you can [delete the image file](../../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if there are no objects left in it.

## Create a VM from the prepared image {#create-vm-from-user-image}

{% include notitle [Creating a VM from the prepared image](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

For information about {{ objstorage-name }} pricing, see [{#T}](../../../storage/pricing.md).

