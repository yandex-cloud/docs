---
title: "How to download an object from a {{ objstorage-full-name }} bucket"
description: "In this tutorial, you will learn how to download an object from {{ objstorage-full-name }}."
---

# Downloading an object


{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Select the bucket you need.
   1. Select the object to download.
   1. In the top-right corner, click ![image](../../../_assets/console-icons/ellipsis.svg) and select ![image](../../../_assets/console-icons/arrow-down-to-line.svg) **{{ ui-key.yacloud.storage.file.button_download }}**.

- AWS CLI

   If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

   To download a single object, run this command:

   ```bash
   aws s3 cp \
     --endpoint-url=https://{{ s3-storage-host }} \
     s3://<bucket_name>/<object_key> \
     <local_path>
   ```

   Where:

   * `--endpoint-url`: {{ objstorage-name }} endpoint.
   * `<bucket_name>`: Name of the bucket to download the object from.
   * `<object_key>`: [Key](../../concepts/object.md#key) of the object to download.
   * `<local_path>`: Path to the directory to save the downloaded object to, e.g., `~/downloads/`.

   To download all bucket objects, run this command:

   ```bash
   aws s3 cp \
     --endpoint-url=https://{{ s3-storage-host }} \
     --recursive \
     s3://<bucket_name> \
     <local_path>
   ```

   Where:

   * `--endpoint-url`: {{ objstorage-name }} endpoint.
   * `--recursive`: Command to download all objects from the specified bucket to a local directory.
   * `<bucket_name>`: Name of the bucket to download the object from.
   * `<local_path>`: Path to the directory to save the downloaded objects to, e.g., `~/downloads/`.

   The `aws s3 cp` command is high-level, its functionality is limited. For more information, see the [AWS CLI reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html).

   You can download bucket objects selectively using the `aws s3api` command and a JMESPath query template. To download objects using a query template, run this command:

   * **Bash**:

      ```bash
      aws s3api list-objects \
          --endpoint-url https://{{ s3-storage-host }} \
          --bucket <bucket_name> \
          --query '<query_in_JMESPath_format>' \
          --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key {} <local_path>{}
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `--bucket`: Name of the bucket to download objects from.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.
      * `<local_path>`: Path to the directory to save the downloaded objects to, e.g., `~/downloads/`.

      Here is an example of a command that downloads all objects whose filenames start with `date-20231002` from the `sample-bucket` to the `~/downloads/` local directory:

      ```bash
      aws s3api list-objects \
        --endpoint-url https://{{ s3-storage-host }} \
        --bucket sample-bucket \
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' \
        --output text | xargs -I {} aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key {} ~/downloads/{}
      ```

   * **PowerShell**

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket <bucket_name> `
        --query '<query_in_JMESPath_format>' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket <bucket_name> --key $x <local_path>$x}
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `--bucket`: Name of the bucket to download objects from.
      * `--query`: Query in [JMESPath](https://jmespath.org/) format.
      * `<local_path>`: Path to the directory to save the downloaded objects to, e.g., `d:\downloads\`.

      Here is an example of a command that downloads all objects whose filenames start with `date-20231002` from the `sample-bucket` to the `d:\downloads\` local directory:

      ```powershell
      Foreach($x in (aws s3api list-objects `
        --endpoint-url https://{{ s3-storage-host }} `
        --bucket sample-bucket `
        --query 'Contents[?starts_with(Key, `date-20231002`) == `true`].[Key]' `
        --output text)) `
        {aws s3api get-object --endpoint-url https://{{ s3-storage-host }} --bucket sample-bucket --key $x d:\downloads\$x}
      ```

- API

   To download an object, use the [get](../../s3/api-ref/object/get.md) S3 API method.

{% endlist %}
