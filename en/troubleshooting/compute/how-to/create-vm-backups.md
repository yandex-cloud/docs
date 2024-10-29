# How to back up a VM with rollback support


## Scenario description {#case-description}

You need to create a backup of the VM instance that allows for a rollback.

## Solution {#case-resolution}

You can [schedule creation of disk snapshots](../../../compute/operations/snapshot-control/create-schedule) but cannot use a disk snapshot to roll back changes to your VM instance. For this, you need to create a new VM from the snapshot. Read how to do this [here](../../../compute/operations/vm-create/create-from-snapshots).

We also recommend {{ backup-full-name }}: it can back up VM instances on a schedule. Currently, we support backups on VM instances running Ubuntu and CentOS. You can read more about this in our [documentation](../../../backup/concepts/).