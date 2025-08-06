---
title: Renaming and moving an object in {{ objstorage-full-name }}
description: Follow this guide to rename or move an object in an {{ objstorage-name }} bucket.
---

# Renaming and moving objects


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


In addition to the {{ yandex-cloud }} CLI and AWS CLI, you can also use other [supported tools](../../../storage/tools/index.md), such as a file browser, to rename and move objects.

## Renaming {#rename}

{% note info %}

You can rename [objects](../../concepts/object.md) in the [bucket](../../concepts/bucket.md). You cannot rename the bucket itself. However, you can [create](../buckets/create.md) a new bucket and [copy](./copy.md#copy-from-bucket-to-bucket) all objects from the source bucket into it.

{% endnote %}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for renaming an object in a bucket:

      ```bash
      yc storage s3 mv --help
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
      yc storage s3 mv \
        s3://<bucket_name>/<object_key> \
        s3://<bucket_name>/<new_object_key>
      ```

      Result:

      ```text
      move: s3://my-bucket/object.txt to s3://my-bucket/renamed-object.txt
      ```

  For more information about the `yc storage s3 mv` command, see the [documentation](../../cli-ref/s3/mv.md).

- AWS CLI {#aws-cli}

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

### Updating the prefix for an object group {#rename-prefix} 

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To update the [prefix](../../concepts/object.md#key) for an object group, run this command:

  ```bash
  yc storage s3 mv --recursive \
    s3://<bucket_name>/<prefix>/ \
    s3://<bucket_name>/<new_prefix>/
  ```

  Result:

  ```text
  move: s3://my-bucket/my-prefix/ to s3://my-bucket/renamed-prefix/
  ```

  For more information about the `yc storage s3 mv` command, see the [documentation](../../cli-ref/s3/mv.md).

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv --recursive s3://<bucket_name>/<prefix>/ s3://<bucket_name>/<new_prefix>/
      ```

      Where: 

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 mv`: Command to rename or move an object. To rename an object, in the first part of the command, provide the bucket name and the current [prefix](../../concepts/object.md#key) of the object group you want to rename, and in the second part, the bucket name and the new prefix for the object group.
      * `--recursive`: Parameter for updating the prefix for an object group.

      Result:

      ```text
      move: s3://<bucket_name>/<prefix>/ to s3://<bucket_name>/<new_prefix>/
      ```  

  For more information about the `aws s3 mv` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/sns/publish.html) in the AWS CLI command reference.

{% endlist %}

## Moving {#move}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Read the description of the CLI command for moving an object:

      ```bash
      yc storage s3 mv --help
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
      yc storage s3 mv \
        s3://<source_bucket_name>/<object_key> \
        s3://<target_bucket_name>/<object_key>
      ```

      Result:

      ```text
      move: s3://my-bucket/object.txt to s3://new-bucket/object.txt
      ```

- AWS CLI {#aws-cli}

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

### Moving an object from one directory to another {#move-object-folder}

In {{ objstorage-name }}, [directories](../../concepts/object.md#folder) are simulated using key prefixes. To move an object from one directory to another, [rename](#rename) its key prefix, e.g.:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  ```bash
  yc storage s3 mv \
    s3://<bucket_name>/<prefix>/<object_name> \
    s3://<bucket_name>/<new_prefix>/<object_name>
  ```

  Result:

  ```text
  move: s3://my-bucket/my-prefix/object.txt to s3://my-bucket/renamed-prefix/object.txt
  ```

- AWS CLI {#aws-cli}

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }}/ \
    s3 mv s3://<bucket_name>/<prefix>/<object_name> s3://<bucket_name>/<new_prefix>/<object_name>
  ```

  Result:

  ```text
  move: s3://my-bucket/my-prefix/object.txt to s3://my-bucket/renamed-prefix/object.txt
  ```  

{% endlist %}

### Moving a directory with objects {#move-folder}

In {{ objstorage-name }}, [directories](../../concepts/object.md#folder) are simulated using key prefixes. To move a directory with objects, [update](#rename-prefix) the prefix for an object group. 

### Moving objects from one bucket to another {#move-all}

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}
  
  Run this command:

  ```bash
  yc storage s3 mv --recursive \
    s3://<source_bucket_name>/ \
    s3://<target_bucket_name>/
  ```

  Result:

  ```text
  move: s3://my-bucket/object1.txt to s3://new-bucket/object1.txt
  move: s3://my-bucket/object2.txt to s3://new-bucket/object2.txt
  ```

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 mv --recursive s3://<source_bucket_name> s3://<target_bucket_name>
      ```

      Where:
      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 mv`: Command to rename or move an object. To move all objects, in the first part of the command, provide the source bucket name, and in the second part, the target bucket name.
      * `--recursive`: Parameter for moving all objects from one bucket to another.

      Result:

      ```text
      move: s3://<source_bucket_name>/<object_1_key> to s3://<target_bucket_name>/<object_1_key>
      move: s3://<source_bucket_name>/<object_2_key> to s3://<target_bucket_name>/<object_2_key>
      ```

  For more information about the `aws s3 mv` command, see [this article](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/mv.html) in the AWS CLI command reference.

{% endlist %}
