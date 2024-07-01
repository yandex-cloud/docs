| Service | {{ compute-name }} cost | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| HDD network storage | − | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | − | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | − | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} |
| Network SSD storage with 3 replicas | − | $0.174240 | $0.174240 |
| Local SSD storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql.dedicated|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | $0.015360 | $0.015360 |
