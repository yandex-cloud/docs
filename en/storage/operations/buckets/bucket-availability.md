---
title: "Enabling public access to operations with a {{ objstorage-full-name }} bucket"
description: "Follow this guide to enable public access to operations with a bucket."
---

# Enabling public access for bucket operations

By default, buckets are created with restricted [access](../../concepts/bucket.md#bucket-access). You can use the management console to enable public access:

{% include [storage-public-operations](../../_includes_service/storage-public-operations.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab.
   1. Select the type of access for bucket operations.
   1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

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
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Using the `NAME` column, save the name of the bucket to enable public access to.
   1. Allow public access to operations with the bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Where:
      * `--name`: Name of the bucket to enable public access to.
      * `--public-read`: Flag to enable public read access to bucket objects.
      * `--public-list`: Flag to enable public access to view the list of bucket objects.
      * `--public-config-read`: Flag to enable public read access to the bucket configuration.

      The `name` parameter is required. Other parameters are optional. By default, no public access to buckets is allowed.

      Result:

      ```yaml
      name: first-bucket
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: true
        list: true
        config_read: true
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   To enable public access to bucket operations:

   1. Open the {{ TF }} configuration file and add a section called `anonymous_access_flags` to the bucket description fragment.

      ```hcl
      resource "yandex_storage_bucket" "log_bucket" {
        access_key = "<static_key_ID>"
        secret_key = "<private_key>"
        bucket     = "my-tf-log-bucket"

        anonymous_access_flags {
          read = true
          list = false
        }
      }
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Secret access key value.
      * `read`: Read access to bucket objects.
      * `list`: Access to list of bucket objects.

      For more information about `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   To allow public access to operations with your bucket, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call.

{% endlist %}

{% note info %}

If your bucket has access policies, you will also need to [configure](./policy.md#apply-policy) them for public access to work properly.

{% endnote %}