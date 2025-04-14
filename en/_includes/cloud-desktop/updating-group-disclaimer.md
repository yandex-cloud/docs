Changing an [image](../../cloud-desktop/concepts/images.md), [data disk](../../cloud-desktop/concepts/disks.md#working-disk) size, vCPU, vCPU or RAM share in [desktop group](../../cloud-desktop/concepts/desktops-and-groups.md) settings will trigger the recreation of its [desktops](../../cloud-desktop/concepts/desktops-and-groups.md).

The system will recreate the [boot disk](../../cloud-desktop/concepts/disks.md#boot-disk) using the image you previously selected for the desktop group. As a result, you will lose the software and updates installed there. These changes will not affect the data disk and user directory though.

To apply changes to a specific desktop, [update](../../cloud-desktop/operations/desktops/update.md) it.