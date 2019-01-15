# Updating a VM

After you create a VM, you can change its name, description, tags, platform, or metadata.

For more information about how to update a VM's configuration, see the section [[!TITLE]](vm-update-resources.md).

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's update VM parameter command:

    ```
    $ yc compute instance update --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
1. Change the VM parameters, for example, rename it:

    ```
    $ yc compute instance update first-instance \
        --new-name windows-vm
    ```

**[!TAB API]**

To change the VM, use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/) resource.

---

## Examples

### Viewing a list of configurable parameters

To view the list of configurable parameters, run the command:

---

**[!TAB CLI]**

```
$ yc compute instance update --help
```

---

### Changing the name and description

To change the name and description of a VM, follow these steps:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
1. Change the VM's name and description:

    ```
    $ yc compute instance update first-instance \
        --new-name first-vm \
        --description "changed description vm via CLI"
    ```

---

### Changing metadata

Metadata based on different operating systems may differ. When you change an existing set of metadata, it is completely replaced by the set passed in the command.

To change a VM's metadata, follow these steps:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
1. Get information about the VM with the metadata. All user-defined metadata is specified in the `user-data` key.

    ```
    $ yc compute instance get --full first-instance
    ```

1. Change the VM's metadata. You can change the metadata using the flags:
    - `--metadata` — to change a value from a single string.
    - `--metadata-from-file` — to change a value from multiple strings.

    Example of changing the administrator's password on a Windows-based VM.

    ```
    $ yc compute instance update first-instance \
        --metadata user-data="#ps1\nnet user Administrator <password>"
    ```

    The existing metadata set will be completely overwritten.

    [!INCLUDE [metadata-from-file](../../_includes_service/metadata-from-file.md)]

---

### Changing an SSH key

To change or add an SSH key, follow these steps:

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).
1. Get information about the VM with the metadata. All user-defined metadata is specified in the `user-data` key.

    ```
    $ yc compute instance get --full first-instance
    ```

    Sample response:

    ```
    ...
    #cloud-config
    users:
    - name: demo
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
            - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
    ...
    ```

1. Create a text file with any name, for example `metadata.txt`.
1. Copy the received data to the created file and add a new SSH key.

    Example:

    ```
    #cloud-config
    users:
    - name: demo
        groups: sudo
        shell: /bin/bash
        sudo: ['ALL=(ALL) NOPASSWD:ALL']
        ssh-authorized-keys:
            - ssh-rsa AAAAB3Nza......OjbSMRX user@example.com
            - ssh-rsa AAAAB3Nza......Pu00jRN user@example.com
    ```

1. Change the VM's metadata:

    ```
    $ yc compute instance update first-instance \
        --metadata-from-file user-data=metadata.txt
    ```

    The existing metadata set will be completely overwritten.

---

