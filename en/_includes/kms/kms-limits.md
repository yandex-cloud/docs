#### Quotas {#kms-quotas}

#|
|| Type of limitation | Value ||
|| Number of [symmetric keys](../../kms/concepts/key.md)
`kms.keys.count` | 100 ||
|| Number of asymmetric [encryption](../../kms/concepts/asymmetric-encryption-key.md) keys
`kms.asymmetricEncryptionKeys.count` | 100 ||
|| Number of asymmetric [signature](../../kms/concepts/asymmetric-signature-key.md) keys
`kms.asymmetricSignatureKeys.count`| 100 ||
|#


#### Limits {#kms-limits}

Type of limitation | Value
----- | -----
Number of versions per key | 100
Maximum amount of data to encrypt with the [encrypt](../../kms/api-ref/SymmetricCrypto/encrypt) operation | 32 KB
