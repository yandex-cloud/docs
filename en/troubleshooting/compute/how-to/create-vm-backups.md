# How to back up a VM with rollback support



## Case description {#case-description}

You need to back up a VM with rollback support.

## Solution {#case-resolution}

You can [schedule creation of disk snapshots](../../../compute/operations/snapshot-control/create-schedule.md); however, you cannot use a disk snapshot to roll back changes to your VM. For this, you need to create a new VM from the snapshot. You can learn how to do this [here](../../../compute/operations/vm-create/create-from-snapshots.md).

We also recommend using {{ backup-full-name }}: it can back up VMs on schedule. Currently, we support backing up Ubuntu and CentOS VMs. For more information, see [this guide](../../../backup/concepts/backup.md).