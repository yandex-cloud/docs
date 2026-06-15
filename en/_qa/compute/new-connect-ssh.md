If you set a user password, [configure](../../compute/concepts/serial-console.md) the serial console and connect to the VM. We recommend that you [connect](../../compute/operations/serial-console/connect-ssh.md) using the {{ yandex-cloud }} CLI.

If no user password is set, [create](../../compute/operations/disk-control/create-snapshot.md) a snapshot of the VM disk and use it to [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM.

If the issue persists:

1. [Create](../../compute/operations/disk-create/from-snapshot.md) a new disk from the VM snapshot.
1. [Attach](../../compute/operations/vm-control/vm-attach-disk.md) it as a secondary disk to a different VM.
1. Change the root directory with `chroot`.
1. Update the configuration files that affect VM accessibility, e.g., set a new user password using the `sudo passwd <username>` command.
1. [Detach](../../compute/operations/vm-control/vm-detach-disk.md) the disk from the VM.
1. [Create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM. Under **Image/boot disk selection**, go to the **Custom** tab and select your disk as the boot disk.
1. Once you recover access to your VM, make sure to delete the resources you no longer need, such as [VMs](../../compute/operations/vm-control/vm-delete.md), [disks](../../compute/operations/disk-control/delete.md), and [disk snapshots](../../compute/operations/snapshot-control/delete.md). Otherwise, they will remain billable, and {{ yandex-cloud }} will continue to charge you for them.