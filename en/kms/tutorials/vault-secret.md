# Auto Unseal in Hashicorp Vault

A [Hashicorp Vault](https://www.vaultproject.io/) build with [{{ kms-name }}](../) support is available as a [VM image](/marketplace/products/yc/vault-yckms) in {{ marketplace-name }} and a Docker image.

The build will enable you to use {{ kms-name }} as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal) mechanism.

This build differs from its [official](https://hub.docker.com/_/vault) version by a single binary Vault file, which includes {{ kms-name }} support in our build.

To download the most recent Docker image, use the command below:

```
docker pull cr.yandex/yc/vault
```

## Before you start { #before-you-begin }

1. Select one of the methods to authenticate Vault requests to {{ kms-short-name }}. You can authenticate via:

   {% list tabs %}

   - The service account linked to your VM

      Authentication is performed using the IAM token that is automatically extracted from the VM's metadata. For more information, see [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).

      {% note tip %}

      This option is the most preferred for security reasons. When configuring settings using the service account linked to the VM, you don't need to specify your credentials.

      {% endnote %}

   - Any service account

      An authorized key is used for authentication. For more information about how to use authorized keys, see [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).

   - Yandex account

      Authentication is done using anr [OAuth token](../../iam/concepts/authorization/oauth-token.md).

   {% endlist %}

1. [Create](../operations/key.md#create) a separate KMS key for Vault (recommended).
1. [Grant access](../../iam/operations/roles/grant.md) to the key only to the user or service account that will be used to authenticate Vault requests to {{ kms-short-name }}. When interacting with {{ kms-short-name }}, Vault only performs encryption and decryption operations, so the `kms.keys.encrypterDecrypter` role is sufficient.

## Setting up Auto Unseal {#setup}

To set up the Auto Unseal feature, make the following changes to the Vault configuration file:

1. Under [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza), enter `"yandexcloudkms"` as the value.
1. Add the `kms_key_id` parameter with the KMS encryption key ID.
1. Authenticate using one the following methods:

   {% list tabs %}

   - The service account linked to your VM

      Bind a service account to a VM by following the [instructions](../../compute/operations/vm-connect/auth-inside-vm.md).

   - Any service account

      In the `service_account_key_file` parameter, specify the path to the file with the service account's authorized key.

   - Yandex account

      In the `oauth_token` parameter, specify the Yandex ID OAuth token.

   {% endlist %}

{% note warning %}

If Vault has already been initialized, you have to do a [migration procedure](https://www.vaultproject.io/docs/concepts/seal#seal-migration) to modify the configuration.

{% endnote %}

You can use environment variables instead of the configuration file to set parameter values:
* The `YANDEXCLOUD_KMS_KEY_ID` variable corresponds to the `kms_key_id` configuration file parameter.
* The `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` variable to the `service_account_key_file` parameter.
* The `YANDEXCLOUD_OAUTH_TOKEN` variable to the `oauth_token` parameter.

The environment variable values take precedence over the values from the configuration file.

## Sample configurations {#examples}

{% list tabs %}

- The service account linked to your VM

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id = "<key ID>"
   }
   ...
   ```

- Any service account

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id = "<key ID>"
     service_account_key_file = "<path to JSON file with authorized key>"
   }
   ...
   ```

- Yandex account

   ```json
   ...
   seal "yandexcloudkms" {
     kms_key_id = "<key ID>"
     oauth_token = "<user OAuth token>"  
   }
   ...
   ```

{% endlist %}

## Key rotation {#rotation}

When the Vault master key is encrypted with a KMS key, Vault also saves the version it was encrypted with.

When the Vault master key is decrypted (in a Vault restart), the saved version of the KMS key used to encrypt the Vault master key is compared with the primary version of the KMS key and, if different, the Vault master key is re-encrypted with the new primary version of the KMS key.

This way you can rotate the Vault master key through [key rotation in {{ kms-short-name }}](../concepts/version.md#rotate-key). Rotating the key in KMS will automatically rotate the master key when Vault is restarted next time.

## See also {#see-also}
* [Hashicorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal in Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal configuration in Vault](https://www.vaultproject.io/docs/configuration/seal)