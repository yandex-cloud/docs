# Connecting to a VM's serial console via CLI

After [enabling access](index.md), you can connect to the serial console to work with the VM. Serial console access is not secure, so enabling it might allow hackers to access your VM. [Disable](disable.md) access after you finish working with the serial console.

## Connecting to the serial console {#connect-to-serial-console}

{% note info %}

How the serial console works depends on the operating system settings. {{ compute-name }} provides a communication channel between the user and COM port on the VM, but it doesn't guarantee that the console works properly on the operating system.

{% endnote %}

To connect to the serial console, use the CLI.

{% include [cli-install](../../../_includes/cli-install.md) %}

{% include [default-catalogue](../../../_includes/default-catalogue.md) %}

1. View the description of the CLI command for connecting to the serial console:

    ```
    $ yc compute connect-to-serial-port --help
    ```

1. Get a list of VMs in the default folder:

    {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

1. Select the `ID` or `NAME` of the VM (for example, `first-instance`).

1. Connect to the Linux serial console:

    ```
    $ yc compute connect-to-serial-port \
         --instance-name first-instance \
         --ssh-key ~/.ssh/id_rsa
    ```

    Or to Windows SAC:

    ```
    $ yc compute connect-to-serial-port \
         --instance-name first-instance \
         --port 2
    ```

    | Parameter | Value |
    | ----- | ----- |
    | `instance-name` | Required parameter. Name of the instance. |
    | `user` | Optional parameter. User name. If this parameter is omitted, the default `yc-user` user will be used. The `yc-user` user is generated automatically when the VM is being created. Learn more in [{#T}](../vm-create/create-linux-vm.md). |
    | `port` | Optional parameter. Port number to connect to the serial console. The default value is 1. You don't need to specify this parameter to connect to the Linux serial console. When connecting to the Windows serial console (SAC), pass the value 2. |
    | `ssh-key` | Optional parameter. Path to the private key for SSH access to the Linux VM to be added to the [metadata](../../concepts/vm-metadata.md). If this parameter is omitted, the `yc_serialssh_key` SSH key is generated. |

#### Troubleshooting {#troubleshooting}

- If you connect to the serial console and nothing appears on the screen:
    - Press `Enter`.
    - Restart the VM (for virtual machines created before February 22).
- If the system requests user data to provide access to the VM, enter the login and password.

## Disconnecting from the serial console {#turn-off-serial-console}

To disconnect from the serial console:

1. Press `Enter`.
1. Enter the following characters in order: `~.`.

