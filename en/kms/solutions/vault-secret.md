# Auto Unseal in Hashicorp Vault

A build of [Hashicorp Vault](https://www.vaultproject.io/) with {{ kms-name }} support can be found in [{{ marketplace-name }}]{% if lang=="ru" %}(https://cloud.yandex.ru/marketplace/products/f2eokige6vtlf94uvgs2){% endif %}{% if lang=="en" %}(https://cloud.yandex.com/en/marketplace/products/yc/vault-yckms){% endif %}. The build will enable you to use {{ kms-name }} as a trusted service for encrypting secrets. This is implemented through the [Auto Unseal](https://www.vaultproject.io/docs/concepts/seal#auto-unseal) feature.

## Before you start { #before-you-begin }

1. Choose one of the authentication methods. You can authenticate via:

    {% list tabs %}

    - The service account linked to your VM

        Authentication is performed using the IAM token that is automatically extracted from the VM's metadata. For more information, see [{#T}](../../compute/operations/vm-connect/auth-inside-vm.md).

        {% note tip %}

        This option is the most preferred for security reasons. When configuring settings using the service account linked to the VM, you don't need to specify your credentials.

        {% endnote %}

    - Any service account

        An authorized key is used for authentication. For more information about how to use authorized keys, see [{#T}](../../iam/operations/iam-token/create-for-sa.md#via-cli).

    - Yandex account

        An [OAuth token](../../iam/concepts/authorization/oauth-token.md) is used for authentication.

    {% endlist %}

1. [Create](../operations/key.md#create) a separate KMS key for Vault (recommended).

1. [Grant access](../../iam/operations/roles/grant.md) to the key only to the user or service account that will be used to authenticate Vault requests in {{ kms-short-name }}. When interacting with {{ kms-short-name }}, Vault only performs encryption and decryption operations, so the `kms.keys.encrypterDecrypter` role is sufficient.

## Setting up Auto Unseal {#setup}

To set up the Auto Unseal feature, make the following changes to the Vault configuration file:

   1. In the [seal](https://www.vaultproject.io/docs/configuration/seal#seal-stanza) section, specify `"yandexcloudkms"`.
   1. Add the `kms_key_id` parameter with the KMS encryption key ID.
   1. If you use an arbitrary service account or your Yandex ID for authentication, enter the appropriate credentials:
      * In the `service_account_key_file` parameter, specify the path to the file with the service account's authorized key.
      * In the `oauth_token` parameter, specify the OAuth token of the Yandex ID.

{% note warning %}

If Vault is already initialized, you should change the configuration during [seal migration](https://www.vaultproject.io/docs/concepts/seal#seal-migration).

{% endnote %}

You can use environment variables instead of the configuration file to set parameter values:

   * The `YANDEXCLOUD_KMS_KEY_ID` variable corresponds to the `kms_key_id` configuration file parameter.
   * The `YANDEXCLOUD_SERVICE_ACCOUNT_KEY_FILE` variable to the `service_account_key_file` parameter.
   * The `YANDEXCLOUD_OAUTH_TOKEN` variable to the `oauth_token` parameter.

   The environment variable values take precedence over the values from the configuration file.

## Sample configurations {#examples}

#### Authentication via the service account linked to your VM {#example-1}

```json
...
seal "yandexcloudkms" {
  kms_key_id = "<key ID>"
}
...
```

#### Authentication via any service account {#example-2}

```json
...
seal "yandexcloudkms" {
  kms_key_id = "<key ID>"
  service_account_key_file = "<path to the JSON file with the authorized key>"
}
...
```

#### Authentication via Yandex ID {#example-3}

```json
...
seal "yandexcloudkms" {
  kms_key_id = "<key ID>"
  oauth_token = "<user's OAuth token>"  
}
...
```

## Key rotation {#rotation}

When the master key is encrypted with a KMS key, Vault additionally saves the version it was encrypted with.

When decrypting the master key (at Vault restart), the saved version is compared with the main version of the {{ kms-short-name }} key and, if they differ, Vault re-encrypts it using the main version.

This way you can rotate the Vault master key through [key rotation in {{ kms-short-name }}](../concepts/version.md#rotate-key). Rotating the key in KMS will automatically rotate the master key when Vault is restarted next time.

## See also {#see-also}

* [Hashicorp Vault](https://www.vaultproject.io/)
* [Seal/Unseal in Vault](https://www.vaultproject.io/docs/concepts/seal)
* [Seal configuration in Vault](https://www.vaultproject.io/docs/configuration/seal)

