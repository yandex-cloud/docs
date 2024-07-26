| Service | {{ compute-name }} price | MDB price | Total price |
|---------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| Standard network storage | - | {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }} |
| Non-replicated network storage | - | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} |
| Fast network storage | - | {{ sku|USD|mdb.cluster.network-nvme.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.greenplum|month|string }} |
| High-performance SSD storage | - | $0.174240 | $0.174240 |
| Fast local storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.greenplum.dedicated|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|string }} |
| Backups beyond the storage size | - | $0.015360 | $0.015360 |
