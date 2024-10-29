---
title: How to configure public access to bucket operations in {{ objstorage-full-name }}
description: Follow this guide to configure public access to a bucket in {{ objstorage-name }}.
---

# Configuring public access to a bucket

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

By default, [buckets](../../concepts/bucket.md) are created with restricted [access](../../concepts/bucket.md#bucket-access). You can enable public access:

{% include [storage-public-operations](../../_includes_service/storage-public-operations.md) %}

## Enabling public access {#open-public-access}

{% include [public-access-warning](../../../_includes/storage/security/public-access-warning.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ objstorage-name }}**.
  1. Click the bucket name.
  1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab.
  1. Enable public access for the operation types you need.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to update a bucket:

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

   1. Using the `NAME` column, save the name of the bucket to which you need to enable public access.
   1. Allow public access to operations with the bucket:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Where:
      * `--name`: Name of the bucket to which you need to enable public access.
      * `--public-read`: Flag to enable public access to read bucket objects.
      * `--public-list`: Flag to enable public access to view the list of bucket objects.
      * `--public-config-read`: Flag to enable public access to read the bucket configuration.

      `name`: Required parameter. Other parameters are optional. By default, no public access to buckets is allowed.

      Result:

      ```text
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

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To enable public access to bucket operations:

  1. Open the {{ TF }} configuration file and add the `anonymous_access_flags` section to the bucket description fragment.

     ```hcl
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "<static_key_ID>"
       secret_key = "<secret_key>"
       bucket     = "<bucket_name>"

       anonymous_access_flags {
         read        = true
         list        = true
         config_read = true
       }
     }
     ```

     Where:
     * `access_key`: [Static access key](../../../iam/concepts/authorization/access-key.md) ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Name of the bucket to which you need to enable public access.
     * `anonymous_access_flags`: Public access parameters:
       * `read`: Public access to read bucket objects.
       * `list`: Public access to the list of bucket objects.
       * `config_read`: Public access to read bucket configuration.

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
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

  To allow public access to operations with your bucket, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

{% note info %}

If your bucket has access policies, you will also need to [configure](./policy.md#apply-policy) them for public access to work properly.

{% endnote %}

## Disabling public access {#close-public-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. Select **{{ objstorage-name }}**.
  1. Click the bucket name.
  1. Go to the **{{ ui-key.yacloud.storage.bucket.switch_settings }}** tab.
  1. Enable restricted access for the operation types you need.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to update a bucket:

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

   1. Using the `NAME` column, save the name of the bucket to which you want to disable public access.
   1. Disable public access to operations with the bucket.

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --public-read=false \
        --public-list=false \
        --public-config-read=false
      ```

      Where:
      * `--name`: Name of the bucket to which you need to disable public access.
      * `--public-read`: Flag to manage public access to read bucket objects. To disable public access, set it to `false`.
      * `--public-list`: Flag to manage public access to view the list of bucket objects. To disable public access, set it to `false`.
      * `--public-config-read`: Flag to manage public access to read bucket configuration. To disable public access, set it to `false`.

      `name`: Required parameter. Other parameters are optional. By default, no public access to buckets is allowed.

      Result:

      ```text
      name: first-bucket
      folder_id: b1gmit33ngp6********
      anonymous_access_flags:
        read: false
        list: false
        config_read: false
      default_storage_class: STANDARD
      versioning: VERSIONING_DISABLED
      max_size: "53687091200"
      acl: {}
      created_at: "2022-12-16T13:58:18.933814Z"
      ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}


  {% include [terraform-install](../../../_includes/terraform-install.md) %}


  To disable public access to bucket operations:

  1. Open the {{ TF }} configuration file and add the `anonymous_access_flags` section to the bucket description fragment.

     ```hcl
     resource "yandex_storage_bucket" "log_bucket" {
       access_key = "<static_key_ID>"
       secret_key = "<secret_key>"
       bucket     = "<bucket_name>"

       anonymous_access_flags {
         read        = false
         list        = false
         config_read = false
       }
     }
     ```

     Where:
     * `access_key`: [Static access key](../../../iam/concepts/authorization/access-key.md) ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Name of the bucket to which you need to disable public access.
     * `anonymous_access_flags`: Public access parameters:
       * `read`: Public access to read bucket objects.
       * `list`: Public access to the list of bucket objects.
       * `config_read`: Public access to read bucket configuration.

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the folder where you created the configuration file.
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

  To disable public access to operations with your bucket, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

When disabling public access to the bucket, make sure the `All users` [public group](../../../iam/concepts/access-control/public-group.md) has no `viewer`, `storage.viewer`, or higher [role](../../security/index.md#service-roles) assigned for the folder or bucket. Otherwise, the bucket will still be publicly accessible.