{% include [local-ssd for Intel Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
| ----- | ----- |
| HDD network storage | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }} |
| Non-replicated SSD storage | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| SSD network storage | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }} |
| Local SSD storage | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }} |
| Hybrid storage cold data and its backups | {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
| Local and network storage backups | ₸9.60 |
