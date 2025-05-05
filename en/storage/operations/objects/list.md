---
title: Getting a list of bucket objects in {{ objstorage-full-name }}
description: Follow this guide to get a list of bucket object in {{ objstorage-name }}.
---

# Get a list of bucket objects

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**. You will see a list of objects and folders.

      To view the list of objects in the folder, click it.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get a list of bucket objects:

      ```bash
      yc storage s3api list-objects --help
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
      yc storage s3api list-objects \
        --bucket <bucket_name> \
        --prefix <object_key_prefix>
      ```

      Where:

      * `--bucket`: Bucket name.
      * `--prefix`: [Folder](../../concepts/object.md#folder) within the bucket. This is an optional parameter.

      Result:

      ```text
      contents:
        - key: my-folder/
          last_modified: "2025-04-05T09:21:30.870Z"
          etag: '"d41d8cd98f00b204e9800998********"'
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        - key: my-folder/clouds.jpg
          last_modified: "2025-04-05T09:22:00.542Z"
          etag: '"e48cfc54e831ee0b334a00f9********"'
          size: "455747"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
        - key: my-folder/nice_text.txt
          last_modified: "2025-04-05T09:21:40.023Z"
          etag: '"379e8ff6a0f89b09534753e3********"'
          size: "64154"
          owner:
            id: aje9k8luj4qf********
            display_name: aje9k8luj4qf********
          storage_class: STANDARD
      name: first-bucket
      prefix: my-folder/
      max_keys: "1000"
      key_count: "3"
      request_id: dc073b86********
      ```

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. To get a list of objects in a bucket, run the following command:

      ```bash
      aws s3api list-objects \
        --endpoint-url=https://{{ s3-storage-host }} \
        --bucket <bucket_name> \
        --prefix <object_key_prefix>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `--bucket`: Bucket name.
      * `--prefix`: [Folder](../../concepts/object.md#folder) within the bucket. This is an optional parameter.

      Result:

      ```json
      {
          "Contents": [
              {
                  "Key": "my-folder/",
                  "LastModified": "2025-04-05T09:21:30.870000+00:00",
                  "ETag": "\"d41d8cd98f00b204e9800998********\"",
                  "Size": 0,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
              {
                  "Key": "my-folder/clouds.jpg",
                  "LastModified": "2025-04-05T09:22:00.542000+00:00",
                  "ETag": "\"e48cfc54e831ee0b334a00f9********\"",
                  "Size": 455747,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
              {
                  "Key": "my-folder/nice_text.txt",
                  "LastModified": "2025-04-05T09:21:40.023000+00:00",
                  "ETag": "\"379e8ff6a0f89b09534753e3********\"",
                  "Size": 64154,
                  "StorageClass": "STANDARD",
                  "Owner": {
                      "DisplayName": "aje9k8luj4qf********",
                      "ID": "aje9k8luj4qf********"
                  }
              },
          ],
          "RequestCharged": null
      }
      ```

- API {#api}

  To get a list of objects in the bucket, use the [listObjects](../../s3/api-ref/bucket/listobjects.md) S3 API method.

{% endlist %}