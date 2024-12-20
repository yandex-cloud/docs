If you set a user password, [configure](../../compute/operations/serial-console/index.md) the VM serial console and connect to it. We recommend [connecting through the CLI](../../compute/operations/serial-console/connect-cli.md).

If no user password is set, [take](../../compute/operations/disk-control/create-snapshot.md) a snapshot of the VM's disk and [create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM from the snapshot.

If the problem persists:

1. [Create](../../compute/operations/disk-create/from-snapshot.md) a new disk from the VM snapshot.
1. [Attach](../../compute/operations/vm-control/vm-attach-disk.md) it as a secondary disk to a different VM.
1. Change the root directory with `chroot`.
1. Edit the configuration files that make the VM unavailable.
1. [Detach](../../compute/operations/vm-control/vm-detach-disk.md) the disk from the VM.
1. [Create](../../compute/operations/vm-create/create-from-snapshots.md) a new VM. Under **Image/boot disk selection**, go to the **Custom** tab and select your disk as the boot disk.
1. After restoring access to the VM, do not forget to delete unused resources: [VMs](../../compute/operations/vm-control/vm-delete.md), [disks](../../compute/operations/disk-control/delete.md), and [disk snapshots](../../compute/operations/snapshot-control/delete.md). If you do not delete them, they will remain billable, and {{ yandex-cloud }} will continue to charge for them.