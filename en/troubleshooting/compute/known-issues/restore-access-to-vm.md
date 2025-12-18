# Restoring access to a VM with a lost SSH key



## Issue description {#issue-description}

You lost the SSH key you used to connect to a VM.

## Solution {#issue-resolution}

There are various options to recover a VM to which you have lost SSH keys.

If your Linux user has no password, you can create a [disk snapshot](../../../compute/operations/disk-control/create-snapshot.md) from the VM in question, and then create a new VM from this snapshot, selecting **{{ ui-key.yacloud.compute.component.instance-storage-dialog.button_add-disk }}** → **{{ ui-key.yacloud.compute.disk.overview.label_snapshot }}** on the VM creation page.

If the above method did not solve the issue, follow these steps:

1. Create a new disk from the snapshot of the VM in question.
1. Attach it as a secondary disk to a different VM.
1. Change the root directory using `chroot`.
1. Modify the configuration files that affect VM accessibility, e.g., set a new password using the `sudo passwd $USERNAME` command, where `$USERNAME` is the name of the Linux user to set a password for.
1. Detach the secondary disk from the auxiliary VM and create a new VM from it using the modified disk as the boot disk.

If you previously set a password for the Linux user on your VM, you can use the serial console. For detailed information, follow [this guide](../../../compute/operations/serial-console/index.md).

After enabling the serial console, connect to the VM in question. We recommend [connecting through the CLI](../../../compute/operations/serial-console/connect-cli.md).