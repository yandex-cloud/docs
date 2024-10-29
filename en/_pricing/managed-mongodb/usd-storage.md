| Service | Price of 1 GB per month |
|-------------------------------------------------------|------------------------------------------------------------:|
| Network HDD storage | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }} |
| Non-replicated SSD storage^*^ | $0.070512 |
| Network SSD storage | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| High-performance SSD storage | $0.174240 |
| Local SSD storage^*^ | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }} |
| Backups beyond the storage size | $0.015360 |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
