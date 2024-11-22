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

Your next steps depend on the operating system and whether [{{ oslogin }}](../../../organization/concepts/os-login.md) access is enabled for the VM. If {{ oslogin }} access is [enabled](../vm-connect/enable-os-login.md) for the VM, you connect to the serial console using short-lived SSH certificates. SSH keys are used to connect to VMs with {{ oslogin }} access disabled.

Some OS's may request user credentials to access a VM. In such cases, you need to create a local user password before connecting to the serial consoles of such VMs.

{% list tabs %}

- Linux with an SSH key

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/ssh.md) to the VM over SSH.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. View the description of the CLI command for connecting to the serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Connect to the serial console of the VM you need:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --ssh-key ~/.ssh/id_ed25519
      ```

      Where:
      * `--instance-name`: Required parameter. VM name.
          Instead of the VM name, you can provide its ID in the `--instance-id` parameter.

      * `--ssh-key`: Optional parameter. Path to the private key for SSH access to the VM, e.g., `~/.ssh/id_ed25519`. If this parameter is omitted, the `yc_serialssh_key` SSH key will be generated.

      {% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

      When connecting, the system may request a username and password to authenticate on the VM. Enter the username and password you created earlier to gain access to the serial console.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

- Linux via {{ oslogin }}

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/os-login.md) to the VM via {{ oslogin }}.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}

  1. View the description of the CLI command for connecting to the serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Connect to the serial console of the VM you need:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name>
      ```

      Where `--instance-name` is a required parameter. VM name. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.

      When connecting, the system may request a username and password to authenticate on the VM. Enter the username and password you created earlier to gain access to the serial console.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

- Windows

  1. View the description of the CLI command for connecting to the serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. Connect to the Windows SAC of the VM you need:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --port 2
      ```

      Where:
      * `--instance-name`: Required parameter. VM name. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.
      * `--port`: Optional parameter. Port number to connect to the serial console. When connecting to the Windows serial console (SAC), specify `2`.

      When prompted by the system, enter your username, domain (VM name), and password. For more information, see [Starting your terminal in the Windows serial console (SAC)](./windows-sac.md).

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/managed-services/compute/connect-to-serial-port.md).

{% endlist %}

### Troubleshooting {#troubleshooting}

* If you connect to the serial console and nothing appears on the screen:
  * Press **Enter**.
  * Restart the VM (for VMs created before February 22, 2019).

## Disconnecting from the serial console {#turn-off-serial-console}

To disconnect from the serial console:
1. Press **Enter**.
1. Enter the following characters in succession: `~.`.