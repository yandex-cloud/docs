---
title: Restoring an object version in a {{ objstorage-full-name }} versioned bucket
description: Follow this guide to restore an object version in an {{ objstorage-name }} versioned bucket.
---

# Restoring an object's version in a bucket with versioning

You can only restore object versions if a bucket supports [versioning](../../concepts/versioning.md). You can only restore the versions that were uploaded with versioning enabled. To enable versioning, follow [this guide](../buckets/versioning.md).

{% list tabs group=instructions %}

- Management console {#console}

  {% note warning %}

  The timeout for restoring an object's version through the management console is 25 seconds. It may expire before large versions are restored. If restoring fails, use other tools, such as the AWS CLI or API.

  {% endnote %}

  To restore an object's version:

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you need.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and find the object in the list.
  1. Select the object whose version you want to restore and click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_version-history }}**.
  1. In the list of versions, click ![image](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.storage.file.action_file-restore }}** in the row with the version you need. This restores the selected version and displays it as the current one.

- AWS CLI {#cli}

  To restore an object's version using the [AWS CLI](../../tools/aws-cli.md):

  1. Get the ID of the desired object version:

     ```bash
     aws s3api list-object-versions \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <bucket_name> \
       --prefix <object_key_prefix>
     ```

     As a result, a list of versions of all objects whose keys start with the specified prefix is displayed. Version IDs are available in the `VersionId` parameters.

     {% cut "Example of getting a list of versions" %}

     Command:

     ```bash
     aws s3api list-object-versions \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket my-bucket \
       --prefix index.html
     ```

     Result:

     ```text
     {
        "Versions": [
            {
                "LastModified": "2015-11-10T00:20:11.000Z",
                "VersionId": "Rb_l2T8UHDkFEwCgJjhlgPOZ********",
                "ETag": "\"0622528de826c0df5db1258a********\"",
                "StorageClass": "STANDARD",
                "Key": "index.html",
                "Owner": {
                    "DisplayName": "my-username",
                    "ID": "7009a8971cd660687538875e7c86c5b672fe116bd438f46db45460dd********"
                },
                "IsLatest": true,
                "Size": 38
            },
            {
                "LastModified": "2015-11-09T23:26:41.000Z",
                "VersionId": "rasWWGpgk9E4s0LyTJgusGeR********",
                "ETag": "\"06225825b8028de826c0df5d********\"",
                "StorageClass": "STANDARD",
                "Key": "index.html",
                "Owner": {
                    "DisplayName": "my-username",
                    "ID": "7009a8971cd660687538875e7c86c5b672fe116bd438f46db45460dd********"
                },
                "IsLatest": false,
                "Size": 38
            }
        ]
     }
     ```

     {% endcut %}

     To only select a single object:

     1. Install and initialize [jq](https://stedolan.github.io/jq/download/).
     1. Filter the results:

        ```bash
        aws s3api list-object-versions \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <bucket_name> \
          --prefix <object_key_prefix> \
        | jq '.Versions | map(select(.Key == "<object_key>"))'
        ```

     For more information about the command, see its description in the [Amazon documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/list-object-versions.html).

  1. Copy the object version to the same bucket with the same key to make it the current object version:

     ```bash
     aws s3api copy-object \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <bucket_name> \
       --copy-source <bucket_name>/<object_key>?versionId=<version_ID> \
       --key <object_key>
     ```

     Where:

     * `--bucket`: Bucket name.
     * `--copy-source`: Source object for copying stating the version ID.
     * `--key`: Target object key. To restore the object version, make sure the keys of the target and source objects are the same.

     Result:

     ```text
     {
       "CopyObjectResult": {
         "LastModified": "<date_and_time_of_last_object_modification>",
         "ETag": "\"589c8b79c230a6ecd5a7e1d040a9a030\""
       },
       "VersionId": "<ID_of_restored_object_version>"
     }
     ```

     For more information about the command, see its description in the [Amazon documentation](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/copy-object.html).

- API {#api}

  To restore an object's version:

  1. Get the ID of the required object version using the [listObjectVersions](../../s3/api-ref/bucket/listObjectVersions.md) S3 API method.
  1. Copy the object version to the same bucket with the same key using the [copy](../../s3/api-ref/object/copy.md) S3 API method.

{% endlist %}
