---
title: Managing metadata export of bucket objects (S3 Inventory)
description: In this guide, you will learn how to manage object metadata export in a {{ objstorage-full-name }} bucket.
---

# Managing metadata export of bucket objects (S3 Inventory)

In {{ objstorage-name }}, you can [export metadata](../../concepts/s3-inventory.md) of bucket objects (S3 Inventory) for further analysis and cataloging.

{% include [s3-inventory-pricing](../../../_includes/storage/s3-inventory-pricing.md) %}

## Creating an export configuration {#create-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command to create an export configuration:

      ```bash
      yc storage bucket create-inventory-configuration --help
      ```

  1. Create an export configuration:

      ```bash
      yc storage bucket create-inventory-configuration \
        --name <bucket_name> \
        --configuration '{
          "id": "test_config",
          "is_enabled": true,
          "schedule": {
            "frequency": "DAILY"
          },
          "destination": {
            "bucket_destination": {
              "bucket": "<target_bucket_name>",
              "format": "CSV",
              "prefix": "inventory"
            }
          },
          "filter": {
            "prefix": "for_inventory"
          },
          "included_object_versions": "ALL",
          "optional_fields": [
            "SIZE",
            "LAST_MODIFIED_DATE",
            "STORAGE_CLASS",
            "ETAG",
            "IS_MULTIPART_UPLOADED",
            "ENCRYPTION_STATUS",
            "OBJECT_LOCK_RETAIN_UNTIL_DATE",
            "OBJECT_LOCK_MODE",
            "OBJECT_LOCK_LEGAL_HOLD_STATUS",
            "CHECKSUM_ALGORITHM",
            "OBJECT_ACCESS_CONTROL_LIST",
            "OBJECT_OWNER"
          ]
        }'
      ```

      Where:

      * `--name`: Name of the bucket whose object metadata you want to export.
      * `--configuration`: Export configuration options:      
        * `id`: Configuration ID. This is a required setting.
        * `is_enabled`: Flag to enable or disable the configuration.
        * `frequency`: Export frequency. This is a required setting. The possible values are:
          * `DAILY`: Once a day.
          * `WEEKLY`: Once a week.
        * `destination`: Information on where and how to publish export results:
          * `bucket`: Name of the bucket for metadata export. The source and target buckets must be in the same [cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud). This is a required setting.
          * `format`: Export results format. Only `CSV` is supported. This is a required setting.
          * `prefix`: Folder (prefix) to generate export results in.
        * `included_object_versions`: [Versions](../../concepts/versioning.md) of objects to include in the export list. This is a required setting. The possible values are:
          * `ALL`: All versions.
          * `CURRENT`: Current version.
        * `filter`: Filter for objects to include in the export. In the `prefix` field, specify a folder containing the objects to include in the export list. This is an optional setting.
        * `optional_fields`: Array of exported metadata types:
          * `SIZE`: Object size in bytes.
          * `LAST_MODIFIED_DATE`: Date the object was created or last modified.
          * `STORAGE_CLASS`: [Storage class](../../concepts/storage-class.md).
          * `ETAG`: Object hash.
          * `IS_MULTIPART_UPLOADED`: Indicates whether the object was uploaded via a [multipart upload](../../concepts/multipart.md).
          * `ENCRYPTION_STATUS`: Object [encryption](../../concepts/encryption.md) status.
          * `OBJECT_LOCK_RETAIN_UNTIL_DATE`: Expiration date of the object [version lock](../../concepts/object-lock.md).
          * `OBJECT_LOCK_MODE`: Type of the object version lock.
          * `OBJECT_LOCK_LEGAL_HOLD_STATUS`: Object version legal hold status.
          * `CHECKSUM_ALGORITHM`: Algorithm used to compute the object checksum.
          * `OBJECT_ACCESS_CONTROL_LIST`: Object [access control list](../../concepts/acl.md) (ACL).
          * `OBJECT_OWNER`: Object owner.

      You can also create a configuration file in JSON format and provide it in this command:

      ```bash
      yc storage bucket create-inventory-configuration \
        --name <bucket_name> \
        --configuration "$(cat <file_path>)"
      ```

      {% cut "File contents example" %}

      ```json
      {
        "id": "test_config",
        "is_enabled": true,
        "schedule": {
          "frequency": "WEEKLY"
        },
        "destination": {
          "bucket_destination": {
            "bucket": "<target_bucket_name>",
            "format": "CSV",
            "prefix": "inventory"
          }
        },
        "included_object_versions": "ALL",
        "optional_fields": [
          "SIZE",
          "LAST_MODIFIED_DATE",
          "STORAGE_CLASS",
          "ETAG",
          "IS_MULTIPART_UPLOADED",
          "ENCRYPTION_STATUS",
          "OBJECT_LOCK_RETAIN_UNTIL_DATE",
          "OBJECT_LOCK_MODE",
          "OBJECT_LOCK_LEGAL_HOLD_STATUS",
          "CHECKSUM_ALGORITHM",
          "OBJECT_ACCESS_CONTROL_LIST",
          "OBJECT_OWNER"
        ]
      }
      ```

      {% endcut %}

