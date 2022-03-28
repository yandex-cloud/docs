{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |  | 
| ----- | ----- | ---- |
| | **Up until April 12, 2022** | **Starting  April 13, 2022** |
| HDD network storage        | {{ sku|RUB|mdb.cluster.network-hdd.pg|month|string }}               | ₽3.20 |
| Non-replicated SSD storage | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} | ₽8.80 |
| SSD network storage        | {{ sku|RUB|mdb.cluster.network-nvme.pg|month|string }}              | ₽13.01 |
| Local SSD storage          | {{ sku|RUB|mdb.cluster.local-nvme.pg|month|string }}                | ₽13.01 |
| Backups beyond the storage size | ₽2.5424                                                             | ₽1.92 |
