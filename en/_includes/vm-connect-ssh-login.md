[{{ oslogin }}](../organization/concepts/os-login.md) is used to provide users with SSH access to VMs using {{ iam-short-name }}. To access a VM via {{ oslogin }}, [enable](../organization/operations/os-login-access.md) {{ oslogin }} access at the organization level.

To connect to a VM via {{ oslogin }}, users must have the `compute.osLogin` or `compute.osAdminLogin` role and the VM must support {{ oslogin }} at the OS level. You can [create](../compute/operations/vm-connect/os-login-create-vm.md) a new VM with {{ oslogin }} support or [set up](../compute/operations/vm-connect/enable-os-login.md) access via {{ oslogin }} for an existing VM.

To connect to a VM via {{ oslogin }}, specify the VM name or ID.

If a VM has {{ oslogin }} access enabled, you cannot use a standard [SSH](../compute/operations/vm-connect/ssh.md#vm-connect) client to connect to that VM with an SSH key.