---
title: Managing object custom metadata in {{ objstorage-full-name }}
description: Follow this guide to manage object custom metadata in an {{ objstorage-name }} bucket.
---

# Managing object custom metadata

When uploading an object to {{ objstorage-name }}, you can provide [custom metadata](../../concepts/object.md#user-meta) in the form of `key-value` pairs.


## Uploading an object with metadata {#load-object-with-meta}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for uploading an object:

      ```bash
      yc storage s3api put-object --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Run this command:

      ```bash
      yc storage s3api put-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --body <local_file_path> \
        --metadata "<key_1>"="<value_1>","<key_2>"="<value_2>"
      ```

      Where:

      * `--bucket`: Name of the bucket you want to upload the object to.
      * `--key`: Bucket object [key](../../concepts/object.md#key).
      * `--body`: Path to the local file you want to upload to the bucket.
      * `--metadata`: Custom metadata provided as comma-separated `key-value` pairs. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII). The value cannot exceed 2 KB.

      Result:

      ```text
      etag: '"65187664ed291179f9244d61********"'
      request_id: 3eca0fd2********
      ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run this command:

  ```bash
  aws s3api put-object \
    --bucket <bucket_name> \
    --key <object_key> \
    --body <local_file_path> \
    --metadata "<key_1>"="<value_1>","<key_2>"="<value_2>" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Name of the bucket you want to upload the object to.
  * `--key`: Bucket object [key](../../concepts/object.md#key).
  * `--body`: Path to the local file you want to upload to the bucket.
  * `--metadata`: Custom metadata provided as comma-separated `key-value` pairs. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII). The value cannot exceed 2 KB.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

  Result:

  ```text
  {
    "ETag": "\"65187664ed291179f9244d61********\""
  }
```

- API {#api}

  Use the [upload](../../s3/api-ref/object/upload.md) S3 API method, e.g., via `curl`.

  Use `curl` [8.3.0](https://curl.se/changes.html) or higher. For more information, see [Example of using the AWS S3 API](../../api-ref/authentication.md#s3-api-example).

  ```bash
  AWS_KEY_ID="<static_key_ID>"
  AWS_SECRET_KEY="<secret_key>"
  LOCAL_FILE="<local_file_path>"
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

  * `AWS_KEY_ID`: Static access key [ID](../../../iam/concepts/authorization/access-key.md#key-id).
  * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
  * `LOCAL_FILE`: Path to the local file you want to upload to the bucket.
  * `BUCKET_NAME`: Name of the bucket you want to upload the object to.
  * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).
  * `META_KEY_1` and `META_KEY_1`: Custom metadata keys. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII).
  * `META_VALUE_1` and `META_VALUE_2`: Custom metadata values. The value cannot exceed 2 KB.

{% endlist %}


