---
title: Disabling static keys for access to a {{ objstorage-full-name }} bucket
description: Follow this guide to disable using static access keys for access to an {{ objstorage-name }} bucket.
---

# Disabling static keys for access to a bucket

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

By default, one can access a [bucket](../../concepts/bucket.md) using [static access keys](../../../iam/concepts/authorization/access-key.md). You can disable this access option to only allow access with an [IAM token](../../../iam/concepts/authorization/iam-token.md) or anonymous access, if enabled in the bucket settings.

{% note info %}

Once disabled, access with static keys will be denied to all tools using this access option: the AWS CLI, SDK, and third-party applications. Access via [ephemeral keys](../../security/ephemeral-keys.md), [temporary Security Token Service access keys](../../security/sts.md), and [pre-signed URLs](../../security/overview.md#pre-signed) will also be terminated.

{% endnote %}

The minimum required role to disable access with static keys is `storage.admin`. For more information, see the [role description](../../security/index.md#storage-admin).

To disable bucket access with static keys, follow these steps:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a bucket:

      ```bash
      yc storage bucket update --help
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
      | first-bucket     | b1gmit33ngp6******** | 10737418240 | STANDARD              | 2025-11-20 09:45:36 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Save the `NAME` of the bucket for which you want to disable access with static keys.
  1. Disable using static keys for bucket access:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --disable-statickey-auth true
      ```

      Where:

      * `--name`: Name of the bucket for which you need to disable access with static keys.
      * `--disable-statickey-auth`: Flag to disable access with static keys. It can either be `true` or `false`.

      Result:

      ```text
      name: first-bucket
      folder_id: b1gmit33ngp6********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      disabled_statickey_auth: true
      ```


- REST API {#api}

  To disable bucket access with static keys, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource.

  Run this query:

  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
         "updateMask":"disabledStatickeyAuth",
         "disabledStatickeyAuth":true
        }' \
  "https://storage.{{ api-host }}/storage/v1/buckets/<bucket_name>"
  ```

  Where:

  * `<bucket_name>`: Name of the bucket for which you need to disable access with static keys.
  * `<IAM_token>`: IAM token of the user with the `storage.admin` role for the bucket.

  Result:

  ```json
  {
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.UpdateBucketMetadata",
      "name": "first-bucket"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.Bucket",
      "acl": {},
      "disabledStatickeyAuth": true,
      "name": "first-bucket",
      "folderId": "b1g07hj5r6i4********",
      "defaultStorageClass": "STANDARD",
      "versioning": "VERSIONING_DISABLED",
      "maxSize": "53687091200",
      "createdAt": "2025-11-20T09:45:36.230463Z",
      "resourceId": "e3eruofcbqc2********"
    },
    "id": "e3enqoaug76p********",
    "description": "update bucket",
    "createdAt": "2025-12-22T20:47:01.424654Z",
    "createdBy": "ajeb9l33h6mu********",
    "modifiedAt": "2025-12-22T20:47:01.424654Z"
  }
  ```

  Follow the status of the operation by the `done` field.


- gRPC API {#grpc-api}

  To disable bucket access with static keys, use the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

  Run this query:

  ```bash
  grpcurl \
    -H "Authorization: Bearer <IAM_token>" \
    -d '{
      "name": "<bucket_name>",
      "update_mask": {
        "paths": ["disabled_statickey_auth"]
      },
      "disabled_statickey_auth": true
    }' \
    {{ api-host-storage-grpc }} \
    yandex.cloud.storage.v1.BucketService/Update
  ```

  Where:

  * `<bucket_name>`: Name of the bucket for which you need to disable access with static keys.
  * `<IAM_token>`: IAM token of the user with the `storage.admin` role for the bucket.

  Result:

  ```json
  {
    "id": "e3efo38nps32********",
    "description": "update bucket",
    "createdAt": "2026-04-27T13:25:02.835201Z",
    "createdBy": "ajelcjkv67arbc0qe68j",
    "modifiedAt": "2026-04-27T13:25:02.835201Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.UpdateBucketMetadata",
      "name": "first-bucket"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.storage.v1.Bucket",
      "acl": {},
      "createdAt": "2024-06-07T13:54:56.127808Z",
      "defaultStorageClass": "STANDARD",
      "disabledStatickeyAuth": true,
      "folderId": "b1gsm0k26v1l********",
      "name": "first-bucket",
      "resourceId": "e3ead1djqq0m********",
      "versioning": "VERSIONING_DISABLED"
    }
  }
  ```

{% endlist %}