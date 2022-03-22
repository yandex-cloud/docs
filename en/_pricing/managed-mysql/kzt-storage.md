{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                 | |
|---------------------------------|------------------------------------------------------------------------|---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** | |
| Standard network storage        | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               | |
| Non-replicated network storage  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | |
| Fast network storage            | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              | |
| Fast local storage              | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                | |
| Backups beyond the storage size | ₸15.2544                                                               | |
