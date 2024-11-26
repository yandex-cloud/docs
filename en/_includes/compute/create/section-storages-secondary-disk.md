(Optional) Add a secondary [disk](../../../compute/concepts/disk.md):

* Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, click **{{ ui-key.yacloud.compute.instances.create-disk.button_create }}**.
* In the window that opens, select **{{ ui-key.yacloud.compute.instances.create-disk.value_source-disk }}**. You can select an existing disk or create a new one: either empty or from a snapshot / image.

    For example, to create a new empty disk:

    * Select `Create new`.
    * In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-none }}`.
    * Specify the disk name.
    * Select the [disk type](../../../compute/concepts/disk.md#disks_types).
    * Specify the required disk size and block size.
    * (Optional) In the **{{ ui-key.yacloud.compute.field_additional }}** field, enable **{{ ui-key.yacloud.compute.field_disk-autodelete }}** if you need to automatically delete this disk when deleting the VM.
    * Click **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}**.