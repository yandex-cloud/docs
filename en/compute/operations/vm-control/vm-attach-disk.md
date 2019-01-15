# Attaching a disk to a VM

[!INCLUDE [disk-auto-delete](../../_includes_service/disk-auto-delete.md)]

To attach a disk to a VM:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's attach disk command:

    ```
    $ yc compute instance attach-disk --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
1. Stop the VM:

    ```
    $ yc compute instance stop first-instance
    ```

1. Get a list of disks in the default folder:

    [!INCLUDE [compute-disk-list](../../_includes_service/compute-disk-list.md)]

1. Select the `ID` or `NAME` of the necessary disk, for example `first-disk`. To view the list of disks attached to the VM, run the command:

    ```
    $ yc compute instance get --full first-instance
    ```

1. Attach the disk to the VM:

    ```
    $ yc compute instance attach-disk first-instance \
        --disk-name first-disk \
        --mode rw
    ```

    To specify whether to delete the disk when deleting the VM, set the `--auto-delete` flag:

    ```
    $ yc compute instance attach-disk first-instance \
        --disk-name first-disk \
        --mode rw \
        --auto-delete
    ```

1. Start the VM:

    ```
    $ yc compute instance start first-instance
    ```

**[!TAB API]**

Use the [attachDisk](../../api-ref/Instance/attachDisk.md) method for the [Instance](../../api-ref/Instance/) resource.

---

