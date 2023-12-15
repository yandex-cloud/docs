# Auto Unseal in Hashicorp Vault

A [Hashicorp Vault](https://www.vaultproject.io/) build with [{{ kms-full-name }}](../index.yaml) support is available as a [VM image](/marketplace/products/yc/vault-yckms) in {{ marketplace-name }} and a Docker image. It differs from the [primary](https://hub.docker.com/_/vault) version by a single binary Vault file that supports {{ kms-name }}.

This build will enable you to use {{ kms-name }} as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal) mechanism.

In this guide, you will learn how to set up the Auto Unseal feature to work with {{ kms-short-name }}.

To set up Auto Unseal:
1. [Prepare your cloud](#before-you-begin).
1. [Set up Auto Unseal](#setup).

## Prepare your cloud {#before-you-begin}

1. Download the most recent Docker image using the command below:

   ```bash
   docker pull cr.yandex/yc/vault
   ```

1. Select one of the methods to authenticate Vault requests to {{ kms-short-name }}. You can authenticate via:

   {% list tabs %}

   - The service account linked to your VM

      Authentication is performed using an [{{ iam-full-name }} token](../../iam/concepts/authorization/iam-token.md) that is automatically extracted from the [VM metadata](../../compute/concepts/vm-metadata.md). For more information, see [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).

      {% note tip %}

      This option is the most preferable for security reasons. When configuring settings using the [service account](../../iam/concepts/users/service-accounts.md) linked to the VM, you do not need to specify your credentials.

      {% endnote %}

   - Any service account

      An authorized key is used for authentication. For more information about how to use authorized keys, see [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).

   - Yandex or federated account

      Authentication is done using an [OAuth token](../../iam/concepts/authorization/oauth-token.md) or [{{ iam-name }} token](../../iam/concepts/authorization/iam-token.md).

      {% note tip %}

      This option is the least preferable for security reasons. We recommend that you only use it for testing.

      {% endnote %}

   {% endlist %}

1. [Create](../operations/key.md#create) a separate [{{ kms-name}} key](../concepts/key.md) for Vault (recommended).
1. [Grant access](../../iam/operations/roles/grant.md) to the key only to the user or service account that will be used to authenticate Vault requests to {{ kms-short-name }}. When working with {{ kms-short-name }}, Vault only performs [encryption and decryption](../concepts/symmetric-encryption.md) operations, so the `kms.keys.encrypterDecrypter` [role](../../iam/concepts/access-control/roles.md) is sufficient.


### Required paid resources {#paid-resources}

The infrastructure support costs include:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static [public IP](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
* Fee for the number of active {{ kms-short-name }} key versions and completed cryptographic operations (see [{{ vpc-full-name }} pricing](../../kms/pricing.md)).


## Set up Auto Unseal {#setup}

To set up the Auto Unseal feature, make the following changes to the Vault [configuration file](https://www.vaultproject.io/docs/configuration):

{% note warning %}

If Vault has already been initialized, you have to run a [migration procedure](https://www.vaultproject.io/docs/concepts/seal#seal-migration) to modify the configuration.

{% endnote %}

1. Under [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza), enter `"yandexcloudkms"` as the value.
1. Add the `kms_key_id` parameter with the {{ kms-short-name }} encryption key ID.
1. Authenticate using one the following methods:

   {% list tabs %}

   - The service account linked to your VM

      Link a service account to a VM by following the [instructions](../../compute/operations/vm-connect/auth-inside-vm.md).

   - Any service account

      In the `service_account_key_file` parameter, specify the path to the file with the service account's authorized key.

   - Yandex or federated account

      If you are using a Yandex account, specify the OAuth token in the `oauth_token` parameter. For a federated account, specify the IAM token.

   {% endlist %}

1. Change the configuration when performing [migration](https://www.vaultproject.io/docs/concepts/seal#seal-migration) based on the Vault version in use.

{% note info %}

You can use environment variables instead of the configuration file to set parameter values:
* The `YANDEXCLOUD_KMS_KEY_ID` variable corresponds to the `kms_key_id` configuration file parameter.
* The `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` variable to the `service_account_key_file` parameter.
* The `YANDEXCLOUD_OAUTH_TOKEN` variable to the `oauth_token` parameter.

The environment variable values prevail over those from the configuration file.

{% endnote %}

## Sample configurations {#examples}

{% list tabs %}

- The service account linked to your VM

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id = "<KMS_key_ID>"
   }
   ...
   ```

- Any service account with a key

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id               = "<KMS_key_ID>"
     service_account_key_file = "<path_to_JSON_file>"
   }
   ...
   ```

   Where `service_account_key_file` is the path to the JSON file with the authorized key.

- Yandex or federated account

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id  = "<KMS_key_ID>"
     oauth_token = "<user_token>"
   }
   ...
   ```

{% endlist %}

## Key rotation {#rotation}

When the Vault master key is encrypted with a {{ kms-short-name }} key, Vault also saves the [key version](../concepts/version.md) it was encrypted with.

When the Vault master key is decrypted (at Vault restart), the saved version of the {{ kms-short-name }} key used to encrypt the Vault master key is compared with the primary version of the {{ kms-short-name }} key. If the key versions are different, the Vault master key is re-encrypted with the new primary version of the {{ kms-short-name }} key.

This way you can rotate the Vault master key through [key rotation in {{ kms-short-name }}](../concepts/version.md#rotate-key). Rotating the key in {{ kms-name }} will automatically rotate the master key when Vault is restarted the next time.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the VM](../../compute/operations/vm-control/vm-delete.md) if you created one to run Vault.
* [Delete the static public IP](../../vpc/operations/address-delete.md) if you reserved one.
* [Delete the {{ kms-name }} key](../../kms/operations/key.md#delete).

## See also {#see-also}
* [Hashicorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal in Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal configuration in Vault](https://www.vaultproject.io/docs/configuration/seal)
