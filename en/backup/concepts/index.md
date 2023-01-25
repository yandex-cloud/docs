# {{ backup-full-name }} overview

{{ backup-full-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data. At the [Preview stage](../../overview/concepts/launch-stages.md), you can back up and restore [{{ compute-name }} instances](../../compute/concepts/vm.md) running Ubuntu OS.

Created VM backups are application-consistent: both data stored on disks and intermediate data of running applications (in-memory data and active reads and writes to disks) are saved. This approach lets you resume applications that were running at backup creation immediately after restoring your VM. This is important for VMs that are part of data storage systems, such as when a DBMS is running on the VM.

{{ backup-name }} can create [full and incremental backups](backup.md#types). A full backup stores complete data of a VM. This is reliable, but full backups take a lot of space and restoring VMs from them is more time-consuming. Incremental backups only contain data that differs from that of previous VM backups. This lets you save space and time for VM recovery. However, if any backup in the chain is damaged, you won't be able to restore your VM.

To be able to enable backups for your instance, when creating the instance, you need to connect it to the service and configure it. For more information, see [{#T}](vm-connection.md).

Once you have connected your instance to {{ backup-name }} and set it up, you need to link it to a [backup policy](policy.md) that is, to a {{ backup-name }} resource. The policy includes settings for creating and storing backups. You can link your instances to default policies or create custom policies.

The service has restrictions — [quotas and limits](limits.md).

## Comparison with disk snapshots in {{ compute-name }} {#snapshot-comparison}

| | Disk snapshots in {{ compute-name }} | {{ backup-name }} |
| --- | --- | --- |
| **Principle** | _Crash-consistent:_<br>Only data written to disk before creating a backup is saved. | _Application-consistent:_<br>First all active reads and writes are terminated and then all disk and in-memory data is saved. |
| **Granularity** | Disk | VMs with all disks.<br>We also plan to add support for VM application backups. |
| **Disk types** | Network SSD and HDD | Any:<br>Network SSD and HDD,<br>non-replicated disks,<br>and local disks on [dedicated hosts](../../compute/concepts/dedicated-host.md) |
| **Application awareness** | No | To be implemented |
| **Pricing** | Per disk | Per VM |


## Service activation and backup provider {#providers}

{{ backup-name }} is enabled by a _backup provider_. Currently, the service only has one provider available: Cyberprotect.

If you got access to {{ backup-name }}, to get started, you need to activate the service, that is, to connect to a backup provider. You can activate the service directly on its page in the management console (see the [getting started tutorial](../quickstart.md)) or [connect](vm-connection.md) your first VM to {{ backup-name }}: the service will activate automatically in this case.

The minimum folder role required for activating the service is `backup.editor` (see the [role description](../security/index.md#backup-editor)).
