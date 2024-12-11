(Optional) To [encrypt](../../compute/concepts/encryption.md) a disk, under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure encryption parameters for the disk:

  * Select the **Encrypted disk** option.
  * In the **{{ kms-short-name }} key** field, select the [key](../../kms/concepts/key.md) with which you want to encrypt the disk. To [create](../../kms/operations/key.md#create) a new key, click **Create**.

  {% include [encryption-keys-note](encryption-keys-note.md) %}
