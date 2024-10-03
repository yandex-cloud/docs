---
title: How to encrypt objects in a {{ objstorage-full-name }} bucket
description: Follow this guide to encrypt objects in a bucket.
---

# Bucket encryption


In {{ objstorage-short-name }}, you can encrypt objects in a bucket using [{{ kms-short-name }} keys](../../../kms/concepts/key.md):
* [Add encryption to the bucket](#add) to encrypt all new objects with the specified key.
* Specify an encryption key when [uploading an object via the API](../../s3/api-ref/object/upload.md).

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../../kms/concepts/envelope.md). Deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


## Adding encryption to a bucket {#add}

{% list tabs group=instructions %}

- Management console {#console}

   To add a {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket for which you want to configure encryption.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select an existing key or create a new one:

      {% include [storage-create-kms](../../_includes_service/storage-create-kms.md) %}

   1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }} {#tf}

   {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   To get started, [obtain an IAM token](../../../iam/operations/iam-token/create-for-sa.md#via-cli) for your service account and save it to a file.

   1. In the configuration file, describe the parameters of the resources you want to create:


      ```
      provider "yandex" {
        cloud_id                 = "<cloud_ID>"
        folder_id                = "<folder_ID>"
        zone                     = "{{ region-id }}-a"
        service_account_key_file = "key.json"
        }

      resource "yandex_iam_service_account" "sa" {
        name = "<service_account_name>"
      }

      // Assigning a role to a service account
      resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
        folder_id = "<folder_ID>"
        role      = "storage.admin"
        member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
      }

      // Creating a static access key
      resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
        service_account_id = yandex_iam_service_account.sa.id
        description        = "static access key for object storage"
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = "<key_name>"
        description       = "<key_description>"
        default_algorithm = "AES_128"
        rotation_period   = "8760h" // 1 year
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = "<bucket_name>"
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        server_side_encryption_configuration {
          rule {
            apply_server_side_encryption_by_default {
              kms_master_key_id = yandex_kms_symmetric_key.key-a.id
              sse_algorithm     = "aws:kms"
            }
          }
        }
      }
      ```



      Where:

      * `service_account_key_file`: Path to file with your service account's IAM token (or the file contents).
      * `default_algorithm`: Encryption algorithm to be used with a new [key version](../../../kms/concepts/version.md). A new version, generated at the next key rotation. Default value: `AES_128`.
      * `rotation_period`: [Rotation period](../../../kms/concepts/version.md#rotate-key). To disable automatic rotation, omit this parameter.
      * `apply_server_side_encryption_by_default`: Default encryption settings on the server side:
         * `kms_master_key_id`: ID of the KMS master key used for encryption.
         * `sse_algorithm`: Encryption algorithm used on the server side. The only supported value is `aws:kms`.

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

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

{% endlist %}

## Removing bucket encryption {#del}

{% list tabs group=instructions %}

- Management console {#console}

   To remove encryption, delete the {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket for which you want to remove encryption.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select **{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }} {#tf}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}


   {% include [terraform-install](../../../_includes/terraform-install.md) %}


   To disable encryption for a bucket created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the `server_side_encryption_configuration` section from the bucket description.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        bucket     = "my-bucket"
        access_key = "123JE02jKxusn********"
        secret_key = "ExamP1eSecReTKeykdo********"
        server_side_encryption_configuration { // Delete this section to disable encryption
          rule {
            apply_server_side_encryption_by_default {
              kms_master_key_id = "abjbeb2bgg4l********"
              sse_algorithm     = "aws:kms"
            }
          }
        }
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

      ```bash
      Success! The configuration is valid.
      ```

   1. Run this command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can check the changes in the [management console]({{ link-console-main }}).

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
