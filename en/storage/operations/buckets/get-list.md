---
title: Getting a list of buckets in {{ objstorage-full-name }}
description: Follow this guide to get a list of buckets in {{ objstorage-name }}.
---

# Getting a list of buckets

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder.
  1. [Navigate to](../../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  
  The page that opens will display the complete list of [buckets](../../concepts/bucket.md).

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View the description of the CLI command for getting a list of [buckets](../../concepts/bucket.md):

     ```bash
     yc storage bucket --help
     ```

  1. {% include [bucket-list-cli](../../../_includes/storage/bucket-list-cli.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. To get the list of [buckets](../../concepts/bucket.md), run this command:

      ```bash
      aws s3api list-buckets \
        --endpoint-url=https://{{ s3-storage-host }}
      ```

      Where `--endpoint-url` is the {{ objstorage-name }} endpoint.

      Result:

      ```json
      {
          "Buckets": [
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:38.836000+00:00"
              },
              {
                  "Name": "storage-********",
                  "CreationDate": "2026-04-30T09:48:45.365000+00:00"
              }
          ],
          "Owner": {
              "DisplayName": "",
              "ID": ""
          },
          "Prefix": null
      }
      ```

- API {#api}

  To get a list of [buckets](../../concepts/bucket.md), use the [list](../../api-ref/Bucket/list.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/List](../../api-ref/grpc/Bucket/list.md) gRPC API call or the [listBuckets](../../s3/api-ref/bucket/list.md) S3 API method.

{% endlist %}
