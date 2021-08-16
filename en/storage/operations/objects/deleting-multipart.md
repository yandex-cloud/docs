# Deleting a partially uploaded object

You can upload an object in parts using [multipart upload](../../concepts/multipart.md). You can't see or delete these objects in the management console. To do this, use [tools](../../tools/index.md) that support multipart uploads.

{% list tabs %}

- AWS CLI

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api abort-multipart-upload --bucket <bucket-name> --key <key> --upload-id <number>
  ```

  If you don't know the upload ID (`number`), find it in the list of uploads.

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} s3api list-multipart-uploads --bucket <bucket-name>
  ```

{% endlist %}

