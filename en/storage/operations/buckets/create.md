# Creating a bucket

{% list tabs %}

- Management console
  1. In the management console, select the folder where you want to create a [bucket](../../concepts/bucket.md).
  1. Select **Object Storage**.
This opens a page with a list of buckets.
  1. Click **Create bucket**.
  1. On the bucket creation page:
      1. Enter the bucket name, following the [naming guidelines](../../concepts/bucket.md#naming).

      1. If necessary, limit the maximum bucket size.

          {% include [storage-no-max-limit](../../_includes_service/storage-no-max-limit.md) %}

      1. Selected the type of [access](../../concepts/bucket.md#bucket-access).

      1. Select the default [storage class](../../concepts/storage-class.md) by default.

      1. Click **Create bucket** to complete the operation.

{% endlist %}
