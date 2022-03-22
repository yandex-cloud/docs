{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |  | 
| ----- | ----- | ---- |
| | **Up until April 12, 2022** | **Starting  April 13, 2022** |
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.pg|month|string }}               | ₽3.20 |
| Non-replicated network storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} | ₽8.80 |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.pg|month|string }}              | ₽13.01 |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.pg|month|string }}                | ₽13.01 |
| Backups beyond the storage size | ₽2.5424                                                             | ₽1.92 |
