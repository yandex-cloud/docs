| Service | Cost of 1 GB per month |
| ----- | ---- |
| HDD network storage | {{ sku|RUB|mdb.cluster.network-hdd.mongodb|month|string }} |
| Non-replicated SSD storage<sup>*</sup> | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }} |
| SSD network storage | {{ sku|RUB|mdb.cluster.network-nvme.mongodb|month|string }} |
| Local SSD storage<sup>*</sup> | {{ sku|RUB|mdb.cluster.local-nvme.mongodb|month|string }} |
| Backups beyond the storage size | ₽1.9200 |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
