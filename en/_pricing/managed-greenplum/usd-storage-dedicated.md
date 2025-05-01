| Service | {{ compute-name }} price,<br>without VAT | MDB price,<br>without VAT | Total price,<br>without VAT |
|---------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| Network HDD storage | - | {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }} |
| Non-replicated SSD storage | - | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.greenplum|month|string }} |
| Network SSD storage | - | {{ sku|USD|mdb.cluster.network-nvme.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.greenplum|month|string }} |
| High-performance SSD storage | - | {{ sku|USD|mdb.cluster.network-ssd-io-m3.greenplum|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-io-m3.greenplum|month|string }} |
| Local SSD storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.greenplum.dedicated|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|string }} |
| Backups beyond the storage size | - | $0.017280 | $0.017280 |
