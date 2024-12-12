Cost calculation for standard hosts:

> 3 × (8&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|string }} + 32&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.greenplum.v3.ram|string }}) = {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }}) %}
>
> Total: {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }}) %}, cost of operation of standard hosts per hour.

  Where:

  * 3: Number of standard hosts.
  * 8: Number of vCPUs.
  * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|string }}: Cost of using 100% vCPU per hour.
  * 32: Amount of RAM per standard host (in GB).
  * {{ sku|USD|mdb.cluster.greenplum.v3.ram|string }}: Cost of using 1 GB of RAM at 100% vCPU per hour.

Cost calculation for dedicated hosts:

> 3 × (8&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }} + 32&nbsp;×&nbsp;{{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|string }}) = {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}
>
> Total: {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}, cost of operation of dedicated hosts per hour.

  Where:

  * 3: Number of dedicated hosts.
  * 8: Number of vCPUs.
  * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|string }}: Cost of using 100% vCPU per hour.
  * 32: Amount of RAM per dedicated host (in GB).
  * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|string }}: Cost of using 1 GB of RAM at 100% vCPU per hour.

Calculation for the storage cost and total cost:

> (720 × {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }}) %} + 3 × (100 × {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }})) + (720 × {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %} + 3 × (50 × {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|string }})) = {% calc [currency=USD] (720 * (3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|number }}) %}
>
> Total: {% calc [currency=USD] (720 * (3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }})) + 3 * 100 * {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|number }}) + (720 * (3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }})) + 3 * 50 * {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|number }}) %}, cost of using the cluster for 30 days.

  Where:

  * 720: Number of hours in 30 days.
  * {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v3.cpu.c100|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v3.ram|number }}) %}, cost of operation of standard hosts per hour.
  * 3: Number of hosts.
  * 100: Amount of network HDD storage (in GB) for standard hosts.
  * {{ sku|USD|mdb.cluster.network-hdd.greenplum|month|string }}: Cost of using 1 GB of network HDD storage per month.
  * {% calc [currency=USD] 3 * (8 * {{ sku|USD|mdb.cluster.greenplum.v2.cpu.c100.dedicated|number }} + 32 * {{ sku|USD|mdb.cluster.greenplum.v2.ram.dedicated|number }}) %}, cost of operation of dedicated hosts per hour.
  * 50: Amount of local SSD storage (in GB) for dedicated hosts.
  * {{ sku|USD|mdb.cluster.local-nvme.greenplum|month|string }}: Cost of using 1 GB of local SSD storage per month.