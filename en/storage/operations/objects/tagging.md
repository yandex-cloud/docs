# Object label management

An [object label](../../concepts/tags.md) is a key-value pair used for logical object labeling.

{% include [labels-tags](../../../_includes/storage/labels-tags.md) %}

## Adding or updating labels {#add-edit-tag}

{% list tabs %}

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command that overwrites any existing object labels:

   ```bash
   aws s3api put-object-tagging \
     --bucket <bucket_name> \
     --key <object_key> \
     --tagging 'TagSet=[{Key=<label_key>,Value=<label_value>},{Key=<label_key>,Value=<label_value>}]' \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--tagging`: Array of object labels, where:
      * `Key`: Label key of the `string` type.
      * `Value`: Label value of the `string` type.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API

   To add or edit object labels, use the [putObjectTagging](../../s3/api-ref/object/putobjecttagging.md) S3 API method.

{% endlist %}

## Viewing labels {#get-tag}

{% list tabs %}

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api get-object-tagging \
     --bucket <bucket_name> \
     --key <object_key> \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

   Result:

   ```json
   {
       "TagSet": [
           {
               "Key": "test-key-1",
               "Value": "test-value-1"
           },
           {
               "Key": "test-key-2",
               "Value": "test-value-2"
           }
       ]
   }
   ```

- API

   To view object labels, use the [getObjectTagging](../../s3/api-ref/object/getobjecttagging.md) S3 API method.

{% endlist %}

## Deleting labels {#delete-tag}

{% list tabs %}

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api delete-object-tagging \
     --bucket <bucket_name> \
     --key <object_key> \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Bucket name.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API

   To delete object labels, use the [deleteObjectTagging](../../s3/api-ref/object/deleteobjecttagging.md) S3 API method.

{% endlist %}
