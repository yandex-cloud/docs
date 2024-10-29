| | Disk snapshots in {{ compute-name }} | {{ backup-name }} |
| --- | --- | --- |
| **Granularity** | Disk | VMs with all disks.<br>We may also add support for VM application backups. |
| **Disk types** | Network SSDs and HDDs | Any:<br>Network SSD and HDD,<br>non-replicated disks,<br>and local disks on [dedicated hosts](../compute/concepts/dedicated-host.md) |
| **Application awareness** | No | To be implemented |
| **Pricing** | Per disk | Per VM |
| **Required VM status** | You can create a [snapshot](../compute/concepts/snapshot.md) on stopped or running VMs. | You can only create a backup on a running VM with an agent installed. |