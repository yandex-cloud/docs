---
title: Configuring public access to a bucket in {{ objstorage-full-name }}
description: Follow this guide to configure public access to a bucket in {{ objstorage-name }}.
---

# Configuring public access to a bucket

{% include [full-overview](../../../_includes/storage/security/full-overview.md) %}

By default, [bucket](../../concepts/bucket.md) [access](../../concepts/bucket.md#bucket-access) is restricted. You can enable public access:

{% include [storage-public-operations](../../_includes_service/storage-public-operations.md) %}

## Enabling public access {#open-public-access}

{% include [public-access-warning](../../../_includes/storage/security/public-access-warning.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure public access for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
  1. Enable public access for the operation types you need.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a bucket:

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

   1. Save the name (from the `NAME` column) of the bucket to which you want to enable public access.
   1. Enable public access to bucket operations:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --public-read \
        --public-list \
        --public-config-read
      ```

      Where:
      * `--name`: Name of the bucket to which you need to enable public access.
      * `--public-read`: Flag to enable public read access to bucket objects.
      * `--public-list`: Flag to enable public view access to the list of bucket objects.
      * `--public-config-read`: Flag to enable public read access to the bucket configuration.

      `name`: This is a required parameter. Other parameters are optional. By default, public access to the bucket is disabled.

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


  To open public access to bucket operations:

  1. Open the {{ TF }} configuration file and add the `anonymous_access_flags` section to the bucket description.

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

        {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

     * `secret_key`: Secret access key value.
     * `bucket`: Name of the bucket to which you need to enable public access.
     * `anonymous_access_flags`: Public access parameters:
       * `read`: Public read access to bucket objects.
       * `list`: Public access to the list of bucket objects.
       * `config_read`: Public read access to the bucket configuration.

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To open public access to bucket operations, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

{% note info %}

You will not be able to open public access if a restrictive [access policy](../../operations/buckets/policy.md) is configured for the bucket. 

{% endnote %}

## Disabling public access {#close-public-access}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to disable public access for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_general-settings }}** tab.
  1. Enable restricted access for the operation types you need.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for updating a bucket:

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

   1. Save the name (from the `NAME` column) of the bucket to which you want to disable public access.
   1. Disable public access to bucket operations:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --public-read=false \
        --public-list=false \
        --public-config-read=false
      ```

      Where:
      * `--name`: Name of the bucket to which you need to disable public access.
      * `--public-read`: Flag to manage public read access to bucket objects. To disable public access, set it to `false`.
      * `--public-list`: Flag to manage public view access to the list of bucket objects. To disable public access, set it to `false`.
      * `--public-config-read`: Flag to manage public read access to the bucket configuration. To disable public access, set it to `false`.

      `name`: This is a required parameter. Other parameters are optional. By default, public access to the bucket is disabled.

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
       * `read`: Public read access to bucket objects.
       * `list`: Public access to the list of bucket objects.
       * `config_read`: Public read access to the bucket configuration.

     For more information about the `yandex_storage_bucket` resource parameters in {{ TF }}, see [this TF provider article]({{ tf-provider-resources-link }}/storage_bucket#bucket-anonymous-access-flags).

  1. Make sure the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If you described the configuration correctly, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

        This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To disable public access to bucket operations, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

When disabling public access to your bucket, make sure the `All users` [public group](../../../iam/concepts/access-control/public-group.md) has no `viewer`, `storage.viewer`, or higher [role](../../security/index.md#service-roles) assigned for the folder or bucket. Otherwise, the bucket will still be publicly accessible.