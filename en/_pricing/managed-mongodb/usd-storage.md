| Service | Price per GB, per month<br>before May 1, 2025,<br>without VAT | Price per GB, per month<br>starting May 1, 2025,<br>without |
|---|---:|---:|
| Network HDD storage                    | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }}  | {% calc [currency=USD] {{ sku|RUB|mdb.cluster.network-hdd.mongodb|month|number }} × 1.08 / 120 %} |
| Non-replicated SSD storage^*^ | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }}  | {% calc [currency=USD] {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mongodb|month|number }} × 1.08 / 120 %} |
| Network SSD storage                    | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} | {% calc [currency=USD] {{ sku|RUB|mdb.cluster.network-nvme.mongodb|month|number }} × 1.08 / 120 %} |
| High-performance SSD storage | {{ sku|USD|mdb.cluster.network-ssd-io-m3.mongodb|month|string }} | {% calc [currency=USD] {{ sku|RUB|mdb.cluster.network-ssd-io-m3.mongodb|month|number }} × 1.08 / 120 %} |
| Local SSD storage^*^          | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }}   |  {% calc [currency=USD] {{ sku|RUB|mdb.cluster.local-nvme.mongodb|month|number }} × 1.08 / 120 %} |
| Backups beyond the storage size                              | {{ sku|USD|mdb.cluster.mongodb.backup|month|string }} | {% calc [currency=USD] {{ sku|RUB|mdb.cluster.mongodb.backup|month|number }} × 1.08 / 120 %} |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
