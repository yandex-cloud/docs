# Bucket encryption

In {{ objstorage-short-name }}, you can encrypt objects in a bucket using {% if audience != "internal" %}[{{ kms-short-name }} keys](../../../kms/concepts/key.md){% else %}{{ kms-short-name }} keys{% endif %}:
* [Add encryption to the bucket](#add) to encrypt all new objects with the specified key.
* Specify an encryption key when [uploading an object via the API](../../s3/api-ref/object/upload.md).

{% note alert %}

Data in {{ objstorage-short-name }} is encrypted using {% if audience != "internal" %}[envelope encryption](../../../kms/concepts/envelope.md){% else %}envelope encryption{% endif %}. Deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}

{% if audience != "internal" %}

To decrypt objects, the user must have both the {{ objstorage-name }} role and the `kms.keys.encrypterDecrypter` role that allows reading the encryption key (see the [role description](../../../kms/security/index.md#service)).

{% endif %}

## Adding encryption to a bucket {#add}

{% list tabs %}

- Management console

   To add a {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket you wish to configure encryption for.
   1. In the left panel, select **Encryption**.
   1. In the **{{ kms-short-name }} key** field, select an existing key or create a new one:

      {% include [storage-create-kms](../../_includes_service/storage-create-kms.md) %}

   1. Click **Save**.

- {{ TF }}

   If you do not have {{ TF }} yet, {% if audience != "internal" %}[install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}install it and configure the {{ yandex-cloud }} provider{% endif %}.

   Before you start, {% if audience != "internal" %}[get an IAM token](../../../iam/operations/iam-token/create-for-sa.md#via-cli){% else %}get an IAM token{% endif %} for your service account and save it to a file.

   1. In the configuration file, describe the parameters of resources that you want to create:

      {% if product == "yandex-cloud" %}

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

      {% endif %}

      {% if product == "cloud-il" %}

      ```
      provider "yandex" {
        cloud_id                 = "<cloud ID>"
        folder_id                = "<folder ID>"
        zone                     = "{{ region-id }}-a"
        service_account_key_file = "key.json"
        endpoint                 = "{{ api-host }}:443"
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

      {% endif %}

      Where:

      * `service_account_key_file`: Path to file with your service account's IAM token (or the file contents).
      * `default_algorithm`: Encryption algorithm to be used with a new {% if audience != "internal" %}[key version](../../../kms/concepts/version.md){% else %}key version{% endif %}. A new version, generated at the next key rotation. Default value: `AES_128`.
      * `rotation_period`: {% if audience != "internal" %}[Rotation period](../../../kms/concepts/version.md#rotate-key){% else %}Rotation period{% endif %}. To disable automatic rotation, omit this parameter.
      * `apply_server_side_encryption_by_default`: Default encryption settings on the server side:
         * `kms_master_key_id`: ID of the KMS master key used for encryption.
         * `sse_algorithm`: Encryption algorithm used on the server side. The only supported value is `aws:kms`.

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:
         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

      ```
      terraform apply
      ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

## Removing bucket encryption {#del}

{% list tabs %}

- Management console

   To remove encryption, delete the {{ kms-short-name }} key:
   1. In the [management console]({{ link-console-main }}), select the bucket you wish to remove encryption for.
   1. In the left panel, select **Encryption**.
   1. In the **{{ kms-short-name }} key** field, select **Not selected**.
   1. Click **Save**.

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   {% if audience != "internal" %}

   For more information about the {{ TF }}, [see the documentation](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% endif %}

   To disable encryption for a bucket created using {{ TF }}:

   1. Open the {{ TF }} configuration file and delete the `server_side_encryption_configuration` section from the bucket description.

      {% cut "Example bucket description in a {{ TF }} configuration" %}

      ```hcl
      ...
      resource "yandex_storage_bucket" "test" {
        bucket     = "my-bucket"
        access_key = "YCAJE02jKxfGKszo6LxcZnUzc"
        secret_key = "YCNhwa3qK4kuGPk_Kthc39rn8jHtMLFyp7TvjCtZ"
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

   1. Check the configuration using the command:

      ```bash
      terraform validate
      ```

      If the configuration is correct, the following message is returned:

      ```bash
      Success! The configuration is valid.
      ```

   1. Run the command:

      ```bash
      terraform plan
      ```

      The terminal will display a list of resources with parameters. No changes are made at this step. If the configuration contain errors, {{ TF }} will point them out.

   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the changes in the [management console]({{ link-console-main }}).

{% endlist %}


#### See also {#see-also}

* [{#T}](../../concepts/encryption.md)
