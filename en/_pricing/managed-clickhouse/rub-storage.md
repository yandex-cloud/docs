{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                              |
|---------------------------------|---------------------------------------------------------------------|
| Standard network storage        | {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }}               |
| Non-replicated network storage  | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Fast network storage            | {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }}              |
| Fast local storage              | {{ sku|RUB|mdb.cluster.local-nvme.ch|month|string }}                |
| Hybrid storage cold data and backups  | {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
| Local and network storage backups size | ₽2.5424                                                             |
