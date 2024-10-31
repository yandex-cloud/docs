Cost calculation for {{ KF }} broker hosts:

> 3 × (2&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }} + 8&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.kafka.v3.ram|string }}) = {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }}) %}, per hour cost of {{ KF }} broker hosts.

Where:
* 3: Number of {{ KF }} broker hosts.
* 2: Number of vCPUs.
* {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|string }}: Cost of using 100% vCPU per hour.
* 8: Amount of RAM per host (in GB).
* {{ sku|USD|mdb.cluster.kafka.v3.ram|string }}: Cost of using 1 GB of RAM at 100% vCPU per hour.

Calculating the cost of storage for {{ KF }} broker hosts:

> 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|string }} = {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }} %}, cost of storage for {{ KF }} broker hosts.

Where:
* 3: Number of {{ KF }} broker hosts.
* 100: Amount of network HDD storage (in GB).
* {{ sku|USD|mdb.cluster.network-hdd.kafka|month|string }}: Cost of using 1 GB of network HDD storage per month.

Cost calculation for {{ ZK }} hosts:

> 3 × (2&nbsp;×&nbsp;{{ sku|USD|mdb.zk.kafka.v3.cpu.c50|string }} + 4&nbsp;×&nbsp;{{ sku|USD|mdb.zk.kafka.v3.ram|string }}) = {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}) %}, per hour cost of {{ ZK }} hosts.

Where:
* 3: Number of {{ ZK }} hosts.
* 2: Number of vCPUs.
* {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|string }}: Cost of using 50% vCPU per hour.
* 4: Amount of RAM per host (in GB).
* {{ sku|USD|mdb.zk.kafka.v3.ram|string }}: Cost of using 1 GB of RAM at 50% vCPU per hour.

Calculating the cost of storage for {{ ZK }} hosts:

> 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|string }} = {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }} %}, cost of storage for {{ ZK }} hosts.

Where:
* 3: Number of {{ ZK }} hosts.
* 10: Amount of SSD network storage (in GB).
* {{ sku|USD|mdb.cluster.network-nvme.kafka|month|string }}: Cost of using 1 GB of network SSD storage per month.

Total cost calculation:

> 720 × ({% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }}) %} + {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}) %}) + {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }} %} + {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }} %} = {% calc [currency=USD] 720 × ((3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }}) %}
>
> Total: {% calc [currency=USD] 720 × ((3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }})) + (3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}))) + (3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }}) + (3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.cluster.kafka.v3.cpu.c100|number }} + 8 × {{ sku|USD|mdb.cluster.kafka.v3.ram|number }}) %}: Per hour cost of {{ KF }} broker hosts.
* {% calc [currency=USD] 3 × (2 × {{ sku|USD|mdb.zk.kafka.v3.cpu.c50|number }} + 4 × {{ sku|USD|mdb.zk.kafka.v3.ram|number }}) %}: Per hour cost of {{ ZK }} hosts.
* {% calc [currency=USD] 3 × 100 × {{ sku|USD|mdb.cluster.network-hdd.kafka|month|number }} %}: Cost of storage for {{ KF }} broker hosts.
* {% calc [currency=USD] 3 × 10 × {{ sku|USD|mdb.cluster.network-nvme.kafka|month|number }} %}: Cost of storage for {{ ZK }} hosts.