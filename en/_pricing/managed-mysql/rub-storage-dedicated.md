{% if audience != "draft" %}

| Service | {{ compute-name }}<br/>cost | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | - | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | - | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }} |
| Local SSD storage | {{ sku|RUB|compute.hostgroup.localssd.v1|month|string }} | ₽4.2100 | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | ₽1.9200 | ₽1.9200 |

{% else %}

| Service | {{ compute-name }}<br/>cost | MDB cost | Total cost |
|-----------------------------------------|---------------------------------------------------------:|---------------------------------------------------------------------------:|---------------------------------------------------------------------------:|
| HDD network storage | - | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }} |
| Non-replicated SSD storage | - | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| SSD network storage | - | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }} |
| Local SSD storage | {{ sku|RUB|compute.hostgroup.localssd.v1|month|string }} | {{ sku|RUB|mdb.cluster.local-nvme.mysql.dedicated|month|string }} | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }} |
| Backups beyond the storage size | - | ₽1.9200 | ₽1.9200 |

{% endif %}
