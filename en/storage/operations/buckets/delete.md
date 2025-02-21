---
title: Deleting a bucket in {{ objstorage-full-name }}
description: Follow this guide to delete a bucket in {{ objstorage-name }}.
---

# Deleting a bucket

{% note warning %}

You can only delete an empty bucket. In the management console, the information about the number of objects in the bucket is updated with a few minutes' delay.

{% endnote %}

To delete a bucket that [stores the logs](../../concepts/server-logs.md) of another bucket, go to the source bucket settings to [disable logging](enable-logging.md#stop-logging) or select a different target bucket for storing logs.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. Select the bucket in question, click ![image](../../../_assets/console-icons/ellipsis.svg), and select ![image](../../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

  {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a bucket:

      ```bash
      yc storage bucket delete --help
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

  1. Save the name (from the `NAME` column) of the bucket you are going to delete.
  1. Delete the bucket:

      ```bash
      yc storage bucket delete --name <bucket_name>
      ```

      Where `--name` is the name of the bucket to delete.

      {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  In the terminal, run the `aws s3api delete-bucket` command:

  ```bash
  aws s3api delete-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --bucket <bucket_name>
  ```

  Where:
  * `--bucket`: Name of the bucket to delete.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

  Alternatively, you can use the `aws s3 rb` command:

  ```bash
  aws --endpoint-url=https://{{ s3-storage-host }} \
    s3 rb s3://<bucket_name>
  ```

  To simultaneously delete multiple buckets, run this command:

  {% include [sa-acl-bucket-list-note.md](../../../_includes/storage/sa-acl-bucket-list-note.md) %}

  * **Bash**:

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://{{ s3-storage-host }} \
      --query '<query>' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://{{ s3-storage-host }} --bucket {}
    ```

    Where `--query` is the query in [JMESPath](https://jmespath.org/) format.

    Here is an example of a command that deletes all buckets whose names start with `samplebucket`:

    ```bash
    aws s3api list-buckets \
      --endpoint-url=https://{{ s3-storage-host }} \
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' \
      --output text | xargs -I {} aws s3api delete-bucket --endpoint-url=https://{{ s3-storage-host }} --bucket {}
    ```

  * **PowerShell**:

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://{{ s3-storage-host }} `
      --query '<query>' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://{{ s3-storage-host }} `
      --bucket $x}
    ```

    Where `--query` is the query in [JMESPath](https://jmespath.org/) format.

    Here is an example of a command that deletes all buckets whose names start with `samplebucket`:

    ```powershell
    Foreach($x in (aws s3api list-buckets `
      --endpoint-url=https://{{ s3-storage-host }} `
      --query 'Buckets[?starts_with(Name, `samplebucket`) == `true`].[Name]' `
      --output text)) `
      {aws s3api delete-bucket `
      --endpoint-url=https://{{ s3-storage-host }} `
      --bucket $x}
    ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  
  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To delete a bucket created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the section with the bucket description.

     {% cut "Example of a bucket description in {{ TF }} configuration" %}

     ```hcl
     ...
     resource "yandex_storage_bucket" "test" {
       access_key = "YCAJEX9Aw2ge********-w-lJ"
       secret_key = "YCONxG7rSdz********_NRy5VbKzKlqZ********"
       bucket     = "<bucket_name>"
     }
     ...
     ```

     {% endcut %}

  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is correct, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     The terminal will display a list of resources with their parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Confirm the changes: type `yes` into the terminal and press **Enter**.

     You can check the update using the [management console]({{ link-console-main }}).

- API {#api}

  To delete a bucket, use the [delete](../../api-ref/Bucket/delete.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Delete](../../api-ref/grpc/Bucket/delete.md) gRPC API call, or the [deleteBucket](../../s3/api-ref/bucket/delete.md) S3 API method.

  {% include [work-with-multiple-buckets](../../../_includes/storage/work-with-multiple-buckets.md) %}

{% endlist %}
