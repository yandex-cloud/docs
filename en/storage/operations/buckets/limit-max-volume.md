# Limiting the maximum size of a bucket

{{ objstorage-name }} lets you limit the maximum size of a bucket.

If, for example, you provide the users of your service the ability to upload objects to {{ objstorage-name }}, then by limiting the maximum volume, you can better control user actions and avoid unnecessary spending.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the desired bucket.
   1. Go to the **Settings** tab.
   1. Set the value of **Max size**.

      {% include [storage-no-max-limit](../../_includes_service/storage-no-max-limit.md) %}
   1. Click **Save**.

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
      | first-bucket     | b1gmit33ngp6cv2mhjmo | 0        | STANDARD              | 2022-12-16 13:58:18 |
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
      older_id: b1gmit33ngp6cv2mhjmo
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "26843545600"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      ```

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% if audience != "internal" %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

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
      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.
      * `max_size`: Maximum bucket size (bytes).

      For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket#bucket-max-size).

   1. Check the configuration using the command:

      ```
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify changes to your bucket in the [management console]({{ link-console-main }}).

{% endlist %}
