{% include [local-ssd for Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Service                  | Rate for 1 GB per month                                     |
|--------------------------|-------------------------------------------------------------|
| Fast network storage     | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| Backup over storage size | $0.032594                                                   |
