> 720 × {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.redis.v3.ram|number }}) %} + 3 × (100 × {{ sku|USD|mdb.cluster.network-nvme.redis|month|string }}) = {% calc [currency=USD] 720 × (3 × (2 × {{ sku|USD|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.redis.v3.ram|number }})) + 3 × (100 × {{ sku|USD|mdb.cluster.network-nvme.redis|month|number }}) %}
>
> Total: {% calc [currency=USD] 720 × (3 × (2 × {{ sku|USD|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.redis.v3.ram|number }})) + 3 × (100 × {{ sku|USD|mdb.cluster.network-nvme.redis|month|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.redis.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.redis.v3.ram|number }}) %}, cost of operation of {{ RD }} hosts per hour.
* 3: Number of {{ RD }} hosts.
* 100: Amount of network SSD storage (in GB).
* {{ sku|USD|mdb.cluster.network-nvme.redis|month|string }}: Cost of using 1 GB of network SSD storage per month.