{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                 | |
|---------------------------------|------------------------------------------------------------------------|---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** | |
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }}               | ₽3.20 |
| Non-replicated network storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | ₽8.80 |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }}              | ₽13.00 |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }}                | ₽13.00 |
| Backups beyond the storage size | ₽2.5424                                                                | ₽1.92 |
