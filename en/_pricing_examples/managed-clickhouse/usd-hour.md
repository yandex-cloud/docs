Cost calculation for {{ CH }} hosts:

> 3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|string }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|string }}) = {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }}) %}, cost of operation of {{ CH }} hosts per hour.

Where:
* 3: Number of {{ CH }} hosts.
* 2: Number of vCPUs.
* {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|string }}: Cost of using 100% vCPU per hour.
* 8: Amount of RAM per {{ CH }} host (in GB).
* {{ sku|USD|mdb.cluster.clickhouse.v3.ram|string }}: Cost of using 1 GB of RAM at 100% vCPU per hour.

Calculating the cost of storage for {{ CH }} hosts:

> 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }} = {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }} %}, cost of using the cluster for 30 days.

Where:
* 3: Number of {{ CH }} hosts.
* 100: Amount of network HDD storage (in GB).
* {{ sku|USD|mdb.cluster.network-hdd.ch|month|string }}: Cost of using 1 GB of network HDD storage per month.

Cost calculation for {{ ZK }} hosts:

> 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|string }}) = {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}, cost of operation of {{ ZK }} hosts per hour.

Where:
* 3: Number of {{ ZK }} hosts.
* 2: Number of vCPUs.
* {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|string }}: Cost of using 50% vCPU per hour.
* 4: Amount of RAM per {{ ZK }} host (in GB).
* {{ sku|USD|mdb.zk.clickhouse.v3.ram|string }}: Cost of using 1 GB of RAM at 50% vCPU per hour.

Calculating the cost of storage for {{ ZK }} hosts:

> 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|string }} = {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }} %}, cost of storage for {{ ZK }} hosts.

Where:
* 3: Number of {{ ZK }} hosts.
* 10: Amount of SSD network storage (in GB).
* {{ sku|USD|mdb.cluster.network-nvme.ch|month|string }}: Cost of using 1 GB of network SSD storage per month.

Total cost calculation:

> 720 × ({% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }}) %} + {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}) + {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }} %} + {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }} %} = {% calc [currency=USD] 720 × ((3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }}) %}
>
> Total: {% calc [currency=USD] 720 × ((3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }})) + (3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}))) + (3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }}) + (3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.clickhouse.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.clickhouse.v3.ram|number }}) %}, cost of operation of {{ CH }} hosts per hour.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}, cost of operation of {{ ZK }} hosts per hour.
* {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.ch|month|number }} %}, cost of storage for {{ CH }} hosts.
* {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.ch|month|number }} %}: Cost of storage for {{ ZK }} hosts.
