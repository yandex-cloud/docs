{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |  | 
| ----- | ----- | ---- |
| | **Up until April 12, 2022** | **Starting  April 13, 2022** |
| HDD network storage                        | {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }}               | ₽3.20 |
| Non-replicated SSD storage                 | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} | ₽8.80 |
| SSD network storage                        | {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }}              | ₽13.01 |
| Local SSD storage                          | {{ sku|RUB|mdb.cluster.local-nvme.ch|month|string }}                | ₽13.01 |
| Hybrid storage cold data and its backups   | {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} | ₽2.01 |
| Local and network storage backups          | ₽2.5424                                                      | ₽1.92 |
