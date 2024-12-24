> 720 × {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.mongodb.v3.ram|number }}) %} + 3 × (100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }}) = {% calc [currency=USD] 720 × (3 × (2 × {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.mongodb.v3.ram|number }})) + 3 × (100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }}) %}
>
> Total: {% calc [currency=USD] 720 × (3 × (2 × {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.mongodb.v3.ram|number }})) + 3 × (100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.mongodb.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.mongodb.v3.ram|number }}) %}, cost of operation of {{ MG }} hosts per hour.
* 3: Number of {{ MG }} hosts.
* 100: Amount of network HDD storage (in GB).
* {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }}: Cost of using 1 GB of network HDD storage per month.