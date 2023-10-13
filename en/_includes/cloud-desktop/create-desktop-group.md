{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your desktop group in.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
   1. Click **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
   1. Enter a name and description of the desktop group.
   1. Select an OS [image](../../cloud-desktop/concepts/images.md).
   1. Under **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Select the boot and working [disk](../../cloud-desktop/concepts/disks.md) [types](../../compute/concepts/disk.md#disks-types).
      * Specify the boot and working disk size.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Specify the number of vCPU cores.
      * Choose a [guaranteed](../../compute/concepts/performance-levels.md) vCPU performance.
      * Specify the amount of RAM.
   1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) to host desktops.
   1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}
