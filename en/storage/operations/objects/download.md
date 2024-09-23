---
title: "How to download an object from a {{ objstorage-full-name }} bucket"
description: "In this tutorial, you will learn how to download an object in {{ objstorage-full-name }}."
---

# Downloading an object


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% note info %}

To download an object group with a specified prefix (a [directory](../../concepts/object.md#folder) with objects) or all objects from a bucket, use the AWS CLI or file browsers compatible with the Amazon S3 API, e.g., [CyberDuck](../../tools/cyberduck.md) and [WinSCP](../../tools/winscp.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ objstorage-name }}**.
  1. Select the bucket from which you want to download an object.
  1. Next to the object you want to download, click ![image](../../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.storage.file.button_download }}**.

  {% note info %}

  You can also use [CyberDuck](../../tools/cyberduck.md) or [WinSCP](../../tools/winscp.md) tools to download or upload objects using the GUI.

  {% endnote %}

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  **Downloading a single object**

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    s3://<bucket_name>/<object_key> \
    <local_path>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `<bucket_name>`: Name of the bucket you want to download the object from.
  * `<object_key>`: [Key](../../concepts/object.md#key) of the object you want to download.
  * `<local_path>`: Path to the folder to save the downloaded object to. e.g., `~/downloads/`.

  **Downloading a directory (all objects with a specified prefix)**

  For more information about folders in {{ objstorage-name }}, see [{#T}](../../concepts/object.md#folder).

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    --recursive \
    s3://<bucket_name>/<prefix>/ \
    <local_path>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `--recursive`: Parameter for downloading all objects with the specified prefix.
  * `<bucket_name>`: Name of the bucket you want to download the objects from.
  * `<prefix>`: Prefix (folder) of the objects you want to download, e.g., `test/folder`.
  * `<local_path>`: Path to the folder to save the downloaded objects to, e.g., `~/downloads/`.

  **Downloading all objects from a bucket**

  ```bash
  aws s3 cp \
    --endpoint-url=https://{{ s3-storage-host }} \
    --recursive \
    s3://<bucket_name> \
    <local_path>
  ```

  Where:

  * `--endpoint-url`: {{ objstorage-name }} endpoint.
  * `--recursive`: Parameter for downloading all objects from the bucket to a local folder.
  * `<bucket_name>`: Name of the bucket you want to download the objects from.
  * `<local_path>`: Path to the folder to save the downloaded objects to, e.g., `~/downloads/`.

  `aws s3 cp` is a high-level command with limited functionality. For more information, see the [AWS CLI reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

  You can download bucket objects selectively using the `aws s3api` command and a JMESPath query template. To download objects using a query template, run this command:

  * **Bash**:

      ```bash
      aws s3api list-objects \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <bucket_name> \
          --query '<query>' \
          --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key {} <local_path>{}
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `--bucket`: Name of the bucket you want to download the objects from.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.
      * `<local_path>`: Path to the folder to save the downloaded objects to, e.g., `~/downloads/`.

      Here is an example of a command that downloads all objects whose filenames start with `date-20231002` from the `sample-bucket` bucket to the `~/downloads/` local folder:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {} ~/downloads/{}
      ```

  * **PowerShell**:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <bucket_name> `
        --query '<query>' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key $x <local_path>$x}
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `--bucket`: Name of the bucket you want to download the objects from.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.
      * `<local_path>`: Path to the folder to save the downloaded objects to, e.g., `d:\downloads\`.

      Here is an example of a command that downloads all objects whose filenames start with `date-20231002` from the `sample-bucket` bucket to the `d:\downloads\` local folder:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x d:\downloads\$x}
      ```

- API {#api}

  To download an object, use the [get](../../s3/api-ref/object/get.md) S3 API method.

{% endlist %}

#### See also {#see-also}

* [{#T}](link-for-download.md)
