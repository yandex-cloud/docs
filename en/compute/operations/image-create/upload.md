---
title: Uploading a disk image to a cloud
description: This guide describes how to upload a disk image file to a Linux {{ objstorage-name }} and use it to create an image and a virtual machine in {{ compute-name }}.
keywords:
  - upload image
  - upload disk image
  - upload to cloud
  - disk image
  - Linux image
---

# Uploading a custom disk image to {{ yandex-cloud }}

This guide explains how to upload a Linux image file to [{{ objstorage-full-name }}](../../../storage/) and use it to create an [image](../../concepts/image.md) and a [VM](../../concepts/vm.md) in {{ compute-name }}.

Major virtualization systems are supported.

{% note warning %}

In {{ compute-name }}, you can only create images using files uploaded to {{ objstorage-name }}. You can also migrate a VM using [Hystax Acura](../../../tutorials/infrastructure-management/hystax-migration.md).

{% endnote %}

## Preparing an image file {#prepare-file}

{% include [image-create-requirements](../../../_includes/compute/image-create-requirements.md) %}

{% include [available-image-format](../../../_includes/compute/available-image-format.md) %}

For configuration steps, see [{#T}](custom-image.md).

## Uploading an image file to {{ objstorage-name }} {#upload-file}

Upload your image file to {{ objstorage-name }} and get a link to it:

1. If you do not have a [bucket](../../../storage/concepts/bucket.md) in {{ objstorage-name }} yet, [create](../../../storage/operations/buckets/create.md) one with restricted access.
1. Upload the image to your bucket, for example, [using the management console](../../../storage/operations/objects/upload.md), [AWS CLI](../../../storage/tools/aws-cli.md), or [WinSCP](../../../storage/tools/winscp.md). Within the {{ objstorage-name }} context, the uploaded image is called an _object_.
1. [Get](../../../storage/operations/objects/link-for-download.md) a signed [link](../../../storage/concepts/pre-signed-urls.md) to download the image from the bucket. Use this link when creating an image in {{ compute-name }}.

## Creating an image in {{ compute-name }} {#create-image}

Create a new image from the link you got in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the management console, select the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create an image.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.compute.images_e7RdQ }}**.
  1. Click **{{ ui-key.yacloud.compute.images.button_upload }}**.
  1. Name your image. The naming requirements are as follows:

      {% include [name-format](../../../_includes/name-format.md) %}

  1. Add a description for the image, if required.
  1. Paste the link to the image you got in {{ objstorage-name }}.
  1. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), enable **{{ ui-key.yacloud.compute.images.popup-upload_field_pooled }}**.
  1. Click **{{ ui-key.yacloud.common.button_upload }}**.

- CLI {#cli}

  To create a new image via the link, use the `--source-uri` parameter. To create an [optimized image](../../concepts/image.md#images-optimized-for-deployment), use the `--pooled` flag.

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

  If you know the minimum required size of a [disk](../../concepts/disk.md) to create from this image, specify it in GB:

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
  1. Specify the parameters of the `yandex_compute_image` resource in the configuration file.

     Here is an example of the configuration file structure:

     ```hcl
     resource "yandex_compute_image" "image-1" {
       name       = "ubuntu-cosmic"
       os_type    = "LINUX"
       source_url = "<image_link>"
       pooled     = "false"
     }
     ```

     Where `source_url` is the image link in {{ objstorage-name }}.

     For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).
  1. Make sure the configuration files are correct.
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

       If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.
  1. Deploy the cloud resources.
     1. Run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Create a new image using the [create](../../api-ref/Image/create.md) REST API method for the [Image](../../api-ref/Image/index.md) resource or the [ImageService/Create](../../api-ref/grpc/Image/create.md) gRPC API call. In the request, specify the link to the image.

{% endlist %}

Once created, the image will get the `CREATING` status. Wait until its status changes to `READY` before using it.

## Deleting the image from {{ objstorage-name }} {#delete-image}

If you have successfully created an image, you can [delete the image file](../../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if it contains no objects.

## Creating a VM from a pre-built image {#create-vm-from-user-image}

You can create a VM with disks from a pre-built image.

{% include notitle [How to create a VM from custom image](../../operations/vm-create/create-from-user-image.md#create-vm-from-image) %}

For information about {{ objstorage-name }} pricing, see [{#T}](../../../storage/pricing.md).