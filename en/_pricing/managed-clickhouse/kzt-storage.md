{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              | |
|----------------|---------------------------------------------------------|---- |
| | **Up until April 12, 2022** | **Starting  April 13, 2022** |
| HDD network storage                       | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}               | ₸19.20 |
| Non-replicated SSD storage                | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} | ₸ ? |
| SSD network storage                       | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}              | ₸78.06 |
| Local SSD storage                         | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}                | ₸78.06 |
| Hybrid storage cold data and its backups  | {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} | ₸ ? |
| Local and network storage backups         | ₸15.2544                                          | ₸11.52 |