- API {#api}

  To create an export configuration, use the [createInventoryConfiguration](../../api-ref/Bucket/createInventoryConfiguration.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService.CreateInventoryConfiguration](../../api-ref/grpc/Bucket/createInventoryConfiguration.md) gRPC API call.

{% endlist %}

## Downloading export results {#get-result}

You will get results in multiple files:

* Manifest:

  * `<export_prefix>/<source_bucket_name>/<configuration_ID>/<export_date>/manifest.json`: Export manifest.
  * `<export_prefix>/<source_bucket_name>/<configuration_ID>/<export_date>/manifest.checksum`: Manifest checksums.

    Where:
    
    * `<export_prefix>`: Prefix used for the export.
    * `<source_bucket_name>`: Name of the source bucket for metadata export.
    * `<configuration_ID>`: Export configuration ID.
    * `<export_date>`: Export date in `YYYY-MM-DDThh:mmZ` format.

* Report: `<export_prefix>/<source_bucket_name>/<configuration_ID>/data/<report_name>.csv`, where `<report_name>` is the report [UUID](https://{{ lang }}.wikipedia.org/wiki/UUID).

  For large buckets, the report may be split into multiple files.

You can [download](../objects/download.md) export results just like other objects.

## Getting a list of export configurations {#list-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for viewing a list of export configurations:

      ```bash
      yc storage bucket list-inventory-configurations --help
      ```

  1. Get a list of export configurations for the bucket:

      ```bash
      yc storage bucket list-inventory-configurations <bucket_name>
      ```

      Result:

      ```text
      configurations:
        - id: test_config
          destination:
            bucket_destination:
              bucket: test-bucket
              format: CSV
              prefix: inventory
          included_object_versions: ALL
          is_enabled: true
          schedule:
            frequency: DAILY
          optional_fields:
            - SIZE
            - LAST_MODIFIED_DATE
            - STORAGE_CLASS
            - ETAG
            - IS_MULTIPART_UPLOADED
            - ENCRYPTION_STATUS
            - OBJECT_LOCK_RETAIN_UNTIL_DATE
            - OBJECT_LOCK_MODE
            - OBJECT_LOCK_LEGAL_HOLD_STATUS
            - CHECKSUM_ALGORITHM
            - OBJECT_ACCESS_CONTROL_LIST
            - OBJECT_OWNER
      ```

- API {#api}

  To view a list of export configurations, use the [listInventoryConfigurations](../../api-ref/Bucket/listInventoryConfigurations.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService.ListInventoryConfigurations](../../api-ref/grpc/Bucket/listInventoryConfigurations.md) gRPC API call.

{% endlist %}

## Getting information about an export configuration {#get-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to view an export configuration:

      ```bash
      yc storage bucket get-inventory-configuration --help
      ```

  1. [Get a list](#list-inventory) of export configurations for the bucket and copy the value in the `id` field of the configuration you need.

  1. Get information about an export configuration:

      ```bash
      yc storage bucket get-inventory-configuration <bucket_name> --id <export_ID>
      ```

      Result:

      ```text
      id: test_config
      destination:
        bucket_destination:
          bucket: test-bucket
          format: CSV
          prefix: inventory
      included_object_versions: ALL
      is_enabled: true
      schedule:
        frequency: DAILY
      optional_fields:
        - SIZE
        - LAST_MODIFIED_DATE
        - STORAGE_CLASS
        - ETAG
        - IS_MULTIPART_UPLOADED
        - ENCRYPTION_STATUS
        - OBJECT_LOCK_RETAIN_UNTIL_DATE
        - OBJECT_LOCK_MODE
        - OBJECT_LOCK_LEGAL_HOLD_STATUS
        - CHECKSUM_ALGORITHM
        - OBJECT_ACCESS_CONTROL_LIST
        - OBJECT_OWNER
      ```

- API {#api}

  To get information about an export configuration, use the [getInventoryConfiguration](../../api-ref/Bucket/getInventoryConfiguration.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService.GetInventoryConfiguration](../../api-ref/grpc/Bucket/getInventoryConfiguration.md) gRPC API call.

{% endlist %}

## Deleting an export configuration {#delete-inventory}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for deleting an export configuration:

      ```bash
      yc storage bucket delete-inventory-configuration --help
      ```

  1. [Get a list](#list-inventory) of export configurations for the bucket and copy the configuration `id` field value.

  1. Delete the export configuration:

      ```bash
      yc storage bucket delete-inventory-configuration <bucket_name> --id <export_ID>
      ```

- API {#api}

  To delete an export configuration, use the [deleteInventoryConfiguration](../../api-ref/Bucket/deleteInventoryConfiguration.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService.DeleteInventoryConfiguration](../../api-ref/grpc/Bucket/deleteInventoryConfiguration.md) gRPC API call.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/s3-inventory.md)
* [{#T}](../objects/download.md)
* [{#T}](./enable-logging.md)
