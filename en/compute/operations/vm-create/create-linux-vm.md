# Creating a VM from a public Linux image

This section provides guidelines on how to create a VM with Linux OS. To create a Windows-based VM, follow the instructions [[!TITLE]](create-windows-vm.md).

---

**[!TAB Management console]**

To create a VM:

[!INCLUDE [create-instance-via-concole-linux](../../_includes_service/create-instance-via-concole-linux.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

To create a VM:

1. See the description of the CLI's create VM command:

    ```
    $ yc compute instance create --help
    ```

1. Prepare a key pair (public and private) for SSH access to the VM.
1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on Linux OS (for example, CentOS 7). To get a list of available images, use the command:

    ```
    $ yc compute image list --folder-id standard-images
    +----------------------+---------------------+----------+----------------------+--------+-------------+
    |          ID          |        NAME         |  FAMILY  |     PRODUCT IDS      | STATUS | DESCRIPTION |
    +----------------------+---------------------+----------+----------------------+--------+-------------+
    ...
    | fd83869rbingor0in0ui | centos-7-1537787644 | centos-7 | f2en2dtd08b5la74mlde | READY  |     ...     |
    ...
    +----------------------+---------------------+----------+----------------------+--------+-------------+
    ```

1. Create a VM in the default folder:

    ```
    $ yc compute instance create \
        --name my-yc-vm \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-name=centos-7-1537787644 \
        --ssh-key ~/.ssh/id_rsa.pub
    ```

    This command creates a VM named `my-yc-vm` with CentOS 7 in the `ru-central1-a` zone and with a public IP.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

---

[!INCLUDE [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md)]

#### See also
- [[!TITLE]](../vm-control/vm-connect-ssh.md)
