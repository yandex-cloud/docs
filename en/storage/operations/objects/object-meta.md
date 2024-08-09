# Managing an object's custom metadata

When uploading an object to {{ objstorage-name }}, you can provide a set of [custom metadata](../../concepts/object.md#user-meta) in the form of `key-value` pairs.

## Uploading an object with metadata {#load-object-with-meta}

{% list tabs group=instructions %}

- AWS CLI {#cli}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api put-object \
     --bucket <bucket_name> \
     --key <object_key> \
     --body <path_to_local_file> \
     --metadata "<key_1>"="<value_1>","<key_2>"="<value_2>" \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Name of the bucket you want to upload the object to.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--body`: Path to the local file you want to upload to the bucket.
   * `--metadata`: Set of custom metadata in the form of comma separated `key-value` pairs. Keys must consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII) only. The value may not exceed 2 KB.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API {#api}

   Use the S3 API [upload](../../s3/api-ref/object/upload.md) method, e.g., via `curl`.

   Use `curl` [8.3.0](https://curl.se/changes.html) or higher. For more information, see [Example of using the AWS S3 API](../../api-ref/authentication.md#s3-api-example).

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   LOCAL_FILE="<path_to_local_file>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"
   META_KEY_1="<key_1>"
   META_VALUE_1="<value_1>"
   META_KEY_2="<key_2>"
   META_VALUE_2="<value_2>"

   curl \
     --request PUT \
     --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
     --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
     --upload-file "${LOCAL_FILE}" \
     --header "X-Amz-Meta-${META_KEY_1}: ${META_VALUE_1}" \
     --header "X-Amz-Meta-${META_KEY_2}: ${META_VALUE_2}" \
     --verbose \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where:
   * `AWS_KEY_ID`: [ID](../../../iam/concepts/authorization/access-key.md#key-id) of the static access key.
   * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
   * `LOCAL_FILE`: Path to the local file you want to upload to the bucket.
   * `BUCKET_NAME`: Name of the bucket you want to upload the object to.
   * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).
   * `META_KEY_1` and `META_KEY_1`: Custom metadata keys. Keys must consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII) only.
   * `META_VALUE_1` and `META_VALUE_2`: Values of custom metadata. The value may not exceed 2 KB.

{% endlist %}

## Getting object metadata {#get-object-meta}

{% list tabs group=instructions %}

- AWS CLI {#cli}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api head-object \
     --bucket <bucket_name> \
     --key <object_key> \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Name of the bucket the object is placed in.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API {#api}

   Use the S3 API [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md) method, e.g., via `curl`.

   Use `curl` [8.3.0](https://curl.se/changes.html) or higher. For more information, see [Example of using the AWS S3 API](../../api-ref/authentication.md#s3-api-example).

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"

   curl \
     --head \
     --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
     --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where:
   * `AWS_KEY_ID`: [ID](../../../iam/concepts/authorization/access-key.md#key-id) of the static access key.
   * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
   * `BUCKET_NAME`: Name of the bucket the object is placed in.
   * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).

{% endlist %}

## Editing object metadata {#update-object-meta}

{% note warning %}

The existing set of custom metadata will be completely overwritten by the new one.

{% endnote %}

{% list tabs group=instructions %}

- AWS CLI {#cli}

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   In the terminal, run this command:

   ```bash
   aws s3api copy-object \
     --bucket <bucket_name> \
     --key <object_key> \
     --copy-source <bucket_name>/<object_key> \
     --metadata "<key_1>"="<value_1>","<key_2>"="<value_2>" \
     --metadata-directive REPLACE \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   Where:
   * `--bucket`: Name of the bucket you want to edit the object metadata in.
   * `--key`: Bucket object [key](../../concepts/object.md#key).
   * `--copy-source`: Path to the object in `<bucket_name>/<object_key>` format.
   * `--metadata`: Set of new custom metadata in the form of comma separated `key-value` pairs. Keys must consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII) only. The value may not exceed 2 KB.
   * `--metadata-directive`: Parameter indicating that the object metadata must be replaced with a new one.
   * `--endpoint-url`: {{ objstorage-name }} endpoint.

- API {#api}

   Use the S3 API [copy](../../s3/api-ref/object/copy.md) method, e.g., via `curl`.

   Use `curl` [8.3.0](https://curl.se/changes.html) or higher. For more information, see [Example of using the AWS S3 API](../../api-ref/authentication.md#s3-api-example).

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"
   META_KEY_1="<key_1>"
   META_VALUE_1="<value_1>"
   META_KEY_2="<key_2>"
   META_VALUE_2="<value_2>"

   curl \
     --request PUT \
     --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
     --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
     --header "X-Amz-Copy-Source: /${BUCKET_NAME}/${OBJECT_PATH}" \
     --header "X-Amz-Metadata-Directive: REPLACE" \
     --header "X-Amz-Meta-${META_KEY_1}: ${META_VALUE_1}" \
     --header "X-Amz-Meta-${META_KEY_2}: ${META_VALUE_2}" \
     --verbose \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where:
   * `AWS_KEY_ID`: [ID](../../../iam/concepts/authorization/access-key.md#key-id) of the static access key.
   * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
   * `BUCKET_NAME`: Name of the bucket you want to edit the object metadata in.
   * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).
   * `META_KEY_1` and `META_KEY_1`: New custom metadata keys. Keys must consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII) only.
   * `META_VALUE_1` and `META_VALUE_2`: New values of custom metadata. The value may not exceed 2 KB.

{% endlist %}