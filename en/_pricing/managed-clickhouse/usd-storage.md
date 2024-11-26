| Service | Price of 1 GB per month |
----- | -----
| Network HDD storage | {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }} |
| Non-replicated SSD storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Network SSD storage | {{ sku|USD|mdb.cluster.network-nvme.ch|month|string }} |
| High-performance SSD storage | {{ sku|USD|mdb.cluster.network-ssd-io-m3.ch|month|string }} |
| Local SSD storage | {{ sku|USD|mdb.cluster.local-nvme.ch|month|string }} |
| Hybrid cold data storage and backups | {{ sku|USD|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
| Backups beyond the storage size | {{ sku|USD|mdb.cluster.clickhouse.backup|month|string }} |
