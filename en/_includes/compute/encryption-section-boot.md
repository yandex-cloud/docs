(Optional) To [encrypt](../../compute/concepts/encryption.md) a boot disk, under **{{ ui-key.yacloud.compute.instances.create.section_storages_ru }}**, configure encryption parameters for the disk:

* Select the **Encrypted disk** option.
* In the **{{ kms-short-name }} Key** field, select the [key](../../kms/concepts/key.md) with which you want to encrypt the disk. To [create](../../kms/operations/key.md#create) a new key, click **Create**.
* In the **Service account** field, select the [service account](../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../iam/concepts/access-control/roles.md#kms-keys-encrypterdecrypter) for the specified key. To [create](../../iam/operations/sa/create.md) a service account, click **Create**.

{% include [encryption-keys-note](encryption-keys-note.md) %}
