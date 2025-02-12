{% note warning %}

To monitor the migration progress and avoid potential issues, use [disk snapshots](../../compute/operations/disk-control/create-snapshot.md) or backups from [{{ backup-name }}](../../backup/operations/backup-vm/create.md). This way, you can decide when to shut down your VM in the source availability zone and when to make it appear in the target availability zone. You can keep the VM in the source availability zone running until you make sure the VM you created from the snapshot in the new zone works correctly. You can read more about the relevant best practices in [{#T}](../../overview/concepts/zone-migration.md).

Currently, you can use the `relocate` command to migrate VMs and disks only to the `{{ region-id }}-d` zone from any other zone.

{% endnote %}