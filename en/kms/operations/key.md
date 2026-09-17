# Key management

You can use {{ kms-name }} to create, rotate, and delete symmetric encryption keys.

## Creating a key {#create}

To create a new key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}** and set the following key attributes:

     * Custom name and optional description.
     * [Encryption algorithm](../concepts/key.md#parameters), e.g., `AES-256`.
     * [Rotation](../concepts/index.md#rotation) period (how often to change key versions).
     * Optionally, enable deletion protection.

  1. Click **{{ ui-key.yacloud.common.create }}**.

  When you create a key, its first version is created automatically. Click the key in the list to open the page with its attributes.

- CLI {#cli}

  Run this command:

  ```bash
  yc kms symmetric-key create \
    --name example-key \
    --default-algorithm aes-256 \
    --rotation-period 24h \
    --deletion-protection
  ```

  Where:

  * `--name`: Key name.
  * `--default-algorithm`: [Encryption algorithm](../concepts/key.md#parameters), such as `aes-128`, `aes-192`, `aes-256`, `aes-256-hsm`, or `gost-r-3412-2015-k`.
  * `--rotation-period`: Key rotation period. To create a key without automatic rotation, do not specify `--rotation-period`.
  * `--deletion-protection`: Key deletion protection. To create a key without deletion protection, do not specify `--deletion-protection`.

  When you create a key, its first version is created automatically. It is specified in the `primary_version` field.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  {% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

- API {#api}

  Use the [create](../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../kms/api-ref/grpc/SymmetricKey/create.md) gRPC API call.

{% endlist %}

## Updating a key {#update}

After creating a key, you can change any of its attributes. If you change the encryption algorithm, the new algorithm will be used starting with the next key version. To create a new version right away and make it the default one, [rotate the key](#rotate).

To update a key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. In the key row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Change the key attributes and click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Run this command:

  ```bash
  yc kms symmetric-key update \
    --name example-key \
    --new-name example-key-2 \
    --default-algorithm aes-128 \
    --rotation-period 48h \
    --deletion-protection
  ```

  Where:

  * `--name`: Key name. If there are several keys with the same name within the folder, use the key ID.
  * `--new-name`: New key name.
  * `--default-algorithm`: [Encryption algorithm](../concepts/key.md#parameters), such as `aes-128`, `aes-192`, `aes-256`, `aes-256-hsm`, or `gost-r-3412-2015-k`.
  * `--rotation-period`: Key rotation period. To disable automatic rotation for the updated key, do not specify `--rotation-period`.
  * `--deletion-protection`: Key deletion protection. To disable deletion protection, specify the `--no-deletion-protection` parameter.

- {{ TF }} {#tf}

  To update a key:
  1. Open the {{ TF }} configuration file and change the properties of the `yandex_kms_symmetric_key` resource as needed.

     Here is an example of the configuration file structure:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name                = "example-symmetric-key"
       description         = "description for key"
       default_algorithm   = "AES_128"
       rotation_period     = "8760h"
       deletion_protection = true
     }
     ...
     ```

     For more on the properties of the `yandex_kms_symmetric_key` resource, see [this provider guide]({{ tf-provider-resources-link }}/kms_symmetric_key).
  1. Validate your configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is valid, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

     You can check the key update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc kms symmetric-key get <key_name>
     ```

- API {#api}

  Use the [update](../../kms/api-ref/SymmetricKey/update.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Update](../../kms/api-ref/grpc/SymmetricKey/update.md) gRPC API call.

{% endlist %}

## Activating or deactivating a key {#active-inactive}

After creating a key, you can change its current [status](../concepts/key.md#parameters).

{% note info %}

Key deactivation (changing the key status from `Active` to `Inactive`) is an [eventually consistent](../concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

{% endnote %}

To change a key status:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. To deactivate a key, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![toggle-off](../../_assets/console-icons/toggle-off.svg) **{{ ui-key.yacloud.kms.symmetric-keys.button_action-deactivate }}** next to the relevant `Active` key.
  1. To activate a key, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![toggle-on](../../_assets/console-icons/toggle-on.svg) **{{ ui-key.yacloud.kms.symmetric-keys.button_action-activate }}** next to the relevant `Inactive` key.

- CLI {#cli}

  Run this command:

  ```bash
  yc kms symmetric-key update \
    --name example-key \
    --status active
  ```

  Where:

  * `--name`: Key name. If there are several keys with the same name within the folder, use the key ID in the `--id` parameter.
  * `--status`: New key status. It can be either `active` or `inactive`.

- {{ TF }} {#tf}

  1. Open the {{ TF }} configuration file and add the `status` parameter set to `ACTIVE` or `INACTIVE` to the `yandex_kms_symmetric_key` resource description.

     Here is an example of the configuration file structure:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name                = "example-symmetric-key"
       description         = "description for key"
       ...
       status              = "INACTIVE"
     }
     ...
     ```

     For more on the properties of the `yandex_kms_symmetric_key` resource, see [this provider guide]({{ tf-provider-resources-link }}/kms_symmetric_key).

  1. Validate your configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is valid, you will get this message:

     ```text
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm the changes.

  You can check the key status update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc kms symmetric-key get <key_name>
     ```

- API {#api}

  Use the [update](../../kms/api-ref/SymmetricKey/update.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Update](../../kms/api-ref/grpc/SymmetricKey/update.md) gRPC API call.

{% endlist %}

## Rotating a key {#rotate}

When a key is rotated, a new version is generated and immediately set as the default version. You can setup automatic key rotation on a regular schedule, but you can also rotate the key manually at any time.

{% include [rotation-delay](../../_includes/kms/rotation-delay.md) %}

To rotate a key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. In the key row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![arrow-rotate-right](../../_assets/console-icons/arrow-rotate-right.svg) **{{ ui-key.yacloud.kms.symmetric-keys.button_action-rotate }}**.
  1. Confirm the rotation (make sure that changing the default version will not affect your work).

- CLI {#cli}

  Run the following command, specifying the key ID or name:

  ```bash
  yc kms symmetric-key rotate example-key
  ```

- API {#api}

  Use the [rotate](../../kms/api-ref/SymmetricKey/rotate.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Rotate](../../kms/api-ref/grpc/SymmetricKey/rotate.md) gRPC API call.

{% endlist %}

## Deleting a key {#delete}

Deleting a key also deletes all its versions. You cannot delete a key right away. When a key is marked for deletion, its versions remain in the `Scheduled For Destruction` status for three days. The key versions remain [billable](../pricing.md) during this period. Within these three days, you can contact support to restore the key along with its versions.

{% note alert %}

Three days after you request the deletion of a key, the key and all its versions are permanently deleted. If you still have any data encrypted with this key, you will not be able to decrypt it.

{% endnote %}

If key deletion protection is enabled, [disable](#update) it first.

To delete a key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder.
  1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/key.svg) **{{ ui-key.yacloud.kms.switch_symmetric-keys }}**.
  1. In the key row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![trash-bin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud.common.delete }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- CLI {#cli}

  Run the following command, specifying the key ID or name:

  ```bash
  yc kms symmetric-key delete example-key
  ```

- {{ TF }} {#tf}

  To delete a key created with {{ TF }}:
  1. Open the {{ TF }} configuration file and delete the section with the key description.

     Here is an example of a key description in the {{ TF }} configuration:

     ```hcl
     ...
     resource "yandex_kms_symmetric_key" "key-a" {
       name              = "example-symmetric-key"
       description       = "description for key"
       default_algorithm = "AES_128"
       rotation_period   = "8760h"
     }
     ...
     ```

  1. In the command line, go to the directory with the {{ TF }} configuration file.
  1. Check the configuration using this command:

     ```bash
     terraform validate
     ```

     If the configuration is valid, you will get this message:

     ```bash
     Success! The configuration is valid.
     ```

  1. Run this command:

     ```bash
     terraform plan
     ```

     You will see a list of resources and their properties. No changes will be made at this step. {{ TF }} will show any errors detected in the configuration.
  1. Apply the configuration changes:

     ```bash
     terraform apply
     ```

  1. Type `yes` and press **Enter** to confirm changes.

     You can check the update using the [management console]({{ link-console-main }}) or this [CLI](../../cli/quickstart.md) command:

     ```bash
     yc kms symmetric-key list
     ```

- API {#api}

  Use the [delete](../../kms/api-ref/SymmetricKey/delete.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Delete](../../kms/api-ref/grpc/SymmetricKey/delete.md) gRPC API call.

{% endlist %}

{% note info %}

Deleting a key is an [eventually consistent](../concepts/consistency.md) operation. Changes resulting from such operations take effect with a delay of up to three hours.

{% endnote %}

#### Useful links {#see-also}

[Managing {{ kms-name }} keys with {{ TF }}](../../kms/tutorials/terraform-key.md)
