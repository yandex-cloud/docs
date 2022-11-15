# {{ backup-full-name }} overview

{{ backup-full-name }} is a service for creating backups and restoring {{ yandex-cloud }} resources and their data. At the [Preview stage](../../overview/concepts/launch-stages.md), you can back up and restore [{{ compute-name }} VMs](../../compute/concepts/vm.md) running Ubuntu and CentOS.

VM backups are created by special agent software. To have an agent installed on a VM automatically, select the respective option when creating your VM.

Created VM backups are application-consistent: both data stored on disks and intermediate data of running applications (in-memory data and active reads and writes to disks) are saved. This approach lets you resume applications that were running at backup creation immediately after restoring your VM. This is important for VMs that are part of data storage systems, such as when a DBMS is running on the VM.

{{ backup-name }} can create [full and incremental backups](backup.md#types). A full backup stores complete data of a VM. This is reliable, but full backups take a lot of space and restoring VMs from them is more time-consuming. Incremental backups only contain data that differs from that of previous VM backups. This lets you save space and time for VM recovery. However, if any backup in the chain is damaged, you won't be able to restore your VM.

Settings for creating and storing backups are specified in a [backup policy](policy.md), a {{ backup-name }} resource.

## Comparison with disk snapshots in {{ compute-name }} {#snapshot-comparison}

| | Disk snapshots in {{ compute-name }} | {{ backup-name }} |
| --- | --- | --- |
| **Principle** | _Crash-consistent:_<br>Only data written to disk before creating a backup is saved. | _Application-consistent:_<br>First all active reads and writes are terminated and then all disk and in-memory data is saved. |
| **Granularity** | Disk | VMs with all disks.<br>We also plan to add support for VM application backups. |
| **Disk types** | Network SSD and HDD | Any:<br>Network SSD and HDD,<br>non-replicated disks,<br>and local disks on [dedicated hosts](../../compute/concepts/dedicated-host.md) |
| **Application awareness** | No | To be implemented |
| **Pricing** | Per disk | Per VM |


## Backup provider {#providers}

When getting started with {{ backup-name }}, enable a connection to a backup provider. Currently, the service only has one provider available: Cyberprotect.

The minimum folder role required for activating a provider connection is `backup.editor` (see the [role description](../security/index.md#backup-editor)).
