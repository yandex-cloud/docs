The `kms.editor` role allows you to create encryption and digital signature keys and key pairs as well as use them to encrypt, decrypt, and sign data.

Users with this role can:
* View the list of [symmetric](../../kms/concepts/key.md) encryption keys, info on them and their access [bindings](../../iam/concepts/access-control/index.md#access-bindings), as well as create, rotate, and modify symmetric key metadata, including rotation periods.
* Encrypt and decrypt data using symmetric encryption keys.
* View info on [asymmetric encryption key pairs](../../kms/concepts/asymmetric-encryption-key.md) and access bindings to them as well as create such key pairs or modify their metadata.
* Get a [public key](../../kms/concepts/asymmetric-encryption.md#acquire-public-key) and decrypt data using a private key from an asymmetric encryption key pair.
* View info on [digital signature key pairs](../../kms/concepts/asymmetric-signature-key.md) and access bindings to them as well as create such key pairs or modify their metadata.
* Get a public key and sign data using a private key from a digital signature key pair.
* View details on the Key Management Service [quotas](../../kms/concepts/limits.md#kms-quotas).