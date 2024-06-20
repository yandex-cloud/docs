| Service | Cost of 1 GB per month |
|---------------------------------|--------------------------------------------------------------------:|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.pg|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.pg|month|string }} |
| Network SSD storage with 3 replicas | $0.174240 |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.pg|month|string }} |
| Backups beyond the storage size | {{ sku|USD|mdb.cluster.pg.backup|month|string }} |
