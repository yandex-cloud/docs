| Service                                               | Cost of 1 GB per month                                      |
|-------------------------------------------------------|-------------------------------------------------------------|
| Storage based on network HDD disks                    | {{ sku|USD|mdb.cluster.network-hdd.mongodb|month|string }}  |
| Storage based on non-replicated SSD disks             | $0.070512                                                   |
| Storage based on network SSD disks                    | {{ sku|USD|mdb.cluster.network-nvme.mongodb|month|string }} |
| Storage based on local SSD disks                      | {{ sku|USD|mdb.cluster.local-nvme.mongodb|month|string }}   |
| Backup over storage size                              | $0.032594                                                   |
