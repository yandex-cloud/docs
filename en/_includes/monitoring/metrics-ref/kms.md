The `name` label contains the metric name.

All {{ kms-name }} metrics share the `kms` label.

Service metrics:

| Metric name<br>Type, units | Description |
| --- | --- |
| `asymmetricEncryptionKey.asymmetric_encryption_crypto_operations_rate`<br>`RATE`, operations per second | Rate of cryptographic operations with asymmetric encryption keys. This metric features the `key` special label containing the ID of the asymmetric [encryption key pair](../../../kms/concepts/asymmetric-encryption-key.md). |
| `asymmetricSignatureKey.asymmetric_signature_crypto_operations_rate`<br>`RATE`, operations per second | Rate of cryptographic operations with a digital signature. This metric features the `key` special label containing the ID of the asymmetric [signature key pair](../../../kms/concepts/asymmetric-signature-key.md). |
| `key.active_versions_count`<br>`DGAUGE`, count | Number of active versions of the symmetric encryption key. This metric features the `key` special label containing the ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `key.crypto_operations_rate`<br>`RATE`, operations per second | Rate of cryptographic operations with symmetric encryption keys. This metric features the `key` special label containing the ID of the [symmetric encryption key](../../../kms/concepts/key.md). |
| `key_asymmetric_encryption_crypto_operations_rate_created`<br>`DGAUGE`, operations | Number of cryptographic operations with asymmetric encryption keys. This metric features the `key` special label containing the ID of the asymmetric [encryption key pair](../../../kms/concepts/asymmetric-encryption-key.md). |
| `key_asymmetric_signature_crypto_operations_rate_created`<br>`DGAUGE`, operations | Number of cryptographic operations with a digital signature. This metric features the `key` special label containing the ID of the asymmetric [signature key pair](../../../kms/concepts/asymmetric-signature-key.md). |
| `key_crypto_operations_rate_created`<br>`DGAUGE`, operations | Total cryptographic operations with symmetric encryption keys, asymmetric encryption key pairs, and digital signatures. This metric features the `key` special label containing the key ID. |