{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder you want to create an encrypted disk in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
   1. In the left-hand panel, select ![image](../../_assets/compute/disks-pic.svg) **{{ ui-key.yacloud.compute.switch_disks }}**.
   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.
   1. Enter the disk name.

      {% include [name-format](../name-format.md) %}

   1. Select the same [availability zone](../../overview/concepts/geo-scope.md) in which the source disk was residing.
   1. Set the disk parameters: [disk type](../../compute/concepts/disk.md#disks_types), [block size](../../compute/concepts/disk.md#maximum-disk-size), and [disk size](../../compute/concepts/disk.md#maximum-disk-size).
   1. In the **{{ ui-key.yacloud.compute.instances.create-disk.field_source }}** field, select `{{ ui-key.yacloud.compute.instances.create-disk.value_source-image }}` and select the image you created earlier in the list below. Use the filter to find the image.
   1. Under **Encryption**:

      {% include [encryption-section](encryption-section.md) %}

   1. Click **{{ ui-key.yacloud.compute.disks.button_create }}**.

   After creation, the disk will have the `Creating` status. Wait until the disk status changes to `Ready` before using it.

{% endlist %}
