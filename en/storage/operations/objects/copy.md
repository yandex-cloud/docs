---
title: Copying objects in {{ objstorage-full-name }}
description: Follow this guide to copy an object from a bucket in {{ objstorage-name }}.
---

# Copying objects

{{ objstorage-name }} supports server-side copy.

If [bucket](../../concepts/bucket.md) [encryption](../../concepts/encryption.md) is disabled, [objects](../../concepts/object.md) will be copied to server-side buckets. The host running the copy command and {{ objstorage-name }} only exchange object [keys](../../concepts/object.md#key). No fee is charged for the copying traffic in this case because the traffic is internal for the object storage. However, you will be [billed](../../pricing.md#prices-operations) for copy requests.

If bucket objects are encrypted, they will first be copied to the host running the command and then uploaded to the target bucket.

Large objects uploaded using [multipart uploads](../../concepts/multipart.md) are stored in parts within the bucket. To copy these objects, you need to use the [copyPart](../../s3/api-ref/multipart/copypart.md) call for each part. Therefore, multipart objects cost more to copy than regular ones.

You can copy either the [entire bucket contents](#copy-from-bucket-to-bucket) or an [individual bucket object](#copy-single-object).


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


## Copying a single object {#copy-single-object}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to copy an object:

      ```bash
      yc storage s3api copy-object --help
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
      yc storage s3api copy-object \
        --copy-source <source_bucket>/<object_key> \
        --bucket <target_bucket> \
        --key <object_key>
      ```

      Where:

      * `--copy-source`: Name of the source bucket and object [key](../../concepts/object.md#key) you need to copy.
      * `--bucket`: Name of the bucket to copy the object to.
      * `--key`: Key to use for storing the object in the bucket.

      Result:

      ```bash
      copy_object_result:
        etag: '"d41d8cd98f00b204e9800998********"'
        last_modified_at: "2024-10-08T14:21:41.628Z"
      request_id: 61523025********
      copy_source_version_id: "null"
      ```

      Alternative command:

      ```bash
      yc storage s3 cp \
        s3://<source_bucket>/<original_object_key> \
        s3://<target_bucket>/<copy_object_key>
      ```

      Result:

      ```text
      copy: s3://my-bucket/object.txt to s3://new-bucket/object-copy.txt
      ```

      {% include [s3-cp-config](../../../_includes/storage/s3-cp-config.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp s3://<source_bucket>/<object_key> s3://<target_bucket>/<object_key>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 cp`: Copy object command.

      Result:

      ```text
      copy: s3://<source_bucket>/<object_key> to s3://<target_bucket>/<object_key>
      ```

      For more information about the `aws s3 cp` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/publish.html) in the AWS CLI command reference.

{% endlist %}

## Copying all bucket objects to a different bucket {#copy-from-bucket-to-bucket}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to copy objects:

      ```bash
      yc storage s3 cp --help
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
      yc storage s3 cp \
        s3://<source_bucket>/ \
        s3://<target_bucket>/ \
        --recursive
      ```

      Where `--recursive` is the parameter for copying all objects.

      Result:

      ```text
      copy: s3://my-bucket/object-1.txt to s3://new-bucket/object-1-copy.txt
      copy: s3://my-bucket/object-2.txt to s3://new-bucket/object-2-copy.txt
      ...
      copy: s3://my-bucket/object-n.txt to s3://new-bucket/object-n-copy.txt
      ```

      {% include [s3-cp-config](../../../_includes/storage/s3-cp-config.md) %}

- AWS CLI {#cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp --recursive s3:<source_bucket>/ s3:<target_bucket>/
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 cp`: Command to copy objects.
      * `--recursive`: Parameter for copying all objects from the source bucket.

      For more information about the `aws s3 cp` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/publish.html) in the AWS CLI command reference.

  All objects from the source bucket will now appear in the target bucket.

  {% note info %}

  You can copy objects between buckets, both within the same cloud and across different clouds. To do this, make sure your [service account](../../../iam/concepts/users/service-accounts.md) has write permissions for both buckets.

  {% endnote %}


{% endlist %}

