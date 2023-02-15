{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}


| Service | Cost of 1 GB per month |
| ----- | ----- |
| HDD network storage | {{ sku|KZT|mdb.cluster.network-hdd.pg|month|string }} |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| SSD network storage | {{ sku|KZT|mdb.cluster.network-nvme.pg|month|string }} |
| Local SSD storage | {{ sku|KZT|mdb.cluster.local-nvme.pg|month|string }} |
| Backups beyond the storage size | ₸9.60 |
