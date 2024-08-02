---
title: "Authentication in the {{ objstorage-full-name }} API"
description: "To perform operations via the API in {{ objstorage-full-name }}, a scalable data storage, get an IAM token for your account."
---

# Authentication with the {{ objstorage-name }} API

You can use the following types of APIs to work with {{ objstorage-name }}:

* [AWS S3 API](#aws-s3-api)
* [{{ yandex-cloud }} gRPC and REST APIs](#yandex-api)

## AWS S3 API {#aws-s3-api}

To authenticate in the [AWS S3 API](../s3/api-ref/) and work with {{ TF }} and other [supported tools](../tools/), use a [static access key](../../iam/concepts/authorization/access-key.md). A static access key is issued for a specific [service account](../../iam/concepts/users/service-accounts.md), and all actions involving this key are performed on behalf of this service account. For more information, see [How do I use the S3 API?](../../storage/s3/).

{% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}

For a full list of S3 API methods, see [S3 API reference](../s3/api-ref/).

{% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

If you want to use the AWS S3 API directly (without an SDK or apps), you will need to [sign requests](../s3/signing-requests.md) yourself. You can test the request and signature generation process using the AWS CLI in [debug mode](../s3/signing-requests.md#debugging).

### AWS S3 API usage example {#s3-api-example}

Starting from version [8.3.0](https://curl.se/changes.html), the `curl` utility supports automatic generation of the [signature string](../s3/signing-requests.md#string-to-sign-gen), [request signing](../s3/signing-requests.md#signing), and substitution of the required headers when working with the AWS S3 API.

You can also generate these headers and sign requests manually. See the example for **curl 8.2.1 and lower**.

{% note info %}

Make sure that the service account you are using to make the request has the permissions to perform the requested action. For example, to upload an object into a bucket, [assign](../../iam/operations/sa/assign-role-for-sa.md) the `storage.uploader` [role](../security/index.md#storage-uploader) for the bucket to the service account. For more information, see [{#T}](../security/overview.md).

{% endnote %}

Below are examples of requests for uploading an object to a bucket.

{% list tabs %}

- curl 8.3.0 and higher

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   LOCAL_FILE="<path_to_local_file>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"

   curl \
     --request PUT \
     --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
     --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
     --upload-file "${LOCAL_FILE}" \
     --verbose \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where:
   * `AWS_KEY_ID`: [ID](../../iam/concepts/authorization/access-key.md#key-id) of the static access key.
   * `AWS_SECRET_KEY`: [Secret key](../../iam/concepts/authorization/access-key.md#private-key).
   * `LOCAL_FILE`: Path to the local file you want to upload, e.g., `./sample.txt`.
   * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
   * `OBJECT_PATH`: [Key](../concepts/object.md#key) that will be assigned to the object in the bucket, e.g., `new-prefix/sample-object.txt`.

   In the same way, you can upload the file to the bucket without saving it locally. For example, archive the directory and send the archive to the bucket:

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"
   DIRECTORY_PATH="<directory_path>"

   tar -cvzf - "${DIRECTORY_PATH}" | curl \
     --request PUT \
     --user "${AWS_KEY_ID}:${AWS_SECRET_KEY}" \
     --aws-sigv4 "aws:amz:{{ region-id }}:s3" \
     --upload-file - \
     --verbose \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where `DIRECTORY_PATH` is the path to the directory you want to archive.

- curl 8.2.1 and lower

   ```bash
   AWS_KEY_ID="<static_key_ID>"
   AWS_SECRET_KEY="<secret_key>"
   LOCAL_FILE="<path_to_local_file>"
   BUCKET_NAME="<bucket_name>"
   OBJECT_PATH="<object_key>"
   CONTENT_TYPE="<object_MIME_type>"
   DATE_VALUE=`date -R`
   STRING_TO_SIGN="PUT\n\n${CONTENT_TYPE}\n${DATE_VALUE}\n/${BUCKET_NAME}/${OBJECT_PATH}"
   SIGNATURE=`echo -en ${STRING_TO_SIGN} | openssl sha1 -hmac ${AWS_SECRET_KEY} -binary | base64`

   curl \
     --request PUT \
     --upload-file "${LOCAL_FILE}" \
     --verbose \
     --header "Host: {{ s3-storage-host }}" \
     --header "Date: ${DATE_VALUE}" \
     --header "Content-Type: ${CONTENT_TYPE}" \
     --header "Authorization: AWS ${AWS_KEY_ID}:${SIGNATURE}" \
     "https://{{ s3-storage-host }}/${BUCKET_NAME}/${OBJECT_PATH}"
   ```

   Where:
   * `AWS_KEY_ID`: [ID](../../iam/concepts/authorization/access-key.md#key-id) of the static access key.
   * `AWS_SECRET_KEY`: [Secret key](../../iam/concepts/authorization/access-key.md#private-key).
   * `LOCAL_FILE`: Path to the local file you want to upload, e.g., `./sample.txt`.
   * `BUCKET_NAME`: [Name of the bucket](../concepts/bucket.md#naming) to upload the file to.
   * `OBJECT_PATH`: [Key](../concepts/object.md#key) that will be assigned to the object in the bucket, e.g., `new-prefix/sample-object.txt`.
   * `CONTENT_TYPE`: [MIME type](https://en.wikipedia.org/wiki/Media_type) of the object you are uploading, e.g., `text/plain`.

{% endlist %}

## {{ yandex-cloud }} gRPC and REST APIs {#yandex-api}


For authentication in {{ yandex-cloud }} gRPC and REST APIs, get an [IAM token](../../iam/concepts/authorization/iam-token.md). Learn more about how to get an IAM token for different types of accounts:

* [Yandex account](../../iam/operations/iam-token/create.md).
* [Federated account](../../iam/operations/iam-token/create-for-federation.md).
* [Service account](../../iam/operations/iam-token/create-for-sa.md).

{% include [iam-token-usage](../../_includes/iam-token-usage.md) %}


For a full list of {{ yandex-cloud }} API calls and methods, see [gRPC API](../api-ref/grpc/) and [REST API](../api-ref/) references.


### {{ yandex-cloud }} API usage example {#example}

In the example, a 50GB bucket is created with a standard storage class.

{% list tabs %}

- gRPC

  ```bash
  export IAM_TOKEN="<IAM token>"
  grpcurl \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{
      "name": "<bucket_name>",
      "folder_id": "<folder_ID>",
      "default_storage_class": "STANDARD",
      "max_size": "53687091200",
      "anonymous_access_flags": [{
        "read": false,
        "list": false,
        "configRead": false
      }]
    }' \
    storage.{{ api-host }}:443 \
    {{ at-event-prefix }}.storage.v1.BucketService/Create
  ```

  Where:

  * `IAM_TOKEN`: IAM token. See [Getting an IAM token](../../iam/operations/index.md#iam-tokens) for details.
  * `name`: Bucket name.
  * `folder_id`: Folder [ID](../../resource-manager/operations/folder/get-id.md).
  * `default_storage_class`: Storage [class](../../storage/concepts/storage-class.md).
  * `max_size`: Bucket size.
  * `anonymous_access_flags`: Bucket [access](../..//storage/concepts/bucket.md#bucket-access) settings:
    * `read`: Public access to read objects.
    * `list`: Public access to the list of objects.
    * `configRead`: Public access to read the configuration.

  Result:

  ```text
  {
    "id": "e3ehmmasama1********",
    "description": "create bucket",
    "createdAt": "2023-08-10T06:32:19.836842Z",
    "createdBy": "ajego134p5h1********",
    "modifiedAt": "2023-08-10T06:32:19.836842Z",
    "done": true,
    "metadata": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.CreateBucketMetadata","name":"<bucket_name>"},
    "response": {"@type":"type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket","acl":{},"anonymousAccessFlags":{"read":false,"list":false},"createdAt":"2023-08-10T06:32:17.557756Z","defaultStorageClass":"STANDARD","folderId":"b1gmit33ngp3********","maxSize":"53687091200","name":"<bucket_name>","versioning":"VERSIONING_DISABLED"}
  }
  ```

- REST

  ```bash
  export IAM_TOKEN="<IAM token>"
  curl -X POST \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $IAM_TOKEN" \
    -d '{
      "name": "<bucket_name>",
      "folderId": "<folder_ID>",
      "defaultStorageClass": "STANDARD",
      "maxSize": "53687091200",
      "anonymousAccessFlags": {
        "read": false,
        "list": false,
        "configRead": false
      }
    }' \
    https://storage.{{ api-host }}/storage/v1/buckets
  ```

  Where:

  * `IAM_TOKEN`: IAM token. See [Getting an IAM token](../../iam/operations/index.md#iam-tokens) for details.
  * `name`: Bucket name.
  * `folderId`: Folder [ID](../../resource-manager/operations/folder/get-id.md).
  * `default_storage_class`: Storage [class](../../storage/concepts/storage-class.md).
  * `maxSize`: Bucket size.
  * `anonymousAccessFlags`: Bucket [access](../..//storage/concepts/bucket.md#bucket-access) settings:
     * `read`: Public access to read objects.
     * `list`: Public access to the list of objects.
     * `configRead`: Public access to read the configuration.

  Result:

  ```text
  {
  "done": true,
  "metadata": {
    "@type": "type.googleapis.com/{{ at-event-prefix }}.storage.v1.CreateBucketMetadata",
    "name": "<bucket_name>"
  },
  "response": {
    "@type": "type.googleapis.com/{{ at-event-prefix }}.storage.v1.Bucket",
    "anonymousAccessFlags": {
    "read": false,
    "list": false
    },
    "acl": {},
    "name": "<bucket_name>",
    "folderId": "b1gmit33ngp3********",
    "defaultStorageClass": "STANDARD",
    "versioning": "VERSIONING_DISABLED",
    "maxSize": "53687091200",
    "createdAt": "2023-08-08T12:54:29.321021Z"
  },
  "id": "e3enrkcct2pt********",
  "description": "create bucket",
  "createdAt": "2023-08-08T12:54:32.111022Z",
  "createdBy": "ajego134p5h1********",
  "modifiedAt": "2023-08-08T12:54:32.111022Z"
  }
  ```

{% endlist %}
