Optionally, add a secondary [disk](../../../compute/concepts/disk.md):

* Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
* In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**. You can select an existing disk or create a new one, either empty or from a snapshot or image.

    For example, to create a new empty disk:

    * Select `Create new disk`.
    * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
    * Enter a name for the disk.
    * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
    * Specify the required disk and block size.
    * Optionally, enable **{{ ui-key.yacloud.compute.field_additional }}** in the **{{ ui-key.yacloud.compute.field_disk-autodelete }}** field if you need this disk automatically deleted when deleting the VM.
    * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.