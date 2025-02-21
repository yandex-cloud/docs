---
title: Renaming and moving an object in {{ objstorage-full-name }}
description: Follow this guide to rename or move an object in an {{ objstorage-name }} bucket.
---

# Renaming and moving an object


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


## Renaming {#rename}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. To rename an object, run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv s3://<bucket_name>/<object_key> s3://<bucket_name>/<new_object_key>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 mv`: Command to rename or move an object. To rename an object, in the first part of the command, provide the bucket name and the current [key](../../concepts/object.md#key) of the object you want to rename, and in the second part, the bucket name and the new object key.

      Result:

      ```text
      move: s3://<bucket_name>/<object_key> to s3://<bucket_name>/<new_object_key>
      ```

  For more information about the `aws s3 mv` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html) in the AWS CLI command reference.

{% endlist %}

## Moving {#move}

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. To move an object, e.g., from one bucket to another, run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv s3://<source_bucket_name>/<object_key> s3://<target_bucket_name>/<object_key>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 mv`: Command to rename or move an object. To move an object, in the first part of the command, provide the source bucket name and the [key](../../concepts/object.md#key) of the object you want to move, and in the second part, the target bucket name and the object key.

      Result:

      ```text
      move: s3://<source_bucket_name>/<object_key> to s3://<target_bucket_name>/<object_key>
      ```

  For more information about the `aws s3 mv` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html) in the AWS CLI command reference.

{% endlist %}

In {{ objstorage-name }}, [folders](../../concepts/object.md#folder) are simulated using key prefixes. To move an object from one folder to another, [rename](#rename) its key prefix.

You can also use [supported tools](../../../storage/tools/index.md), such as a file browser, to rename and move objects.
