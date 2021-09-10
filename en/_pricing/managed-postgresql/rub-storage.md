{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |
|---------------------------------|---------------------------------------------------------------------|
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.pg|month|string }}               |
| Non-replicated network storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.pg|month|string }}              |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.pg|month|string }}                |
| Backups beyond the storage size | ₽2.5424                                                             |
