| Service | Cost {{ compute-name }} | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }} | {{ sku|KZT|mdb.cluster.network-hdd.greenplum|month|string }} |
| Non-replicated SSD storage | - | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} |
| SSD network storage | - | {{ sku|KZT|mdb.cluster.network-nvme.greenplum|month|string }} | {{ sku|KZT|mdb.cluster.network-nvme.greenplum|month|string }} |
| Local SSD storage | {{ sku|KZT|compute.hostgroup.localssd.v1|month|string }} | {{ sku|KZT|mdb.cluster.local-nvme.greenplum.dedicated|month|string }} | {{ sku|KZT|mdb.cluster.local-nvme.greenplum|month|string }} |
| Backups beyond the storage size | - | ₸9.6000 | ₸9.6000 |
