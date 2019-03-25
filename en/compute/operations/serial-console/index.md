# Getting started with a serial console

A serial console is a way to access a VM regardless of the network or OS status. You can use the console, for example, for troubleshooting the VM or when there are problems accessing it via SSH.

> [!IMPORTANT]
>
> Enabled access to the serial console is not secure: hackers may get access to your VM. Use these instructions if you are sure you know what you are doing.

Serial console access is disabled by default. You can grant access to the serial console when creating or updating a VM. To do this, set `serial-port-enable=1` in metadata. If the parameter value is `0`, access is disabled. For more information about metadata, see [[!TITLE]](../../concepts/vm-metadata.md).

## Before getting started

Before you enable serial console access on a VM:

1. Prepare the key pair (public and private keys) for SSH access to the VM. The serial console authenticates users via SSH keys.

1. Create a text file (for example, `sshkeys.txt`) and specify the following:

    ```txt
    <user name>:<user's public SSH key>
    ```

    Example of a text file for `yc-user`:

    ```txt
    yc-user:ssh-rsa AAAAB3Nza......OjbSMRX yc-user@example.com
    ```

    By default, a user's SSH keys are stored in the `~/.ssh` directory of this user. You can get a public key by running `cat ~/.ssh/<public key name>.pub`.

## Enabling the console when creating a VM from a public Linux image {#turn-on-for-new-instance}

To enable access to the VM's serial console:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's create VM command:

   ```bash
   $ yc compute instance create --help
   ```

1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on Linux OS (for example, Ubuntu).

    [!INCLUDE [standard-images](../../../_includes/standard-images.md)]

1. Create a VM in the default folder:

    ```bash
    $ yc compute instance create \
        --name first-instance \
        --zone ru-central1-a \
        --public-ip \
        --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts \
        --metadata-from-file ssh-keys=sshkeys.txt \
        --ssh-key ~/.ssh/<public key name>.pub \
        --metadata serial-port-enable=1
    ```

    This command creates a VM with Ubuntu OS, named `first-instance`, located in the `ru-central1-a` zone, and with the active serial console. A user named `yc-user` will be automatically created in the VM's OS with the specified public key.

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

---

## Enabling the console when updating a Linux-based VM {#turn-on-for-current-instance}

When you update a VM, the existing set of metadata is completely replaced with the metadata passed in the command.

To avoid losing the metadata:

1. Get information about the VM with the metadata. All user-defined metadata is specified in the `user-data` key.

    ```bash
    $ yc compute instance get --full <VM name>
    ```

1. Copy the received data to a file (for example, `saved-userdata.yaml`) and use it when updating the VM.

To enable access to the serial console for a previously run VM:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. See the description of the CLI's update VM command:

    ```bash
    $ yc compute instance update --help
    ```

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).

1. Update the VM in the default folder:

    ```bash
    $ yc compute instance update \
        --name first-instance \
        --metadata-from-file user-data=saved-userdata.yaml \
        --metadata-from-file ssh-keys=sshkeys.txt \
        --metadata serial-port-enable=1
    ```

    This command will update the VM named `first-instance` by activating the serial console.

---

## Configuring Linux for serial port access {#add-password}

[!INCLUDE [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md)]

Create a local password for the default user:

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Get a list of VMs in the default folder:

    [!INCLUDE [compute-instance-list](../../_includes_service/compute-instance-list.md)]

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).

1. Get the VM's public IP address.

    ```bash
    $ yc compute instance get first-instance
    ```

    In the command output, find the address of the VM in the `one_to_one_nat` section:

    ```bash
    ...
    one_to_one_nat:
        address: <public IP address>
        ip_version: IPV4
    ...
    ```

    If there is no public IP address, [update the VM](../vm-control/vm-update.md) by additionally specifying the `--public-ip` flag.

1. Connect to the VM. For more information, see the section [[!TITLE]](../vm-control/vm-connect-ssh.md#vm-connect).

1. Create a local password. In Linux, you can set a password using the `passwd` command:

    ```
    sudo passwd <user name>
    ```

    Example for `yc-user`:

    ```
    sudo passwd yc-user
    ```

1. Terminate the SSH session with the `exit` command.

---

