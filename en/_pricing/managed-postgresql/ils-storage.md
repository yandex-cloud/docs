| Service                         | Cost of 1 GB per month                                 |
| ------------------------------- | ------------------------------------------------------ |
| HDD network storage             | {{ sku|ILS|mdb.cluster.network-hdd.pg|month|string }}  |
| Non-replicated SSD storage      | {{ sku|ILS|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| SSD network storage             | {{ sku|ILS|mdb.cluster.network-nvme.pg|month|string }} |
