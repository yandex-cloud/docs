The `kms.admin` role enables managing encryption and digital signature keys and key pairs, as well as managing access to such keys or key pairs and using them to encrypt, decrypt, and sign data.

Users with this role can:
* View info on [access bindings](../../iam/concepts/access-control/index.md#access-bindings) to [symmetric encryption keys](../../kms/concepts/key.md) and modify such bindings.
* View the list of symmetric encryption keys and details on them, as well as create, activate, deactivate, rotate, and delete symmetric encryption keys, or change their default version and metadata (including rotation period).
* Encrypt and decrypt data using symmetric encryption keys.
* View info on access bindings to [asymmetric encryption key pairs](../../kms/concepts/asymmetric-encryption-key.md) and modify such bindings.
* View details on asymmetric encryption key pairs as well as create, activate, deactivate, and delete such key pairs, or modify their metadata.
* Get a [public key](../../kms/concepts/asymmetric-encryption.md#acquire-public-key) and decrypt data using a private key from an asymmetric encryption key pair.
* View info on access bindings to [digital signature key pairs](../../kms/concepts/asymmetric-signature-key.md) and modify such bindings.
* View details on digital signature key pairs as well as create, activate, deactivate, and delete such key pairs, or modify their metadata.
* Get a public key and sign data using a private key from a digital signature key pair.
* View details on Key Management Service [quotas](../../kms/concepts/limits.md#kms-quotas).
* View info on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

This role also includes the `kms.editor` permissions.