{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |
|---------------------------------|---------------------------------------------------------------------|
| Standard network storage        | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}               |
| Non-replicated network storage  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Fast network storage            | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}              |
| Fast local storage              | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}                |
| Backups beyond the storage size | ₸15.2544                                                            |
