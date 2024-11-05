---
title: Renaming and moving an object in {{ objstorage-full-name }}
description: Follow this guide to rename or move an object in an {{ objstorage-name }} bucket.
---

# Renaming and moving objects


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
      * `s3 mv`: Command to rename or move an object. To rename an object, specify the bucket name and the current [key](../../concepts/object.md#key) of the object to be renamed in the first part of the command and the bucket name and a new object key in the second part.

      Result:

      ```text
      move: s3://<bucket_name>/<object_key> to s3://<bucket_name>/<new_object_key>
      ```

  For more information about the `aws s3 mv` command, see the [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

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
      * `s3 mv`: Command to rename or move an object. To move an object, specify the name of the source bucket and the [key](../../concepts/object.md#key) of the object to be moved in the first part of the command and the name of the target bucket and the object key in the second part.

      Result:

      ```text
      move: s3://<source_bucket_name>/<object_key> to s3://<target_bucket_name>/<object_key>
      ```

  For more information about the `aws s3 mv` command, see the [AWS CLI Command Reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html).

{% endlist %}

In {{ objstorage-name }}, [folders](../../concepts/object.md#folder) are simulated using key prefixes. To move an object from one folder to another, [rename](#rename) its key prefix.

You can also rename and move objects using [supported tools](../../../storage/tools/index.md) like a file browser.
