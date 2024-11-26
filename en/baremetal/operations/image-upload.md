---
title: How to upload your own image to {{ baremetal-full-name }}
description: Follow this guide to add your own image and deploy a server based on it.
---

# Upload image

You can add your own image and deploy a server based on it. To do this, you must first upload your image file to the {{ objstorage-full-name }} bucket.

## Upload an image file to {{ objstorage-name }} {#upload-file}

Upload your image to {{ objstorage-name }} and get a link to the uploaded image:

1. If you do not have a [bucket](../../storage/concepts/bucket.md) in {{ objstorage-name }}, [create](../../storage/operations/buckets/create.md) one with restricted access.
1. Upload the image [using the management console](../../storage/operations/objects/upload.md), the [AWS CLI](../../storage/tools/aws-cli.md), or [WinSCP](../../storage/tools/winscp.md), for example. In {{ objstorage-name }} terms, the uploaded image is called an _object_.
1. [Get a link](../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ baremetal-name }}.

## Create an image in {{ baremetal-name }} {#create-image}

Create a new image from the link obtained in {{ objstorage-name }}:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a network.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_baremetal }}**.
  1. In the left-hand panel, select ![icon](../../_assets/console-icons/layers.svg) **Boot images**.
  1. Click **Upload image**.
  1. Enter the image name. The naming requirements are as follows:

     * It must be 2 to 63 characters long.
     * It may contain lowercase Latin letters, numbers, and hyphens.
     * It must start with a letter and cannot end with a hyphen.

  1. (Optional) Add a description for your image.
  1. Paste the link to the image you got in {{ objstorage-name }}.
  1. Click **{{ ui-key.yacloud.compute.images.popup-upload_button_upload }}**.

{% endlist %}

## Delete the image from {{ objstorage-name }} {#delete-image}

After creating your image, you can [delete the image file](../../storage/operations/objects/delete.md) from {{ objstorage-name }}. You can also [delete the bucket](../../storage/operations/buckets/delete.md) if it does not contain any more objects.
