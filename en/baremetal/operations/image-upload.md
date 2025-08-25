---
title: How to upload a custom image to {{ baremetal-full-name }}
description: In this tutorial, you will learn how to provision a server from a custom image.
---

# Uploading a custom OS image

You can add a [custom OS or software product image](../concepts/images.md#user-images) to install it on your server on your own. To proceed, first upload your image file to the {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md).

## Uploading an image file to {{ objstorage-name }} {#upload-file}

{% note alert %}

The maximum size of the image file you can upload to {{ objstorage-name }} is 50 GB.

{% endnote %}

{% include [upload-iso-to-bucket](../../_includes/baremetal/upload-iso-to-bucket.md) %}

## Creating an image in {{ baremetal-name }} {#create-image}

Create a new image using the link you got in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder where you want to create your image.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layers.svg) **{{ ui-key.yacloud.baremetal.label_images }}**.
  1. Click **Upload image**.
  1. Specify the image name. The naming requirements are as follows:

       {% include [name-format](../../_includes/name-format.md) %}

  1. Optionally, provide a description for the image.
  1. Paste the link to your image file from {{ objstorage-name }}.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-image }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View the image download command description:

      ```bash
      yc baremetal boot-image create --help
      ```

   1. Download the image:

      ```bash
      yc baremetal boot-image create \
        --name demo-boot-image \
        --description "Boot image for BareMetal" \
        --uri "<image_link>" \
        --labels <label_key>=<label_value>
      ```

      Where:
      * `--name`: Image name. Follow these naming requirements:
        
        {% include [name-format](../../_includes/name-format.md) %}

      * `--description`: Image description. This is an optional setting.
      * `--uri`: Image link you got in {{ objstorage-name }}.
      * `--labels`: Image labels. This is an optional setting.

{% endlist %}

## Deleting the image from {{ objstorage-name }} {#delete-image}

Once your image is successfully created, you can [delete the source image file](../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../storage/operations/buckets/delete.md) if it contains no objects.
