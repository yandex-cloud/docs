{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder to create your desktop group in.
   1. In the list of services, select **{{ cloud-desktop-name }}**.
   1. Click **Create desktop group**.
   1. Enter a name and description of the desktop group.
   1. Select an OS [image](../../cloud-desktop/concepts/images.md).
   1. In the **Disks** section:
      * Select the boot and working [disk](../../cloud-desktop/concepts/disks.md) [types](../../compute/concepts/disk.md#disks-types).
      * Specify the boot and working disk size.
   1. Under **Computing resources**:
      * Specify the number of vCPU cores.
      * Choose a [guaranteed](../../compute/concepts/performance-levels.md) vCPU performance.
      * Specify the amount of RAM.
   1. Under **Network settings**, select the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) to host desktops.
   1. Click **Create**.

{% endlist %}
