---
title: Deleting a partially uploaded object in {{ objstorage-full-name }}
description: Follow this guide to delete a partially uploaded object from a bucket in {{ objstorage-name }}.
---

# Deleting a partially uploaded object

You can upload an object in parts using [multipart upload](../../concepts/multipart.md).

{% include [auto-delete-all-multipart](../../../_includes/storage/auto-delete-all-multipart.md) %}

To manually delete a partially uploaded object:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket that contains a partially uploaded object.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. Go go the right of the search object in a bucket field and enable **{{ ui-key.yacloud.storage.bucket.switch_file-versions }}** to see all versions of objects.
  1. Hover over the yellow field next to the object count.
  1. Click the **{{ ui-key.yacloud.storage.buckets.button_open-multipart-uploads }}** button that appears.
  1. Mark incomplete uploads you want to delete.
  1. Click **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

  In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run the following command:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api abort-multipart-upload \
    --bucket <bucket_name> \
    --key <object_key> \
    --upload-id <upload_ID>
  ```

  If you do not know the upload ID (`number`), find it in the list of uploads.

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api list-multipart-uploads \
    --bucket <bucket_name>
  ```

- API {#api}

  Use the [abortUpload](../../s3/api-ref/multipart/abortupload.md) S3 API method.

{% endlist %}

