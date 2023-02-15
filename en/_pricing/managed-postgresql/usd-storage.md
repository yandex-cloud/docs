{% include [local-ssd for Ice Lake only on request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service | Cost of 1 GB per month |
|---------------------------------|---------------------------------------------------------------------|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.pg|month|string }} |
| Non-replicated network storage | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Fast network storage | {{ sku|USD|mdb.cluster.network-nvme.pg|month|string }} |
| Fast local storage | {{ sku|USD|mdb.cluster.local-nvme.pg|month|string }} |
| Backups beyond the storage size | $0.032594 |