## Getting object metadata {#get-object-meta}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting object metadata:

      ```bash
      yc storage s3api head-object --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Get a list of objects in the bucket:

      ```bash
      yc storage s3api list-objects \
        --bucket <bucket_name>
      ```

      Result:

      ```text
      contents:
        - key: object-1.txt
          last_modified: "2025-04-28T11:04:42.796Z"
          etag: '"e807f1fcf82d132f9bb018ca********"'
          size: "10"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        ...
      name: first-bucket
      max_keys: "1000"
      key_count: "9"
      request_id: 8e85efa1********
      ```

  1. Run this command:

      ```bash
      yc storage s3api head-object \
        --bucket <bucket_name> \
        --key <object_key>
      ```

      Where:

      * `--bucket`: Name of the bucket containing the object.
      * `--key`: Bucket object [key](../../concepts/object.md#key).

      Result:

      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: 6428ce25********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run this command:

  ```bash
  aws s3api head-object \
    --bucket <bucket_name> \
    --key <object_key> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Name of the bucket containing the object.
  * `--key`: Bucket object [key](../../concepts/object.md#key).
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

  Result:

  ```text
  {
      "AcceptRanges": "bytes",
      "LastModified": "2025-04-28T11:47:10+00:00",
      "ContentLength": 812,
      "ETag": "\"65187664ed291179f9244d61********\"",
      "ContentType": "application/octet-stream",
      "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
      }
  }
  ```

- API {#api}

  Use the [getObjectMeta](../../s3/api-ref/object/getobjectmeta.md) S3 API method, e.g., via `curl`.

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

  * `AWS_KEY_ID`: Static access key [ID](../../../iam/concepts/authorization/access-key.md#key-id).
  * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
  * `BUCKET_NAME`: Name of the bucket containing the object.
  * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).

{% endlist %}


## Updating object metadata {#update-object-meta}

{% note warning %}

The existing custom metadata will be completely overwritten by the new metadata.

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to copy an object:

      ```bash
      yc storage s3api copy-object --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Get a list of objects in the bucket:

      ```bash
      yc storage s3api list-objects \
        --bucket <bucket_name>
      ```

      Result:

      ```text
      contents:
        - key: object-1.txt
          last_modified: "2025-04-28T11:04:42.796Z"
          etag: '"e807f1fcf82d132f9bb018ca********"'
          size: "10"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        ...
      name: first-bucket
      max_keys: "1000"
      key_count: "9"
      request_id: 8e85efa1********
      ```

  1. Run this command:

      ```bash
      yc storage s3api copy-object \
        --bucket <bucket_name> \
        --key <object_key> \
        --copy-source <bucket_name>/<object_key> \
        --metadata "<key_1>"="<value_1>","<key_2>"="<value_2>" \
        --metadata-directive REPLACE
      ```

      Where:

      * `--bucket`: Name of the bucket where you want to update the object metadata.
      * `--key`: Bucket object [key](../../concepts/object.md#key).
      * `--copy-source`: Path to the object in `<bucket_name>/<object_key>` format.
      * `--metadata`: New custom metadata provided as comma-separated `key-value` pairs. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII). The value cannot exceed 2 KB.
      * `--metadata-directive`: Parameter specifying the need to overwrite the object metadata with new metadata.

      Result:

      ```text
      copy_object_result:
        etag: '"65187664ed291179f9244d61********"'
        last_modified_at: "2025-04-28T11:47:10.351Z"
      request_id: 8b7e94df********
      copy_source_version_id: "null"
      ```

- AWS CLI {#aws-cli}

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

  * `--bucket`: Name of the bucket where you want to update the object metadata.
  * `--key`: Bucket object [key](../../concepts/object.md#key).
  * `--copy-source`: Path to the object in `<bucket_name>/<object_key>` format.
  * `--metadata`: New custom metadata provided as comma-separated `key-value` pairs. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII). The value cannot exceed 2 KB.
  * `--metadata-directive`: Parameter specifying the need to overwrite the object metadata with new metadata.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

  Result:

  ```text
  {
    "CopySourceVersionId": "null",
    "CopyObjectResult": {
        "ETag": "\"65187664ed291179f9244d61********\"",
        "LastModified": "2025-04-28T11:47:10.351000+00:00"
    }
  }
  ```

- API {#api}

  Use the [copy](../../s3/api-ref/object/copy.md) S3 API method, e.g., via `curl`.

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

  * `AWS_KEY_ID`: Static access key [ID](../../../iam/concepts/authorization/access-key.md#key-id).
  * `AWS_SECRET_KEY`: [Secret key](../../../iam/concepts/authorization/access-key.md#private-key).
  * `BUCKET_NAME`: Name of the bucket where you want to update the object metadata.
  * `OBJECT_PATH`: Bucket object [key](../../concepts/object.md#key).
  * `META_KEY_1` and `META_KEY_1`: New custom metadata keys. Keys must only consist of [ASCII characters](https://{{ lang }}.wikipedia.org/wiki/ASCII).
  * `META_VALUE_1` and `META_VALUE_2`: New custom metadata values. The value cannot exceed 2 KB.

{% endlist %}


## Metadata searching {#tags-searching}

{% note info %}

For metadata searching, use the `LIST` and `HEAD` operations. These operations are [not free of charge](../../pricing.md#prices-operations).

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  The {{ yandex-cloud }} CLI offers no built-in function to search objects directly by metadata. However, you can run a _bash_ script to check the metadata of each object in the bucket one by one.

  1. Save your search data to these variables:

      ```bash
      BUCKET_NAME=<bucket_name>
      METADATA_KEY=<metadata_key>
      METADATA_VALUE=<metadata_value>
      ```

  1. Run this command:

      ```bash
      # Going over all objects and checking their metadata
      yc storage s3api list-objects \
        --bucket $BUCKET_NAME \
        --format json | jq -r '.contents[].key' | while read -r key; do

        # Getting object metadata
        metadata=$(yc storage s3api head-object --bucket $BUCKET_NAME --key "$key" --format json)

        # Checking for the right key and the metadata value
        if echo "$metadata" | jq -e ".metadata[\"$METADATA_KEY\"] == \"$METADATA_VALUE\"" > /dev/null; then
          echo "Found an object with required metadata: $key"
          echo "$metadata" | jq
          echo "----------------------------------------"
        fi
      done
      ```

      Result:

      ```text
      Found an object with required metadata: ********.jpg
      {
        "etag": "\"d658ade1b7628f5fa824c60a********\"",
        "request_id": "8dcb3cfb********",
        "accept_ranges": "bytes",
        "content_length": "223840",
        "content_type": "application/octet-stream",
        "last_modified_at": "2025-04-23T10:54:16Z",
        "metadata": {
          "key1": "val1",
          "key2": "val2"
        }
      }
      ----------------------------------------
      ```

- AWS CLI {#aws-cli}

  {% include [aws-cli-install](../../../_includes/aws-cli-install.md) %}

  The AWS CLI offers no built-in function to search for objects directly by metadata. However, you can run a _bash_ script to check the metadata of each object in the bucket one by one.

  1. Save your search data to these variables:

      ```bash
      BUCKET_NAME=<bucket_name>
      METADATA_KEY=<metadata_key>
      METADATA_VALUE=<metadata_value>
      ```

  1. Run this command:

      ```bash
      # Going over all objects and checking their metadata
      aws s3api list-objects \
        --bucket $BUCKET_NAME \
        --endpoint-url=https://{{ s3-storage-host }} \
        --query 'Contents[].Key' \
        --output text | tr '\t' '\n' | while read -r key; do

        # Getting object metadata
          metadata=$(aws s3api head-object \
            --bucket $BUCKET_NAME \
            --key "$key" \
            --endpoint-url=https://{{ s3-storage-host }})

        # Converting METADATA_KEY to uppercase
        uppercase_threshold_key=$(echo "$METADATA_KEY" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

        # Checking for the right key and the metadata value
        echo "$metadata" | jq -e --arg key "$uppercase_threshold_key" --arg value "$METADATA_VALUE" '.Metadata[$key] == $value' > /dev/null
        if [ $? -eq 0 ]; then
          echo "Found an object with required metadata: $key"
          echo "$metadata" | jq
          echo "----------------------------------------"
        fi
      done
      ```

      Result:

      ```text
      Found an object with required metadata: ********.jpg
      {
        "AcceptRanges": "bytes",
        "LastModified": "Wed, 23 Apr 2025 10:54:16 GMT",
        "ContentLength": 223840,
        "ETag": "\"d658ade1b7628f5fa824c60a********\"",
        "ContentType": "application/octet-stream",
        "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
        }
      }
      ----------------------------------------
      ```

- Python (boto3) {#boto3}

  You can search for objects by metadata using [boto3 for Python](../../tools/boto.md).

  1. Create a file named `main.py` with this code:

      ```python
      import boto3
      import sys
      import json
      from datetime import datetime

      def format_response(response, obj_name):
          # Converting the date to the required format
          last_modified = response['LastModified'].strftime("%a, %d %b %Y %H:%M:%S GMT")

          formatted_response = {
              "RequestId": response['ResponseMetadata']['RequestId'],
              "AcceptRanges": response['AcceptRanges'],
              "LastModified": last_modified,
              "ContentLength": response['ContentLength'],
              "ETag": response['ETag'],
              "ContentType": response['ContentType'],
              "Metadata": response['Metadata']
          }

          # Formatted output with indentations
          formatted_output = json.dumps(formatted_response, indent=2, ensure_ascii=False)

          print(f"Found an object with required metadata: {obj_name}")
          print(formatted_output)
          print("----------------------------------------")

      def update_object_metadata(bucket_name, metadata_key, metadata_value):
          s3 = boto3.client('s3')

          obj_names = []
          try:
              # Getting a list of objects
              paginator = s3.get_paginator('list_objects_v2')
              for page in paginator.paginate(Bucket=bucket_name):
                  for obj in page.get('Contents', []):
                      obj_names.append(obj['Key'])

          except Exception as e:
              print(f"Error getting the list of objects: {e}")
              return

          found = False
          for obj_name in obj_names:
              try:
                  # Getting current metadata for the object
                  response = s3.head_object(Bucket=bucket_name, Key=obj_name)
                  current_metadata = response.get('Metadata', {})
                  # Normalizing metadata for comparison purposes
                  normalized_key = metadata_key.lower()
                  # Converting metadata to lowercase
                  normalized_metadata = {key.lower(): value for key, value in current_metadata.items()}
                  # Checking for a match
                  if normalized_metadata.get(normalized_key) == metadata_value:
                      format_response(response, obj_name)
                      found = True

              except s3.exceptions.ClientError as e:
                  print(f"Error getting metadata for the {obj_name} object: {e}")
                  continue

          if not found:
              print('There are no objects with the specified metadata in the bucket.')

      if __name__ == "__main__":
          if len(sys.argv) != 4:
              print("Using: python main.py metadata_key metadata_value bucket_name")
              sys.exit(1)

          metadata_key = sys.argv[1]
          metadata_value = sys.argv[2]
          bucket_name = sys.argv[3]

          update_object_metadata(bucket_name, metadata_key, metadata_value)
      ```

  1. Run the script with your values specified:

      ```bash
      python main.py <metadata_key> <metadata_value> <bucket_name>
      ```

      Result:

      ```text
      Found an object with required metadata: ********.jpg
      {
        "AcceptRanges": "bytes",
        "LastModified": "Wed, 23 Apr 2025 10:54:16 GMT",
        "ContentLength": 223840,
        "ETag": "\"d658ade1b7628f5fa824c60a********\"",
        "ContentType": "application/octet-stream",
        "Metadata": {
          "Key1": "val1",
          "Key2": "val2"
        }
      }
      ----------------------------------------
      ```

{% endlist %}

If an object with the specified metadata exists in the bucket, the terminal will display the information about that object.