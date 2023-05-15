# Connecting to a VM's serial console via CLI

After [enabling access](./index.md), you can connect to the serial console to interact with the [VM](../../concepts/vm.md).

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Connecting to the serial console {#connect-to-serial-console}

{% note info %}

How the serial console works depends on the operating system settings. {{ compute-name }} provides a communication channel between the user and COM port on the VM, but it does not guarantee that the console works properly on the OS.

{% endnote %}

To connect to the serial console, use the CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. View the description of the CLI command for connecting to the serial console:

   ```bash
   yc compute connect-to-serial-port --help
   ```

1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

   {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Select the VM `ID` or `NAME` (for example, `first-instance`).
1. Connect to the Linux serial console:

   ```bash
   yc compute connect-to-serial-port \
     --instance-name first-instance \
     --ssh-key ~/.ssh/id_ed25519
   ```

   Or to Windows SAC:

   ```bash
   yc compute connect-to-serial-port \
     --instance-name first-instance \
     --port 2
   ```

   Where:
   * `instance-name`: Required parameter. VM name.
   * `user`: Optional parameter. Username. If this parameter is omitted, the default `yc-user` user will be used. The `yc-user` user is generated automatically when the VM is being created. For more information, see [{#T}](../vm-create/create-linux-vm.md).
   * `port`: Optional parameter. Port number to connect to the serial console.
      * The default value is 1. You don't need to specify this parameter to connect to the Linux serial console.
      * When connecting to the Windows serial console (SAC), pass the value 2.
   * `ssh-key`: Optional parameter. Path to the private key for SSH access to the Linux VM to be added to the [metadata](../../concepts/vm-metadata.md). If this parameter is omitted, the `yc_serialssh_key` SSH key is generated.

### Troubleshooting {#troubleshooting}

* If you connect to the serial console and nothing appears on the screen:
   * Press **Enter**.
   * Restart the VM (for VMs created before February 22, 2019).
* If the OS requests user credentials to provide access to the VM, enter the login and password:
   * On a Linux VM, set a user password first. Run `sudo passwd <username>`. For more information, see [Getting started with the serial console](./index.md#linux-configuration).
   * On a Windows VM, enter your username, domain (VM name), and password. For more information, see [Starting your terminal in the Windows serial console (SAC)](./windows-sac.md).

## Disconnecting from the serial console {#turn-off-serial-console}

To disconnect from the serial console:
1. Press **Enter**.
1. Enter the following characters in order: `~.`.