# Deleting a bucket

{% note warning %}

You can only delete an empty bucket. In the management console, information about the number of objects in a bucket is updated with a few minutes' delay.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder you want to delete a bucket from.
   1. Select **{{ objstorage-name }}**. This opens a page with a list of buckets.
   1. To delete a single bucket, click ![image](../../../_assets/horizontal-ellipsis.svg) to the left of the bucket name and select **{{ ui-key.yacloud.storage.bucket.button_action-delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.storage.file.popup-confirm_button_delete }}**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to delete a bucket:

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
      | first-bucket     | b1gmit33ngp6cv2mhjmo | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Use the `NAME` column to save the name of the bucket you are going to delete.
   1. Delete the bucket:

      ```bash
      yc storage bucket delete --name <bucket_name>
      ```

      Where `--name` is the name of the bucket to delete.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To delete a bucket created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment describing the bucket.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        access_key = "YCAJEX9Aw2ge1VKjlYXf-w-lJ"
        secret_key = "YCONxG7rSdzVF9UMxLA_NRy5VbKzKlqZMcSJz2N0"
        bucket     = "tf-test-bucket"
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

- API

   To delete a bucket, use the [delete](../../api-ref/Bucket/delete.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Delete](../../api-ref/grpc/bucket_service.md#Delete) gRPC API call, or the [deleteBucket](../../s3/api-ref/bucket/delete.md) S3 API method.

{% endlist %}