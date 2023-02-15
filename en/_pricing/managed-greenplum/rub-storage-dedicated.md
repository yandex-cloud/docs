| Service | Cost {{ compute-name }} | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|string }} | {{ sku|RUB|mdb.cluster.network-hdd.greenplum|month|string }} |
| Non-replicated SSD storage | - | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} |
| SSD network storage | - | {{ sku|RUB|mdb.cluster.network-nvme.greenplum|month|string }} | {{ sku|RUB|mdb.cluster.network-nvme.greenplum|month|string }} |
| Local SSD storage | {{ sku|RUB|compute.hostgroup.localssd.v1|month|string }} | {{ sku|RUB|mdb.cluster.local-nvme.greenplum.dedicated|month|string }} | {{ sku|RUB|mdb.cluster.local-nvme.greenplum|month|string }} |
| Backups beyond the storage size | - | ₽1.9200 | ₽1.9200 |
