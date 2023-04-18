# Bucket encryption

In {{ objstorage-short-name }}, you can encrypt objects in a bucket using [{{ kms-short-name }} keys](../../../kms/concepts/key.md):
* [Add encryption to the bucket](#add) to encrypt all new objects with the specified key.
* Specify an encryption key when [uploading an object via the API](../../s3/api-ref/object/upload.md).

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using [envelope encryption](../../../kms/concepts/envelope.md). Deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}


To decrypt objects, the user must have both the {{ objstorage-name }} role and the `kms.keys.encrypterDecrypter` role that allows reading the encryption key (see the [role description](../../../kms/security/index.md#service)).


## Adding encryption to a bucket {#add}

{% list tabs %}

- Management console

   To add a {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket for which you want to configure encryption.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select an existing key or create a new one:

      {% include [storage-create-kms](../../_includes_service/storage-create-kms.md) %}

   1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   Before you start, [get an IAM token](../../../iam/operations/iam-token/create-for-sa.md#via-cli) for your service account and save it to a file.

   1. In the configuration file, describe the parameters of the resources you want to create:

      
      ```
      provider "yandex" {
        cloud_id                 = "<cloud ID>"
        folder_id                = "<folder ID>"
        zone                     = "{{ region-id }}-a"
        service_account_key_file = "key.json"
        }


      resource "yandex_kms_symmetric_key" "key-a" {
        name              = "<key name>"
        description       = "<key description>"
        default_algorithm = "AES_128"
        rotation_period   = "8760h" // 1 year
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = "<bucket name>"
        access_key = "<static key ID>"
        secret_key = "<secret key>"
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

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:
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

      Once you are done, all the resources you need will be created in the specified folder. You can check that the resources are there and their settings are correct using the [management console]({{ link-console-main }}).

{% endlist %}

## Removing bucket encryption {#del}

{% list tabs %}

- Management console

   To remove encryption, delete the {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket for which you want to remove encryption.
   1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_encryption }}**.
   1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select **{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   
   For more information about {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).


   To disable encryption for a bucket created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the `server_side_encryption_configuration` section from the bucket description.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        bucket     = "my-bucket"
        access_key = "123JE02jKxusnc23ZnUzc"
        secret_key = "ExamP1eSecReTKeykdokKK38800"
        server_side_encryption_configuration { // Delete this section to disable encryption
          rule {
            apply_server_side_encryption_by_default {
              kms_master_key_id = "abjbeb2bgg4ljno7aqqo"
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

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contains any errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
