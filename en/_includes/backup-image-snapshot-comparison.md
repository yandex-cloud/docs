| | Disk snapshots in {{ compute-name }} | {{ backup-name }} |
| --- | --- | --- |
| **Granularity** | Disk | VMs with all disks<br>Individual files and folders<br>VM applications (coming soon). |
| **Disk types** | All types except local disks on [dedicated hosts](../compute/concepts/dedicated-host.md).<br>The snapshot creation time is not fixed for [non-replicated disks and SSD-IO](../compute/concepts/disk.md#nr-disks). | All disk types |
| [**LVM**](../backup/concepts/backup.md#lvm) | Not supported | Supported |
| **Recovery** | Full recovery to a new VM only. | To a new or existing VM.<br>Partial recovery of individual files. |
| **Consistency** | Atomic snapshot of each disk. | Atomic snapshot of the entire VM, individual folders, or files. |
| **Backup integrity checks** | Not supported | Supported |
| **Agent installation** | Not required | Required, installed automatically when connecting a VM to the service. |
| **Optimization** | Full backups only.<br>Data compression is not supported. | Full or incremental backups.<br>Multiple data compression levels with an option to opt out. |
| **Pricing** | Per GB of stored backups. | Per GB of stored backups and VM connection fee. |
| **Required VM status** | You can create a [snapshot](../compute/concepts/snapshot.md) on both stopped or running VMs. | You can only create a snapshot on a running VM with the [{{ backup-name }} agent](../backup/concepts/agent.md) installed. |