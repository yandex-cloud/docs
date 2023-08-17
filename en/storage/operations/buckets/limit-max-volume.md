# Limiting the maximum size of a bucket

{{ objstorage-name }} allows you to limit the maximum size of a bucket.

For example, if you provide the users of your service with the ability to upload objects to {{ objstorage-name }}, then, by limiting the maximum volume, you can better control user actions and avoid unnecessary costs.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. Click the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab.
   1. Set the value of the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field.

      {% include [storage-no-max-limit](../../_includes_service/storage-no-max-limit.md) %}
   1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to update a bucket:

      ```bash
      yc storage bucket update --help
      ```

   1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+----------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       | MAX SIZE | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+----------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 0        | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+----------+-----------------------+---------------------+
      ```

   1. Using the `NAME` column, save the name of the bucket to limit the size for.
   1. Limit the maximum size of the bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --max-size <maximum_bucket_size>
      ```

      Where:
      * `--name`: Name of the bucket to limit the size for.
      * `--max_size`: Maximum bucket size (bytes). `0`: No limit.

      Result:

      ```yaml
      name: first-bucket
      older_id: b1gmit33ngp6********
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "26843545600"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To limit the maximum bucket size:

   1. Open the {{ TF }} configuration file and add the `max_size` parameter to the bucket description:

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        access_key = "<static_key_ID>"
        secret_key = "<private_key>"
        bucket     = "tf-test-bucket"
        max_size   = 1048576
      }
      ...
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `max_size`: Maximum bucket size (bytes).

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#bucket-max-size).

   1. Check the configuration using this command:

      ```
      terraform validate
      ```

      If the configuration is correct, you will get this message:

      ```
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify changes to your bucket in the [management console]({{ link-console-main }}).

- API

   To limit the maximum bucket size, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call.

{% endlist %}
