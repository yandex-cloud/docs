{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| Standard network storage | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated network storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Fast network storage | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }} |
| Fast local storage | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | ₽2.5424 |

