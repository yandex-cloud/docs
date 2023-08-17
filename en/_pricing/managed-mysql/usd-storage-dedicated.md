| Service | Cost {{ compute-name }} | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | - | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | - | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} |
| Local SSD storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql.dedicated|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | $0.024615 | $0.024615 |
