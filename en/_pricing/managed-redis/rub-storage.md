| Service                                              | Cost of 1 GB per month                                    |
| ----- | ----- |
| Storage based on non-replicated SSD disks            | ₽8.80                                                     |
| Storage based on network SSD disks                   | {{ sku|RUB|mdb.cluster.network-nvme.redis|month|string }} |
| Storage based on local SSD disks                     | ₽13.01                                                    |
| Backup over storage size                             | ₽1.92                                                     |

{% include [storage-limitations-mrd](../../_includes/mdb/mrd/storage-limitations-note.md) %}
