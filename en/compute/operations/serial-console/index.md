---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Getting started with the serial console

The serial console allows you to access a VM regardless of the network or OS status. For example, you can use the console for troubleshooting VM issues or when there are problems with SSH access.

Serial console access is disabled by default.

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Before you start {#before-you-begin}

Before you enable serial console access on a VM:

1. Prepare the key pair (public and private keys) for SSH access to the VM. The serial console authenticates users via SSH keys.

1. Create a text file (for example, `sshkeys.txt`) and specify the following:

   ```txt
   <user name>:<user's public SSH key
   ```

   Example of a text file for `yc-user`:

   ```txt
   yc-user:ssh-rsa AAAAB3Nza......OjbSMRX yc-user@example.com
   ```

   By default, a user's SSH keys are stored in the `~/.ssh` directory of this user. You can get a public key by running `cat ~/.ssh/<public key name>.pub`.

## Enabling the console when creating a VM from a public image {#turn-on-for-new-instance}

To enable access to the serial console when creating a VM, set the `serial-port-enable` parameter in metadata to `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

{% list tabs %}

- Linux

  1. View the description of the CLI command for creating a VM:

     ```bash
     $ yc compute instance create --help
     ```

  1. Select a public [image](../images-with-pre-installed-software/get-list.md) based on the Linux OS (such as Ubuntu).

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
          --name first-instance \
          --zone ru-central1-a \
          --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
          --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts \
          --metadata-from-file ssh-keys=sshkeys.txt \
          --ssh-key ~/.ssh/<public key name>.pub \
          --metadata serial-port-enable=1
      ```

      This command creates the VM:
      - With Ubuntu.
      - Named `first-instance`.
      - In the `ru-central1-a` zone.
      - With the serial console active.

      A user named `yc-user` will be automatically created in the VM's OS with the specified public key.

- Windows

  1. View the description of the CLI command for creating a VM:

     ```
     $ yc compute instance create --help
     ```

  1. Select a public [image](../images-with-pre-installed-software/get-list.md) for Windows.

      {% include [standard-images](../../../_includes/standard-images.md) %}

  1. Create a VM in the default folder:

      ```
      $ yc compute instance create \
      --name win-instance \
      --metadata-from-file user-data=metadata.yaml \
      --zone ru-central1-c \
      --network-interface subnet-name=default-c,nat-ip-version=ipv4 \
      --create-boot-disk image-folder-id=standard-images,image-family=windows-2016-gvlk \
      --metadata serial-port-enable=1
      ```

      This command creates the VM:
      - With Windows.
      - Named `win-instance`.
      - In the `ru-central1-c` zone.
      - With the serial console active.

      The `Administrator` user with the password specified in the `metadata.yaml` file will be automatically created in the OS.

{% endlist %}

## Enabling the console when updating a VM {#turn-on-for-current-instance}

To enable access to the serial console when editing the VM settings, set the `serial-port-enable` parameter in metadata to `1`.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Get a list of VMs in the default folder:

    {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Select the VM `ID` or `NAME` (for example, `first-instance`).

1. Set `serial-port-enable=1` in the VM metadata:

   ```
   $ yc compute instance add-metadata \
       --name first-instance \
       --metadata serial-port-enable=1
   ```

   This command will start activating the serial console on the machine named `first-instance`.

## Configuring a VM for serial port access {#configuration}

For the serial console to be available from the operating system, the OS must be configured accordingly:

* [Linux](#linux-configuration)
* [Windows](#windows-configuration)

### Linux {#linux-configuration}

To connect to the Linux serial console, make sure that [SSH password authentication is disabled](#ssh-pass-off) and, if necessary, [set a password](#create-pass) for the appropriate OS user.

#### Disable SSH password authentication {#ssh-pass-off}

{% include [vm-connect-ssh-linux-note](../../../_includes/vm-connect-ssh-linux-note.md) %}

If you use your own image, make sure that SSH access with your username and password is disabled.

To disable SSH password authentication:

1. Open the configuration file on the SSH server (`/etc/ssh/sshd_config` by default). Only a superuser has read and write access to the file.

1. Set the `PasswordAuthentication` option to `no`.

1. Restart the SSH server:

   ```
   $ sudo systemctl restart ssh
   ```

#### Create a password for a Linux user {#create-pass}

Some operating systems may request user data to access the VM. Before connecting to these machines, create a local password for the default user.

To create a local password, use the CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. Get a list of VMs in the default folder:

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Select the VM `ID` or `NAME` (for example, `first-instance`).

1. Get the VM's public IP address.

   ```
   $ yc compute instance get first-instance
   ```

   In the command output, find the address of the VM in the `one_to_one_nat` section:

   ```
   ...
   one_to_one_nat:
       address: <public IP address>
       ip_version: IPV4
   ...
   ```

1. Connect to the VM. For more information, see [{#T}](../vm-connect/ssh.md#vm-connect).

1. Create a local password. In Linux, you can set a password using the `passwd` command:

   ```
   $ sudo passwd <user name>
   ```

   Example for `yc-user`:

   ```
   $ sudo passwd yc-user
   ```

1. Terminate the SSH session with the `exit` command.

### Windows {#windows-configuration}

An equivalent of the serial console in Windows is the Speicial Administration Console (SAC).

{% note info %}

If you created your VM after February 22, 2019, you don't need to configure anything else: the SAC is enabled by default.

{% endnote %}

If you created it before February 22, 2019, you need to update the Windows registry to connect to the SAC:

1. [Connect to the VM over RDP](../vm-connect/rdp.md).

1. To do this, run `cmd` or PowerShell and execute the following commands:

   ```
   $ bcdedit /ems "{current}" on
   The operation completed successfully.
   
   $ bcdedit /emssettings EMSPORT:2 EMSBAUDRATE:115200
   The operation completed successfully.
   ```

1. Restart the VM.

{% endlist %}