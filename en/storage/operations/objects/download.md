---
title: Downloading an object in {{ objstorage-full-name }}
description: Follow this guide to download an object from a bucket in {{ objstorage-name }}.
---

# Downloading an object


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% note info %}

To download an object group with a specified prefix (a [directory](../../concepts/object.md#folder) with objects) or all objects from a bucket, use the AWS CLI or file browsers compatible with the Amazon S3 API, e.g., [CyberDuck](../../tools/cyberduck.md) and [WinSCP](../../tools/winscp.md).

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to download an object from.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and find the object in the list.
  1. Next to the object you want to download, click ![image](../../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.storage.file.button_download }}** or open the object and click ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.storage.file.button_download }}** in the top panel.

  {% note info %}

  You can also use [CyberDuck](../../tools/cyberduck.md) or [WinSCP](../../tools/winscp.md) tools to download or upload objects using the GUI.

  {% endnote %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for downloading an object from a bucket:

      ```bash
      yc storage s3api get-object --help
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
      yc storage s3api get-object \
        --bucket <bucket_name> \
        --key <object_key> \
        <download_path>
      ```

      Where:

      * `--bucket`: Name of your bucket.
      * `--key`: Object [key](../../concepts/object.md#key).
      * `<download_path>`: Local download path.

      Result:

      ```bash
      etag: '"d41d8cd98f00b204e9800998********"'
      request_id: af194b83********
      accept_ranges: bytes
      content_type: application/octet-stream
      last_modified_at: "2024-10-08T12:36:36Z"
      server_side_encryption: aws:kms
      sse_kms_key_id: abj497vtg3h0********
      ```

- AWS CLI {#aws-cli}

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
  * `<bucket_name>`: Name of the bucket you want to download the objects from.
  * `<object_key>`: [Key](../../concepts/object.md#key) of the object you want to download.
  * `<local_path>`: Path to the directory to save the downloaded object to. For example, `~/downloads/`.

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
  * `<local_path>`: Path to the directory to save the downloaded objects to, e.g., `~/downloads/`.

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
  * `<local_path>`: Path to the directory to save the downloaded objects to. For example, `~/downloads/`.

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
      * `<local_path>`: Path to the directory to save the downloaded objects to. For example, `~/downloads/`.

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
      * `<local_path>`: Path to the directory to save the downloaded objects to. For example, `d:\downloads\`.

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
