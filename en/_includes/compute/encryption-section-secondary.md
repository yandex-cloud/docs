(Optional) To [encrypt](../../compute/concepts/encryption.md) a boot disk or a secondary disk, under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click ![image](../../_assets/console-icons/pencil.svg) to the right of the disk name and set encryption parameters for the disk:

* Select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
* In the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field, select the [key](../../kms/concepts/key.md) to encrypt the disk with. To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.
* In the **{{ ui-key.yacloud.compute.disk-form.label_service-account }}** field, select a [service account](../../iam/concepts/users/service-accounts.md) with the `kms.keys.encrypterDecrypter` [role](../../kms/security/index.md#kms-keys-encrypterDecrypter) for the specified key. To [create](../../iam/operations/sa/create.md) a service account, click **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**.

{% include [encryption-keys-note](encryption-keys-note.md) %}
