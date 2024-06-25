The metric name is written in the `name` label.

All {{ kms-name }} metrics share the `kms` label.

Service metrics:

| Metric name<br>Type, unit | Description |
| --- | --- |
| `asymmetricEncryptionKey.asymmetric_encryption_crypto_operations_rate`<br>`RATE`, operations/s | Rate of cryptographic operations using asymmetric encryption keys. Special `key` label: ID of the asymmetric [encryption key pair](../../../kms/concepts/asymmetric-encryption-key.md). |
| `asymmetricSignatureKey.asymmetric_signature_crypto_operations_rate`<br>`RATE`, operations/s | Rate of cryptographic operations using a digital signature. Special `key` label: ID of the asymmetric [signature key pair](../../../kms/concepts/asymmetric-signature-key.md). |
| `key.active_versions_count`<br>`DGAUGE`, number | Number of active versions of the symmetric encryption key. Special `key` label: ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `key.crypto_operations_rate`<br>`RATE`, operations/s | Rate of cryptographic operations using symmetric encryption keys. Special `key` label: ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `key_asymmetric_encryption_crypto_operations_rate_created`<br>`DGAUGE`, operations | Number of cryptographic operations using asymmetric encryption keys. Special `key` label: ID of the asymmetric [encryption key pair](../../../kms/concepts/asymmetric-encryption-key.md). |
| `key_asymmetric_signature_crypto_operations_rate_created`<br>`DGAUGE`, operations | Number of cryptographic operations using a digital signature. Special `key` label: ID of the asymmetric [signature key pair](../../../kms/concepts/asymmetric-signature-key.md). |
| `key_crypto_operations_rate_created`<br>`DGAUGE`, operations | Total number of cryptographic operations using symmetric encryption keys, asymmetric encryption key pairs, and digital signatures. Special `key` label: Key ID. |