### At-rest encryption with a KMS key is enabled in Yandex Object Storage {#object-storage-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | data.object-storage-encryption ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for encryption settings on Object Storage buckets.

{% endnote %}

To protect critical data in Yandex Object Storage, we recommend using bucket server-side encryption with Yandex Key Management Service keys. This encryption method protects against accidental or intentional publication of the bucket content on the web. For more information, see [Encryption](https://yandex.cloud/en/docs/storage/concepts/encryption) in the Object Storage documentation.

#### Guides and solutions

* It is recommended to enable data encryption for buckets with critical data: <https://yandex.cloud/en/docs/tutorials/security/server-side-encryption>
