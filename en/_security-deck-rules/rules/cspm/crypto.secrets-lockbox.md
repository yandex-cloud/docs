### The organization uses Yandex Lockbox for secure secret storage {#secrets-lockbox}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | low | crypto.secrets-lockbox ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for the use of Yandex Lockbox for secret storage.

{% endnote %}

Critical data and access secrets (authentication tokens, API keys, and encryption keys, etc.) should not be used in plain text in code, cloud object names and descriptions, VM metadata, etc. Use secret storage services instead, e.g., Lockbox.

Lockbox securely stores secrets in an encrypted form only. Encryption is performed using KMS. For secret access control, use service roles.

{% note alert "**Note**" %}

When working in Terraform, we recommend using a script to [fill in](https://terraform-provider.yandexcloud.net/Resources/lockbox_secret_version) the contents of a secret. This ensures that its contents do not remain in the `.tfstate` file.

{% endnote %}

#### Guides and solutions

* You can learn how to use the service in the Lockbox documentation: <https://yandex.cloud/en/docs/lockbox>
