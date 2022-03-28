{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                         | Cost of 1 GB per month                                                 | |
|---------------------------------|------------------------------------------------------------------------|---|
| | **Up until April 12, 2022** | **Starting April 13, 2022** | |
| HDD network storage             | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               | |
| Non-replicated SSD storage      | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | |
| SSD network storage             | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              | |
| Local SSD storage               | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                | |
| Backups beyond the storage size | ₸15.2544                                                               | |
