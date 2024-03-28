The name of the metric is written in the `name` label.

All {{ kms-name }} metrics share the `kms` label.

Service metrics:

| Metric name<br>Type, units of measurement | Description |
| --- | --- |
| `key.active_versions_count`<br>`DGAUGE`, number | Number of active versions of the symmetric encryption key. Special `key` label: ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `key.crypto_operations_rate`<br>`DGAUGE`, operations per second | Rate of cryptographic operations using symmetric encryption keys. Special `key` label: ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `asymmetricEncryptionKey.asymmetric_encryption_crypto_operations_rate`<br>`DGAUGE`, operations per second | Rate of cryptographic operations using asymmetric encryption keys. Special `key` label: ID of the asymmetric [encryption key pair](../../../kms/concepts/asymmetric-encryption-key.md). |
| `asymmetricSignatureKey.asymmetric_signature_crypto_operations_rate`<br>`DGAUGE`, operations per second | Rate of cryptographic operations using a digital signature. Special `key` label: ID of the asymmetric [signature key pair](../../../kms/concepts/asymmetric-signature-key.md). |