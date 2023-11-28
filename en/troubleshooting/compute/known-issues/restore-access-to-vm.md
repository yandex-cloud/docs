# Recovering access to a VM with a lost SSH key



## Issue description {#issue-description}

* The SSH key used to connect to the VM instance is lost.

## Solution {#issue-resolution}

There are several options to recover a VM instance to which you have lost SSH keys.

If a password was not set for the Linux user, you can create a [disk snapshot](../../../compute/operations/disk-control/create-snapshot.md) from the problematic VM instance and then create a new VM from this snapshot, selecting "**+Add disk**" - "**Snapshot**" on the VM creation page.

If the above method did not solve the issue, complete these steps:

1. Create a new disk from the snapshot of the problematic VM.
2. Connect it as an additional disk to another VM.
3. Change the root directory using chroot.
4. Modify configuration files that affect VM accessibility, for example, set a new password using the `sudo passwd $USERNAME` command, where `$USERNAME` is the name of the Linux user for whom you need to set a password.
5. Detach the additional disk from the auxiliary VM and create a new VM from it using the modified disk as the boot disk.

If you previously set a password for the Linux user inside the VM, you can use the serial console.
Follow the [guide in the documentation](../../../compute/operations/serial-console/index.md) for setup.
After enabling the serial console, connect to the VM instance. We recommend [connecting from the CLI](../../../compute/operations/serial-console/connect-cli.md).