{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              | |
|----------------|---------------------------------------------------------|---- |
| | **Up until April 12, 2022** | **Starting  April 13, 2022** |
| Standard network storage        | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}               | ₸19.20 |
| Non-replicated network storage  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} | ₸ ? |
| Fast network storage            | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}              | ₸78.06 |
| Fast local storage              | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}                | ₸78.06 |
| Hybrid storage cold data and backups  | {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }} | ₸ ? |
| Local and network storage backups size | ₸15.2544                                          | ₸11.52 |
