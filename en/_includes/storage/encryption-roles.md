To work with objects in an [encrypted](../../storage/concepts/encryption.md) bucket, a user or [service account](../../iam/concepts/users/service-accounts.md) must have the following [roles for the encryption key](../../kms/operations/key-access.md) in addition to the `storage.configurer` [role](../../storage/security/index.md#storage-configurer):

* `kms.keys.encrypter`: To read the key, [encrypt](../../kms/security/index.md#kms-keys-encrypter) and upload objects.
* `kms.keys.decrypter`: To read the key, [decrypt](../../kms/security/index.md#kms-keys-decrypter) and download objects.
* `kms.keys.encrypterDecrypter`: This role includes the `kms.keys.encrypter` and `kms.keys.decrypter` [permissions](../../kms/security/index.md#kms-keys-encrypterDecrypter).

For more information, see [{{ kms-name }} service roles](../../kms/security/index.md#service-roles).