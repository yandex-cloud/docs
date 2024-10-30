Updating an [image](../../cloud-desktop/concepts/images.md), [working disk](../../cloud-desktop/concepts/disks.md#working-disk) size, vCPU, vCPU and RAM share in [group](../../cloud-desktop/concepts/desktops-and-groups.md) parameters will cause [desktops](../../cloud-desktop/concepts/desktops-and-groups.md) to be recreated.

The [boot disk](../../cloud-desktop/concepts/disks.md#boot-disk) will be recreated from the image previously selected for the desktop group. You will lose the software and updates installed on the boot disk. The working disk will remain the same. The changes will not affect the user directory.

To apply the changes to a specific desktop, [refresh](../../cloud-desktop/operations/desktops/update.md) it.