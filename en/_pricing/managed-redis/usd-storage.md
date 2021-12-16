| Service                                                 | Cost of 1 GB per month, without VAT                      |
|---------------------------------------------------------|-----------------------------------------------------------|
| Storage based on non-replicated SSD disks               | $0.070512                                                 |
| Storage based on network SSD disks                      | {{ sku|USD|mdb.cluster.network-nvme.redis|month|string }} |
| Storage based on local SSD disks                        | $0.104303                                                 |
| Backup over storage size                                | $0.032594                                                 |
