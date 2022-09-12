| Service                                              | Cost of 1 GB per month                                                 |
| ----- | ----- |
| Storage based on non-replicated SSD disks            | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.redis|month|string }} |
| Storage based on network SSD disks                   | {{ sku|KZT|mdb.cluster.network-nvme.redis|month|string }}              |
| Storage based on local SSD disks                     | {{ sku|KZT|mdb.cluster.local-nvme.redis|month|string }}                |
| Backup over storage size                             | ₸9.60                                                                  |

{% include [storage-limitations-mrd](../../_includes/mdb/mrd/storage-limitations-note.md) %}