### Deletion protection is enabled for KMS keys {#keys-deletion-protection}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.keys-deletion-protection ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for deletion protection settings on KMS keys.

{% endnote %}

Deleting a KMS key always means destroying data. Therefore, make sure to protect the keys against accidental deletion. KMS has the necessary feature.

#### Guides and solutions

* Enable deletion protection: <https://yandex.cloud/en/docs/kms/operations/key#update>