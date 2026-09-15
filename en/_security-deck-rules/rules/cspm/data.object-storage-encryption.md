### At-rest encryption with a KMS key is enabled in Yandex Object Storage {#object-storage-encryption}

#|
|| **kind** | **severity** | **ID** ||
|| automatic | medium | data.object-storage-encryption ||
|#

#### Description

By default, [Object Storage](https://yandex.cloud/en/docs/storage/) encrypts data at rest with a service-managed key, transparently to the user.

For buckets with sensitive data — personal data, payment data, intellectual property — it is worth using server-side encryption with a key that you control yourself, from [Key Management Service](https://yandex.cloud/en/docs/kms/). With this approach, the bucket cannot decrypt its objects without access to your KMS key, which adds an extra layer of control: revoking access to the KMS key effectively cuts off access to the data, even for cloud users with permissions on the bucket.

**Risks if the rule is not followed:** Without customer-managed KMS encryption, you cannot revoke access to bucket data independently of IAM permissions. If bucket access controls are misconfigured or a privileged account is compromised, the data is accessible in plaintext. Customer-managed encryption adds a second independent access control layer — the KMS key — that can be revoked or audited separately.

#### Instructions and solutions

Enable server-side encryption with your KMS key for buckets with sensitive data:

1. Create a [symmetric KMS key](https://yandex.cloud/en/docs/kms/operations/key) in the same folder as the bucket.
2. Enable [bucket encryption](https://yandex.cloud/en/docs/storage/concepts/encryption) with this key — for new buckets at creation, for existing buckets through bucket settings.
3. Restrict access to the key so that only the workloads that legitimately need to read the bucket have the `kms.keys.encrypterDecrypter` role on it.
4. Document the operational impact: rotating or disabling the key changes who can read the bucket.
