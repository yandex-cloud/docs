
| Service | {{ compute-name }}<br/>cost | MDB cost | Total cost |
|---------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| Standard network storage | - | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated network storage | - | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Fast network storage | - | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }} |
| Fast local storage | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | $0.053974 | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | $0.032595 | $0.032595 |

