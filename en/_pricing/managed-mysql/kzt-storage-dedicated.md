{% if audience != "draft" %}

| Service | {{ compute-name }}<br/>cost | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | - | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | - | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }} |
| Local SSD storage | {{ sku|KZT|compute.hostgroup.localssd.v1|month|string }} | ₸21.0500 | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | ₸9.6000 | ₸9.6000 |

{% else %}

| Service | {{ compute-name }}<br/>cost | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | - | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | - | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }} |
| Local SSD storage | {{ sku|KZT|compute.hostgroup.localssd.v1|month|string }} | {{ sku|KZT|mdb.cluster.local-nvme.mysql.dedicated|month|string }} | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | ₸9.6000 | ₸9.6000 |

{% endif %}
