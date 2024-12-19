# {{ backup-full-name }} overview

{{ backup-full-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data. Backup and recovery are available for [{{ compute-name }} VMs](../../compute/concepts/vm.md) created from [supported {{ marketplace-name }} images](vm-connection.md#os) as well as for [{{ baremetal-full-name }} servers](../../baremetal/concepts/servers.md) with [supported operating systems](vm-connection.md#self-install).

{% include [vm-and-bms-backup-incompatibility](../../_includes/backup/vm-and-bms-backup-incompatibility.md) %}

{% include [baremetal-note-extended](../../_includes/backup/baremetal-note-extended.md) %}

VM and {{ baremetal-name }} server backups are application-consistent: they save not only the data on disks but also the data already submitted but not yet fully written to the disk. This allows you to resume applications that were running at the time of the backup directly after recovering a VM or {{ baremetal-name }} server from the backup. This is important for VMs and servers forming a part of data storage systems, such as when a DBMS is running on the VM or {{ baremetal-name }} server.

{{ backup-name }} can create [full and incremental backups](backup.md#types). A full backup stores the whole of the VM or {{ baremetal-name }} server data: the recovery is faster than from an incremental backup, yet such backups take up more storage space and take longer to be created. An incremental backup only stores data that is different from the previous backup. It is faster to create and takes up less space. However, recovery from an incremental backup takes longer than from a full one. If you know your VM or {{ baremetal-name }} server has changed a lot since the previous backup, it is better to make a full backup.

With {{ backup-name }}, you can also restore individual files and directories from a backup to any VM connected to the service. For more information, see [File-by-file recovery](backup.md#file-by-file). File-by-file recovery to {{ baremetal-name }} servers is currently not available.

To enable backups for a VM or {{ baremetal-name }} server, you first need to have it connected and configured. For more information, see [{#T}](vm-connection.md).

{% include [vm-running](../../_includes/backup/vm-running.md) %}

Once you have connected your VM or {{ baremetal-name }} server to {{ backup-name }} and configured it, you need to link it to a [backup policy](policy.md), i.e., a {{ backup-name }} resource. The policy includes settings for creating and storing backups. You can link your VMs and {{ baremetal-name }} servers to default policies or create custom policies.

{{ backup-name }} automatically delivers [metrics](../metrics.md) on the number of protected VMs and {{ baremetal-name }} servers, as well as storage space used by backups, to [{{ monitoring-full-name }}](../../monitoring/index.yaml).

The service has two types of restrictions: [quotas and limits](limits.md).

## Comparison with VM disk snapshots in {{ compute-name }} {#snapshot-comparison}

{% include [backup-image-snapshot-comparison](../../_includes/backup-image-snapshot-comparison.md) %}

## Service activation and backup provider {#providers}

{{ backup-name }} is enabled by a _backup provider_. Currently, the service only has one provider available: Cyberprotect.

To get started, you need to activate the service, i.e., to connect to a backup provider. You can [activate](../operations/activate-service.md) the service directly or [connect](vm-connection.md) your first VM or {{ baremetal-name }} server to {{ backup-name }}, which activates the service automatically.

The minimum folder role required to activate the service is `backup.editor` (see [its description](../security/index.md#backup-editor) for details).

{% include [default-policies](../../_includes/backup/default-policies.md) %}