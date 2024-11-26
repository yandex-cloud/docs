| Service | Price of 1 GB per month |
|-------------------------------------------------------|------------------------------------------------------------:|
| Network HDD storage | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }} |
| Non-replicated SSD storage^*^ | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }} |
| Network SSD storage | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| High-performance SSD storage | {{ sku|USD|mdb.cluster.network-ssd-io-m3.mongodb|month|string }} |
| Local SSD storage^*^ | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }} |
| Backups beyond the storage size | {{ sku|USD|mdb.cluster.mongodb.backup|month|string }} |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
