{% note warning %}

To monitor the progress of migration and avoid possible issues during it, use [disk snapshots](../../compute/operations/disk-control/create-snapshot.md) or backups from [{{ backup-name }}](../../backup/operations/backup-vm/create.md) for migration. In this way, you yourself determine when to shut down your VM in the source availability zone and when to make it appear in the target availability zone. The VM in the source availability zone may continue to run until you make sure that the VM you created from a snapshot works properly in the new availability zone. For detailed recommendations, see [{#T}](../../overview/concepts/zone-migration.md).

Currently, you can use the `relocate` command to migrate VMs and disks only to the `{{ region-id }}-d` zone from any other zone.

{% endnote %}