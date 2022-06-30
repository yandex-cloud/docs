| Service                         | Cost of 1 GB per month |
| ----- | ----- |
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|string }}               |
| Non-replicated network storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.greenplum|month|string }}              |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|string }}                |
| Backups beyond the storage size | ₽1.92 |

