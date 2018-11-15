# Deleting a VM

> [!IMPORTANT]
>
> Deleting a VM is an operation that cannot be canceled or reversed. You cannot restore a deleted VM.

When you select a disk to attach to a VM, you can specify whether that disk should be deleted when deleting the VM. You can choose this option when creating a VM, updating it, and attaching a new disk to it.

If previously created disks are attached to the VM, they will be detached when the VM is deleted. The disk data will be preserved and you will be able to attach these disks to another VM in the future.

---

**[!TAB Management console]**

1. Select the folder the VM belongs to.
1. Click on the **Yandex Compute Cloud** tile.
1. Select the VM → click ![](../../../_assets/dots.png) → select **Delete**.

    To do this with multiple VMs, select the VMs you need to delete from the list → click **Delete** at the bottom of the screen.

1. Confirm the deletion.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's delete VM command:

    ```
    $ yc compute instance delete --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need, for example `first-instance`.
1. Delete the VM:

    ```
    $ yc compute instance delete first-instance
    ```

---
