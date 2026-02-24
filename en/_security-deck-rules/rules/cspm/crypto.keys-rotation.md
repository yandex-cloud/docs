### Key rotation is enabled for KMS keys {#keys-rotation}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.keys-rotation ||
|#

#### Description

{% note tip "**Automatic verification**" %}

This control automatically checks for key rotation settings on KMS keys.

{% endnote %}

To improve the security of your infrastructure, we recommend that you categorize your encryption keys into two groups:

* Keys for services that process critical data but do not store it, such as Message Queue or Cloud Functions.

* Keys for services storing critical data, e.g., Managed Services for Databases.

For the first group, we recommend that you set up automatic key rotation with a rotation period longer than the data processing period in these services. When the rotation period expires, the old key versions must be deleted. In the case of automatic rotation and the deletion of old key versions, previously processed data cannot be restored and decrypted.

For data storage services, we recommend that you either manually rotate keys or use automatic key rotation, depending on your internal procedures for processing critical data.

A secure value for AES-GCM mode is encryption using 4294967296 (= 2^32^) blocks. Having reached this number of encrypted blocks, you need to create a new DEK version. For more information about the AES-GCM operating mode, see the [NIST materials](https://nvlpubs.nist.gov/nistpubs/Legacy/SP/nistspecialpublication800-38d.pdf).

{% note alert "**Note**" %}

Destroying any version of a key means destroying all data encrypted with it. You can protect a key against deletion by setting the deletionProtection parameter. However, it does not protect against deleting individual versions.

{% endnote %}

For more information about key rotation, see the [KMS documentation, Key version](https://yandex.cloud/en/docs/kms/concepts/version).

#### Guides and solutions

* [Set the key rotation period](https://yandex.cloud/en/docs/kms/concepts/version)
