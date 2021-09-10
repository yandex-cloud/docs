{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                  | Rate for 1 GB per month                                     |
|--------------------------|-------------------------------------------------------------|
| Standard network storage | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }}  |
| Fast network storage     | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| Fast local storage       | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }}   |
| Backup over storage size | $0.032594                                                   |
