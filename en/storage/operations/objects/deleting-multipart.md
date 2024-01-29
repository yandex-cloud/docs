# Deleting a partially uploaded object

You can upload an object in parts using [multipart upload](../../concepts/multipart.md).

To delete a partially uploaded object:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete an object from.
   1. Select **{{ objstorage-name }}**.
   1. Select a bucket that contains a partially uploaded object.
   1. Hover over the yellow field next to the object count.
   1. Click the **{{ ui-key.yacloud.storage.buckets.button_open-multipart-uploads }}** button that appears.
   1. Mark incomplete uploads you want to delete.
   1. Click **{{ ui-key.yacloud.storage.buckets.button_delete }}**.
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

   If you don't know the upload ID (`number`), find it in the list of uploads.

   ```bash
   aws --endpoint-url=https://{{ s3-storage-host }} s3api list-multipart-uploads \
     --bucket <bucket_name>
   ```

- API {#api}

   Use the [abortUpload](../../s3/api-ref/multipart/abortupload.md) S3 API method.

{% endlist %}