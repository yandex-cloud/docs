# Updating a VM

After you create a VM, you can change its name, description, tags, or metadata.

[!INCLUDE [change-vm-resources](../../_includes_service/change-vm-resources.md)]

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's update VM parameter command:

    ```
    $ yc compute instance update --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need, for example `first-instance`.

1. Change the VM parameters, for example, rename it:

    ```
    $ yc compute instance update first-instance \
        --new-name windows-vm
    ```

**[!TAB API]**

To change the VM, use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/index.md) resource.

---

