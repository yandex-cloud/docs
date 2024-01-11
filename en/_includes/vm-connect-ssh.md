The recommended method for connecting to a [VM](../compute/concepts/vm.md) over SSH is based on using a key pair: the public key is placed on the VM, while the private one is stored on the user's device. Connecting with a key pair is more secure than doing so with a username and password.

{% include [vm-connect-ssh-linux-note](vm-connect-ssh-linux-note.md) %}

## Creating an SSH key pair {#creating-ssh-keys}

{% include [vm-ssh-prepare-key](vm-ssh-prepare-key.md) %}

## Connecting to a VM over SSH {#vm-connect}

You can connect to a VM over SSH once it is started (i.e., has the `RUNNING` status). You can use the `ssh` utility in Linux or macOS, or [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) in Windows.

To connect, specify the VM address. This can be either its [IP address](../vpc/concepts/address.md) or [FQDN](../vpc/concepts/address.md#fqdn). You can also connect from another {{ yandex-cloud }} using FQDN if this VM is connected to the same [virtual network](../vpc/concepts/network.md#network). You can find out the IP address in the [management console]({{ link-console-main }}) by going to the **{{ ui-key.yacloud.compute.instance.overview.section_network }}** section on the VM's page.

## Connecting to a VM via OS Login {#os-login-connect}

{% include notitle [preview](./note-preview-by-request.md) %}

[OS Login](../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To access a VM via OS Login, [enable](../organization/operations/os-login-access.md) OS Login access at the organization level.

To use OS Login to access a VM, users must have the `compute.osLogin` or `compute.osAdminLogin` role and the VM must support OS Login at the OS level. You can [create](../compute/operations/vm-connect/os-login-create-vm.md) a new VM with OS Login support or [set up](../compute/operations/vm-connect/enable-os-login.md) access via OS Login for an existing VM.

To connect to a VM using OS Login, specify the VM name or ID.

Please note that you cannot use an [SSH key pair](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to connect to VMs with OS Login access enabled.