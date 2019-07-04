# Connecting to a VM's serial console via CLI

After [enabling access](index.md), you can connect to the serial console to work with the VM. Enabled access to the serial console is not secure: hackers may get access to your VM. [Disable](disable.md) access after you finish working with the serial console.

## Connecting to the serial console

{% note info %}

How the serial console works depends on the operating system settings. {{ compute-name }} provides a communication channel between the user and the COM port on the VM, but it does not guarantee that the console will work correctly on the operating system.

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

1. Select the `ID` or `NAME` of the VM you need (for example, `first-instance`).

1. Connect to the serial console.

    ```
    $ yc compute connect-to-serial-port \
        --instance-name first-instance \
        --port 2
    ```

    | Parameter | Value |
    | ----- | ----- |
    | `instance-name` | Required parameter. Name of the instance. |
    | `user` | Optional parameter. User name. If this parameter is omitted, the default `yc-user` user will be used. The `yc-user` user is generated automatically when the VM is being created. For more information, see [#T](../vm-create/create-linux-vm.md). |
    | `ssh-key` | Optional parameter. The path to the private key for SSH access will be added to the VM metadata. If this parameter is omitted, the default `yc_serialssh_key`  SSH key will be generated. |

#### Troubleshooting

- If you connect to the serial console and nothing appears on the screen:
    - Press `Enter`.
    - Restart the VM (for virtual machines created before February 22).
- If the system requests user data to provide access to the VM, enter the login and password.

## Disconnecting from the serial console

To disconnect from the serial console:

1. Press `Enter`.
1. Enter the following characters in order: `~.`.
