| Service                                              | Cost of 1 GB per month                                    |
| ----- | ----- |
| Storage based on non-replicated SSD disks            | ₸44.00                                                    |
| Storage based on network SSD disks                   | {{ sku|KZT|mdb.cluster.network-nvme.redis|month|string }} |
| Storage based on local SSD disks                     | ₸65.05                                                    |
| Backup over storage size                             | ₸9.60                                                     |

{% include [storage-limitations-mrd](../../_includes/mdb/mrd/storage-limitations-note.md) %}
