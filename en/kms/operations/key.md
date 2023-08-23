# Key management

You can use {{ kms-name }} to create, rotate, and destroy symmetric encryption keys.

## Create a key {#create}

To create a key:

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ kms-name }}**.
   1. Click **Create** and set the key attributes:
      * Any name and optional description.
      * Encryption algorithm, such as AES-256.
      * [Rotation](../concepts/index.md#rotation) period (how often to change key versions).
      * Click **Create**.

   The key is created along with its first version: click the key in the list to open the page with its attributes.

- CLI

   Run the command with the following parameters:
   * `name`: Key name.
   * `default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).
   * `rotation-period`: Key rotation period. To create a key without automatic rotation, do not specify the `rotation-period` parameter.

   ```bash
   yc kms symmetric-key create \
     --name example-key \
     --default-algorithm aes-256 \
     --rotation-period 24h
   ```

   The key is created along with its first version. It is specified in the `primary_version` field.

- API

   Use the [create](../../kms/api-ref/SymmetricKey/create.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Create](../../kms/api-ref/grpc/symmetric_key_service.md#Create) gRPC API call.

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   {% include [terraform-key-create](../../_includes/kms/terraform-key-create.md) %}

{% endlist %}

## Edit a key {#update}

After creating a key, you can change any of its attributes. If you change the encryption algorithm, the new algorithm is used starting with the next key version. To immediately create a new version and make it the default version, rotate the key.

To edit a key:

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ kms-name }}**.
   1. In the row with the key in question, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Update** from the drop-down list.
   1. Change the key attributes and click **Save**.

- CLI

   Run the command with the following parameters:
   * `name`: Key name. If there are multiple keys with the same name in the folder, use the key ID.
   * `new-name`: New key name.
   * `default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).
   * `rotation-period`: Key rotation period. To disable automatic rotation for an updated key, do not specify the `rotation-period` parameter.

   ```bash
   yc kms symmetric-key update \
     --name example-key \
     --new-name example-key-2 \
     --default-algorithm aes-128 \
     --rotation-period 48h
   ```

- API

   Use the [update](../../kms/api-ref/SymmetricKey/update.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Update](../../kms/api-ref/grpc/symmetric_key_service.md#Update) gRPC API call.

- {{ TF }}

   To edit a key:
   1. Open the {{ TF }} configuration file and change the required parameters of the `yandex_kms_symmetric_key` resource.

      Example of the configuration file structure:

      ```hcl
      ...
      resource "yandex_kms_symmetric_key" "key-a" {
        name              = "example-symetric-key"
        description       = "description for key"
        default_algorithm = "AES_128"
        rotation_period   = "8760h"
      }
      ...
      ```

      For more information about the `yandex_kms_symmetric_key` resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/kms_symmetric_key).
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

      The terminal will display a list of resources with parameters. No changes will be made at this step. If the configuration contains any errors, {{ TF }} will point them out.
   1. Apply the configuration changes:

      ```bash
      terraform apply
      ```

   1. Confirm the changes: type `yes` into the terminal and press **Enter**.

      You can verify the change to the key using the [management console]({{ link-console-main }}) or the following [CLI](../../cli/quickstart.md) command:

      ```bash
      yc kms symmetric-key get <key name>
      ```

{% endlist %}

## Rotate a key {#rotate}

When a key is rotated, a new version is generated and immediately set as the default version. You can set up automatic rotation, but you can also rotate a key manually at any time.

To rotate a key:

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ kms-name }}**.
   1. In the row with the key in question, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Rotate** from the drop-down list.
   1. Confirm the rotation (make sure that changing the default version will not affect your work).

- CLI

   Run the command with the key ID or name specified:

   ```bash
   yc kms symmetric-key rotate example-key
   ```

- API

   Use the [rotate](../../kms/api-ref/SymmetricKey/rotate.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Rotate](../../kms/api-ref/grpc/symmetric_key_service.md#Rotate) gRPC API call.

{% endlist %}

## Destroy a key {#delete}

By destroying a key you also destroy all its versions. You cannot delete a key directly: the versions of a key marked for deletion change their status to `Scheduled For Destruction` for 3 days. During this time, your account will continue [to be charged](../pricing.md) for these key versions. Before the 3 days expire, you can request technical support to restore a key and its versions.

{% note alert %}

3 days after the key is requested to be destroyed, the key and its versions are permanently destroyed: if you still have any data encrypted with this key, you cannot decrypt the data.

{% endnote %}

To destroy a key:

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ kms-name }}**.
   1. In the row with the key you need, click ![image](../../_assets/horizontal-ellipsis.svg) and select **Delete** from the drop-down list.
   1. In the window that opens, click **Delete**.

- CLI

   Run the command with the key ID or name specified:

   ```bash
   yc kms symmetric-key delete example-key
   ```

- API

   Use the [delete](../../kms/api-ref/SymmetricKey/delete.md) REST API method for the [SymmetricKey](../../kms/api-ref/SymmetricKey/index.md) resource or the [SymmetricKeyService/Delete](../../kms/api-ref/grpc/symmetric_key_service.md#Delete) gRPC API call.

- {{ TF }}

   To delete a key created with {{ TF }}:
   1. Open the {{ TF }} configuration file and delete the fragment with the key description.

      Example key description in the {{ TF }} configuration:

      ```hcl
      ...
      resource "yandex_kms_symmetric_key" "key-a" {
        name              = "example-symetric-key"
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

      You can verify the changes using the [management console]({{ link-console-main }}) or the [CLI](../../cli/quickstart.md) command below:

      ```bash
      yc kms symmetric-key list
      ```

{% endlist %}

## See also {#see-also}

* [Managing {{ kms-name }} keys with {{ TF }}](../../kms/tutorials/terraform-key.md).