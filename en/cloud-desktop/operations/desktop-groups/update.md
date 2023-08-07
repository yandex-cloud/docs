# Updating a desktop group

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the desktop group is located.
   1. In the list of services, select **{{ cloud-desktop-name }}**.
   1. Next to the group to update, click ![options](../../../_assets/options.svg) and select **Edit**.
   1. Select an OS [image](../../concepts/images.md).

      {% note warning %}

      Updating an image deletes all data on the desktop [boot disks](../../concepts/disks.md#boot-disk). Data on [working disks](../../concepts/disks.md#working-disk) will persist.

      {% endnote %}

   1. Under **Disks**, increase the working disk size.
   1. Under **Computing resources**:
      * Specify the number of vCPU cores.
      * Choose a [guaranteed](../../../compute/concepts/performance-levels.md) vCPU performance.
      * Specify the amount of RAM.
   1. Click **Save**.

{% endlist %}

To apply the changes to the desktop, [update](../desktops/update.md) it.
