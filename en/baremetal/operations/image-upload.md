---
title: How to upload your own image to {{ baremetal-full-name }}
description: Follow this guide to add your own image and deploy a server based on it.
---

# Upload image

You can add your own image and deploy a server based on it. To do this, you must first upload your image file to the {{ objstorage-full-name }} bucket.

## Uploading an image file to {{ objstorage-name }} {#upload-file}

Upload your image file to {{ objstorage-name }} and get a link to it:

1. If you have no {{ objstorage-name }} [bucket](../../storage/concepts/bucket.md) yet, [create](../../storage/operations/buckets/create.md) a bucket with limited access.
1. Upload the image to your bucket, for example, [using the management console](../../storage/operations/objects/upload.md), [AWS CLI](../../storage/tools/aws-cli.md), or [WinSCP](../../storage/tools/winscp.md). Within the {{ objstorage-name }} context, the uploaded image is called an _object_.
1. [Get a link](../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ baremetal-name }}.

## Creating an image in {{ baremetal-name }} {#create-image}

Create a new image from the link you got in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create an image in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layers.svg) **Boot images**.
  1. Click **Upload image**.
  1. Specify the image name. Follow these naming requirements:

       {% include [name-format](../../_includes/name-format.md) %}

  1. (Optional) Add a description for the image.
  1. Paste the link to the image you got in {{ objstorage-name }}.
  1. Click **{{ ui-key.yacloud.baremetal.label_create-image }}**.

{% endlist %}

## Deleting the image from {{ objstorage-name }} {#delete-image}

After creating your image, you can [delete the image file](../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../storage/operations/buckets/delete.md) if it contains no objects.
