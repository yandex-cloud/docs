### At-rest encryption with a KMS key is enabled in Yandex Object Storage {#object-storage-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | data.object-storage-encryption ||
|#

#### Description

To protect critical data in Yandex Object Storage, we recommend using bucket server-side encryption with Yandex Key Management Service keys. This encryption method protects against accidental or intentional publication of the bucket content on the web. For more information, see [Encryption in the Object Storage ](https://yandex.cloud/en/docs/storage/concepts/encryption) documentation.

#### Instructions and solutions

**Guides and solutions to use:**

It is recommended to enable data [encryption](https://yandex.cloud/ru/docs/tutorials/security/server-side-encryption) for buckets with critical data.
