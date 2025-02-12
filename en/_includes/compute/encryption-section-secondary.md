Optionally, to [encrypt](../../compute/concepts/encryption.md) a boot disk or a secondary disk, under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click ![image](../../_assets/console-icons/pencil.svg) to the right of the disk name and configure encryption parameters for the disk:

* Select **{{ ui-key.yacloud.compute.disk-form.label_disk-encryption }}**.
* In the **{{ ui-key.yacloud.compute.disk-form.label_disk-kms-key }}** field, select the [key](../../kms/concepts/key.md) you want to use to encrypt the disk. To [create](../../kms/operations/key.md#create) a new key, click **{{ ui-key.yacloud.component.symmetric-key-select.button_create-key-new }}**.

{% include [encryption-disable-warning](encryption-disable-warning.md) %}

{% include [encryption-keys-note](encryption-keys-note.md) %}

