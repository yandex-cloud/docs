{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Service | Cost of 1 GB per month |
| ----------------------------------------- | --------------------------------------------------------------------- |
| Standard network storage | {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }} |
| Non-replicated network storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Fast network storage | {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }} |
| Fast local storage | {{ sku|RUB|mdb.cluster.local-nvme.ch|month|string }} |
| Backups beyond the storage size | ₽2.5424 |
