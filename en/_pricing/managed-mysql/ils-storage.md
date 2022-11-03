| Service                         | Cost of 1 GB per month                                                 |
|---------------------------------|------------------------------------------------------------------------|
| HDD network storage             | {{ sku|ILS|mdb.cluster.network-hdd.mysql|month|string }}               |
| Non-replicated SSD storage      | {{ sku|ILS|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage             | {{ sku|ILS|mdb.cluster.network-nvme.mysql|month|string }}              |
