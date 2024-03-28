[OS Login](../organization/concepts/os-login.md) is used to provide users with SSH access to VMs through {{ iam-short-name }}. To access a VM via OS Login, [enable](../organization/operations/os-login-access.md) OS Login access at the organization level.

To connect to a VM via OS Login , users must have the `compute.osLogin` or `compute.osAdminLogin` role and the VM must support OS Login at the OS level. You can [create](../compute/operations/vm-connect/os-login-create-vm.md) a new virtual machine with OS Login support or [configure](../compute/operations/vm-connect/enable-os-login.md) access via OS Login for an existing VM.

To connect to a virtual machine via OS Login, specify the VM name or ID.

You cannot use an SSH key to connect to VMs with OS Login access enabled over a standard [SSH](../compute/operations/vm-connect/ssh.md#vm-connect) client.