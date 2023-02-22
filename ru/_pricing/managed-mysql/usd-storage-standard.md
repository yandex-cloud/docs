| Service                         | Cost of 1 GB per month                                                 |
|---------------------------------|------------------------------------------------------------------------|
| Standard network storage        | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }}               |
| Non-replicated network storage  | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Fast network storage            | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }}              |
| Fast local storage              | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }}                |
| Backups beyond the storage size | $0.032594                                                              |
