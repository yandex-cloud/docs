> 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|string }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|string }}) = {% calc 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}
>
> Total: {% calc 3 × (2 × {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.clickhouse.v3.ram|number }}) %}, cost of operation of {{ ZK }} hosts per hour.

Where:
* 3: Number of {{ ZK }} hosts.
* 2: Number of vCPUs.
* {{ sku|USD|mdb.zk.clickhouse.v3.cpu.c50|string }}: Cost of using 50% vCPU per hour.
* 4: Amount of RAM per {{ ZK }} host (in GB).
* {{ sku|USD|mdb.zk.clickhouse.v3.ram|string }}: Cost of using 1 GB of RAM at 50% vCPU per hour.