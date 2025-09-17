| Service | {{ compute-name }} price,<br>without VAT | MDB price,<br>without VAT | Total price,<br>without VAT |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Network HDD storage | − | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | − | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | − | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} |
| High-performance SSD storage | − | {{ sku|USD|mdb.cluster.network-ssd-io-m3.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-io-m3.mysql|month|string }} |
| Local SSD storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql.dedicated|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | {{ sku|USD|mdb.cluster.mysql.backup|month|string }} | {{ sku|USD|mdb.cluster.mysql.backup|month|string }} |
