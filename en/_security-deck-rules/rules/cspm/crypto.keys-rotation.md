### Key rotation is enabled for KMS keys {#keys-rotation}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | high | crypto.keys-rotation ||
|#

#### Description

Each version of a KMS key contains its own key material — the actual cryptographic key used to encrypt and decrypt data. Rotation creates a new version with new key material, while previous versions stay available for decrypting data that was already encrypted with them.

Rotation is what makes data retention practical: when the time comes to remove old data, you can also retire the key version that protected it, and the key material disappears together with the data.

[Key Management Service](https://yandex.cloud/en/docs/kms/) supports both manual and automatic rotation. The right setup depends on whether the key protects data the service stores or only data the service processes:

* **Keys for services that only process data** (Message Queue, Cloud Functions). Set up automatic rotation with a period longer than how long any one piece of data is processed. Old key versions can be retired once the data they protected has been processed.
* **Keys for services that store data** (managed databases, encrypted disks, Object Storage). Use manual rotation or automatic rotation that aligns with your data retention rules. Old versions should be retired only after all data encrypted with them has been re-encrypted or deleted — destroying a version that still has data behind it makes that data unrecoverable.

{% note alert "**Note**" %}

`deletionProtection` on a key protects the key as a whole, but does not protect individual versions of it. Plan version retention separately.

{% endnote %}

**Risks if the rule is not followed:** Without key rotation, a compromised key version remains in use indefinitely — any data encrypted with it stays at risk for as long as the key is not rotated, and there is no mechanism to limit the exposure window after a potential key compromise.

#### Instructions and solutions

For each KMS key in production:

1. Decide whether the key encrypts data the service stores or only processes — that determines when old versions can be retired.
2. [Set the rotation period](https://yandex.cloud/en/docs/kms/concepts/version) on the key, aligning it with your data retention rules.
3. For keys that protect stored data, document a procedure for safely retiring old versions — only after all data encrypted with them has been re-encrypted or deleted.

Read more about key versions in the [KMS documentation](https://yandex.cloud/en/docs/kms/concepts/version).
