| | Disk snapshots in {{ compute-name }} | {{ backup-name }} |
| --- | --- | --- |
| **Granularity** | Disk | VMs with all disks.<br>We also plan to add copying applications to VMs. |
| **Disk types** | Network SSDs and HDDs | Any:<br>Network SSDs and HDDs<br>Non-replicated disks<br>Local disks on [dedicated hosts](../compute/concepts/dedicated-host.md) |
| **Application awareness** | No | To be implemented |
| **Pricing** | Per disk | Per VM |
| **Required VM status** | You can create a [snapshot](../compute/concepts/snapshot.md) on stopped or running VMs. | You can only create a backup on a running VM with the [{{ backup-name }} agent](../backup/concepts/agent.md) installed. |