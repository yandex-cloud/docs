# Connecting to a VM serial console using the CLI

After [enabling access](./index.md), you can connect to the serial console to manage your [VM](../../concepts/vm.md).

{% include [sc-warning](../../../_includes/compute/serial-console-warning.md) %}

## Connecting to a serial console {#connect-to-serial-console}

{% note info %}

How a serial console works depends on how the operating system is set up. {{ compute-name }} provides a communication channel between the user and VM's COM port; however, it does not guarantee that the console works properly on your OS.

{% endnote %}

To connect to a serial console, use the CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

Your next steps depend on the operating system and whether [{{ oslogin }}](../../../organization/concepts/os-login.md) access is enabled for the VM. With {{ oslogin }} access [enabled](../vm-connect/enable-os-login.md), you can connect to the serial console using short-lived SSH certificates. To connect to VMs with {{ oslogin }} access disabled, use SSH keys.

Some operating systems may prompt you for your user credentials to access the VM. So, before connecting to the serial console of VMs running on such systems, create a local user password.

{% list tabs %}

- Linux with an SSH key

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/ssh.md) to the VM via SSH.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}

  1. Connect to the serial console of the VM you need:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --ssh-key ~/.ssh/id_ed25519
      ```

      Where:
      * `--instance-name`: VM name. This is a required parameter.
          Instead of the VM name, you can provide its ID in the `--instance-id` parameter.

      * `--ssh-key`: Path to the private key for SSH access to the VM, e.g., `~/.ssh/id_ed25519`. This is an optional parameter. If you omit it, the `yc_serialssh_key` SSH key will be generated.

      {% include [key-without-password-alert](../../../_includes/compute/key-without-password-alert.md) %}

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the serial console.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

- Linux via {{ oslogin }}

  1. Create a local user password on the VM:
      1. [Connect](../vm-connect/os-login.md) to the VM via {{ oslogin }}.
      1. {% include [create-serial-console-user](../../../_includes/compute/create-serial-console-user.md) %}
      1. Disconnect from the VM. To do this, enter the `logout` command.

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-os-login-serial-console-auth](../../../_includes/compute/enable-os-login-serial-console-auth.md) %}

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Connect to the serial console of the VM in question:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name>
      ```

      Where `--instance-name` is the VM name. This is a required parameter. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.

      When connecting, the system may prompt you for a login and password to authenticate to the VM. Enter the username and password you created earlier to gain access to the serial console.

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

- Windows

  1. See the description of the CLI command for connecting to a serial console:

      ```bash
      yc compute connect-to-serial-port --help
      ```

  1. Get a list of VMs in the default [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

  1. {% include [enable-metadata-serial-console-auth](../../../_includes/compute/enable-metadata-serial-console-auth.md) %}

  1. Connect to the Windows SAC of the VM in question:

      ```bash
      yc compute connect-to-serial-port \
        --instance-name <VM_name> \
        --port 2
      ```

      Where:
      * `--instance-name`: VM name. This is a required parameter. Instead of the VM name, you can provide its ID in the `--instance-id` parameter.
      * `--port`: Number of the port to use for connecting to the serial console. This is an optional parameter. When connecting to the Windows serial console (SAC), specify `2`.

      When prompted by the system, enter your username, domain (VM name), and password. For more information, see [Starting the command shell in the Windows SAC](./windows-sac.md).

      For more information about the `yc compute connect-to-serial-port` command, see the [CLI reference](../../../cli/cli-ref/compute/cli-ref/connect-to-serial-port.md).

{% endlist %}

### Troubleshooting {#troubleshooting}

* If you connect to the serial console and nothing appears on the screen:
  * Press **Enter**.
  * Restart the VM (for VMs created before February 22, 2019).

## Disconnecting from a serial console {#turn-off-serial-console}

To disconnect from a serial console:
1. Press **Enter**.
1. Enter `~.` in succession.