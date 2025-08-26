---
title: Restoring an object version in a versioned bucket in {{ objstorage-full-name }}
description: Follow this guide to restore an object version in a versioned bucket in {{ objstorage-name }}.
---

# Restoring an object version in a versioned bucket

To restore object versions, the bucket must be [versioned](../../concepts/versioning.md). You can only restore the versions that were uploaded with versioning enabled. To enable versioning, follow [this guide](../buckets/versioning.md).

{% list tabs group=instructions %}

- Management console {#console}

  {% note warning %}

  The timeout for restoring an object version using the management console is 25 seconds. Large versions might not successfully restore within this time.
  
  The management console restores objects via a single request, but it has [limits](../../concepts/limits.md#storage-limits). The object version size cannot exceed 5 GB.
  
  If restoring fails or the object version exceeds this limit, we recommend using other tools, such as the AWS CLI or S3 API.

  {% endnote %}

  To restore an object version:

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket in question.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and find the object in the list.
  1. Select the object whose version you want to restore, click ![image](../../../_assets/console-icons/ellipsis.svg), and select **{{ ui-key.yacloud.storage.file.button_version-history }}**.
  1. In the list of versions, click ![image](../../../_assets/console-icons/arrow-rotate-left.svg) **{{ ui-key.yacloud.storage.file.action_file-restore }}** in the row with the version you need. This will restore the selected version and make it the current one.

- AWS CLI {#cli}

  To restore an object version using the [AWS CLI](../../tools/aws-cli.md):

  1. Get the ID of the object version you need:

     ```bash
     aws s3api list-object-versions \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <bucket_name> \
       --prefix <object_key_prefix>
     ```

     The result will be a list of versions for all objects whose keys start with the specified prefix. Version IDs are available in the `VersionId` parameters.

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

     To select a single object:

     1. Install and initialize [jq](https://stedolan.github.io/jq/download/).
     1. Filter the result:

        ```bash
        aws s3api list-object-versions \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <bucket_name> \
          --prefix <object_key_prefix> \
        | jq '.Versions | map(select(.Key == "<object_key>"))'
        ```

     For more information about the command, see its description in [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/list-object-versions.html) of the AWS CLI command reference.

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
     * `--copy-source`: Source object to copy, specifying the version ID.
     * `--key`: Target object key. To restore the object version, make sure the keys of the target and source objects match.

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

     For more information about the command, see its description in [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/copy-object.html) of the AWS CLI command reference.

- API {#api}

  To restore an object version:

  1. Get the ID of the object version you need using the [listObjectVersions](../../s3/api-ref/bucket/listObjectVersions.md) S3 API method.
  1. Copy the object version to the same bucket with the same key using the [copy](../../s3/api-ref/object/copy.md) S3 API method.

{% endlist %}
