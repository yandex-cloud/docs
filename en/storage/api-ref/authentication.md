---
title: "Authentication in the {{ objstorage-full-name }} API"
description: "To perform operations via the API in {{ objstorage-full-name }}, a scalable data storage, get an IAM token for your account."
---

# Authentication in the {{ objstorage-name }} API

You can use the following types of APIs to work with {{ objstorage-name }}:

* [AWS S3 API](#aws-s3-api).
* [{{ yandex-cloud }} gRPC and REST APIs](#yandex-api).

## AWS S3 API {#aws-s3-api}

To authenticate in the [AWS S3 API](../s3/api-ref/) and work with {{ TF }} and other [supported tools](../tools/), use a [static access key](../../iam/concepts/authorization/access-key.md). For more information, see [How do I use the S3 API?](../../storage/s3/).

For a full list of S3 API methods, see [S3 API reference](../s3/api-ref/).

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

  * `IAM_TOKEN`: IAM token.
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

  * `IAM_TOKEN`: IAM token.
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
