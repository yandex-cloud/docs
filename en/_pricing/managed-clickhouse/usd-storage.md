| Service | Cost of 1 GB per month |
----- | -----
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.ch|month|string }} |
| Network SSD storage with 3 replicas | $0.174240 |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.ch|month|string }} |
| Hybrid cold data storage and backups | {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
| Backups beyond the storage size | $0.015360 |
