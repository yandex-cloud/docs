# Uploading your disk image to Yandex.Cloud

These guidelines describe how to upload a disk image file to Yandex.Cloud and create an [image](../../concepts/image.md) in the {{ compute-name }} service. Supported image formats: Qcow2, VMDK, and VHD. Currently, you cannot upload your own image with the Windows OS.

It's recommended to optimize the image to improve importing speed (even for images which are already in the Qcow2 format):

```
qemu-img convert -p -O qcow2 -o cluster_size=2M <source image file name> <new image file name>
```

## 1. Upload an image file to Yandex.Cloud

Upload your image file to {{ objstorage-full-name }} and get a link to the uploaded image:

1. If you don't have a bucket in {{ objstorage-name }}, [create](../../../storage/operations/buckets/create.md) it.
1. [Upload the image](../../../storage/operations/objects/upload.md) to your bucket. In {{ objstorage-name }} terms, the uploaded image file will be called an _object_.
1. [Get a link](../../../storage/operations/objects/link-for-download.md) to the uploaded image. Use this link when creating an image in {{ compute-name }}.

## 2. Create an image in {{ compute-name }}

Create a new image from the link received in {{ objstorage-name }}:

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create an image.
  1. Click on the **Compute Cloud** tile.
  1. On the **Virtual machines** page, go to the **Images** tab.
  1. Click **Upload image**.
  1. Enter the image name.

      {% include [name-format](../../../_includes/name-format.md) %}

  1. If necessary, add an arbitrary description of the image.
  1. Insert the link to the image you received in {{ objstorage-name }}.
  1. Click **Upload**.

- CLI

  To create a new image via the link, use the flag `--source-uri`.

  ```
  $ yc compute image create --name <IMAGE-NAME> --source-uri <IMAGE-URL>
  ```

  where:

  - `<IMAGE-NAME>` is the name to be assigned to the image.
  - `<IMAGE-URL>` is the link to the image received in {{ objstorage-name }}.

  If necessary, add a description and specify the [family](../../concepts/image.md#family) to which the image refers:

  ```
  $ yc compute image create  \
      --name ubuntu-cosmic \
      --description "Ubuntu Server 18.10 (Cosmic Cuttlefish)" \
      --family ubuntu \
      --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  If you know the minimum requirements for the size of a disk that will be created from this image, specify the size in GB:

  ```
  $ yc compute image create  \
      --name big-image \
      --min-disk-size 20 \
      --source-uri "https://storage.yandexcloud.net/mybucket/cosmic-server-cloudimg-amd64.vmdk"
  ```

  {% include [min-disk-size](../../_includes_service/min-disk-size.md) %}

- API

  To create a new image via the link, use the [Create](../../../_api-ref/compute/api-ref/Image/create.md) method for the `Image` resource. Pass the link to the image in the `uri` element.

{% endlist %}

After being created, the image will get the `CREATING` status. Wait until the image status changes to `READY` before using it.

## 3. Delete the image from {{ objstorage-name }}

If the image was created successfully, you can [delete the image file](../../../storage/operations/objects/delete.md) from the {{ objstorage-name }} service. You can also [delete the bucket](../../../storage/operations/buckets/delete.md) if there are no objects left in it.

For information about the cost of using {{ objstorage-name }}, see the section [{#T}](../../../storage/pricing.md).

