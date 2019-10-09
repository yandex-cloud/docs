# Backups

Data in images, snapshots, and disks that aren't connected to instances is stored securely and replicated within the Yandex.Cloud infrastructure.

To back up the data from disks attached to an instance, create [snapshots](../operations/disk-control/create-snapshot.md) of the disks from time to time.

You can restore an instance from a snapshot in the following ways:

* Create a new disk from a snapshot, then [attach the created disk](../operations/vm-control/vm-attach-disk.md) to an instance.
* Create a new instance [from a set of snapshots](../operations/vm-create/create-from-snapshots.md). In the operation parameters, you can specify snapshots as both boot and regular disks.

