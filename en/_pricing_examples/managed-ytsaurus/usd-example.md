#### Configurable components

Cost calculation for an exec node:

> 8 × {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.cpu.v3|number }} %} + 32 × {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.ram.v3|number }} %} = {% calc [currency=USD] 8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}
>
> Total: {% calc [currency=USD] 8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}, per hour cost of an exec node.

Where:
* 8: Number of vCPUs of one exec node.
* {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 32: Amount of RAM (GB) of one exec node.
* {% calc [currency=USD] {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for a tablet node:

> 3 × (8 × {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}, per hour cost of tablet nodes.

Where:
* 3: Number of tablet nodes.
* 8: Number of vCPUs of one tablet node.
* {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 16: Amount of RAM (GB) of one tablet node.
* {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Calculating the cost of cluster storage:

> 3 × 2,048 × {% calc [currency=USD] {{ sku|USD|yt.storage.hdd.v1|month|number }} %} + 3 × 465 × {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=USD] 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}, cost of using non-replicated SSD and network HDD storage per month.

Where:
* 3: Number of HDDs.
* 2,048: Size of one HDD (in GB).
* {% calc [currency=USD] {{ sku|USD|yt.storage.hdd.v1|month|number }} %}: Cost of using one GB of network HDD storage per month.
* 3: Number of non-replicated SSDs.
* 465: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using one GB of non-replicated SSD storage per month.

#### Service components

Cost calculation for a master node:

> 3 × (4 × {% calc [currency=USD] {{ sku|USD|yt.master-nodes.cpu.v3|number }} %} + 12 × {% calc [currency=USD] {{ sku|USD|yt.master-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) %}, per hour cost of master nodes.

Where:
* 3: Number of master nodes.
* 4: Number of vCPUs of one master node.
* {% calc [currency=USD] {{ sku|USD|yt.master-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 12: Amount of RAM (GB) of one master node.
* {% calc [currency=USD] {{ sku|USD|yt.master-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for a system node:

> 2 × (24 × {% calc [currency=USD] {{ sku|USD|yt.system-nodes.cpu.v3|number }} %} + 64 × {% calc [currency=USD] {{ sku|USD|yt.system-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) %}, per hour cost of system nodes.

Where:
* 2: Number of system nodes.
* 24: Number of vCPUs of one system node.
* {% calc [currency=USD] {{ sku|USD|yt.system-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 64: Amount of RAM (GB) of one system node.
* {% calc [currency=USD] {{ sku|USD|yt.system-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for a proxy node:

> 2 × (4 × {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }}) %}, per hour cost of proxy nodes.

Where:
* 2: Number of proxy nodes.
* 4: Number of vCPUs of one proxy node.
* {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 8: Amount of RAM (GB) of one proxy node.
* {% calc [currency=USD] {{ sku|USD|yt.proxy-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for a service tablet node:

> 2 × (8 × {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %} + 16 × {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}, per hour cost of service tablet nodes.

Where:
* 2: Number of tablet nodes.
* 8: Number of vCPUs of one tablet node.
* {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 16: Amount of RAM (GB) of one tablet node.
* {% calc [currency=USD] {{ sku|USD|yt.tablet-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for the exec node storage:

> 93 × 1 × {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=USD] 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Total: {% calc [currency=USD] 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}, cost of using non-replicated SSD storage for the exec node per month.

Where:
* 93: Size of non-replicated SSD storage (in GB).
* 1: Number of non-replicated SSDs.
* {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using one GB of non-replicated SSD storage per month.

Cost calculation for the service storage node storage:

> 3 × 93 × {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=USD] 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Total: {% calc [currency=USD] 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}, cost of using non-replicated SSD storage for the service storage nodes per month.

Where:
* 3: Number of disks.
* 93: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using one GB of non-replicated SSD storage per month.

Cost calculation for a storage node:

> 6 × (8 × {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.ram.v3|number }} %}) + 3 × (4 × {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.cpu.v3|number }} %} + 8 × {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.ram.v3|number }} %}) = {% calc [currency=USD] 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) %}, per hour cost of storage nodes.

Where:
* 6: Number of storage nodes for SSDs or non-replicated SSDs.
* 3: Number of storage nodes for HDDs.
* 8: Number of vCPUs per storage node for SSDs or non-replicated SSDs.
* 4: Number of vCPUs per storage node for HDDs.
* {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.cpu.v3|number }} %}: Cost per vCPU per hour.
* 8: Amount of RAM (GB) per storage node for SSDs or non-replicated SSDs.
* {% calc [currency=USD] {{ sku|USD|yt.storage-nodes.ram.v3|number }} %}: Cost of using 1 GB of RAM per hour.

Cost calculation for storage with service disks:

> 93 × 6 × {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} = {% calc [currency=USD] 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Total: {% calc [currency=USD] 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}, cost of using non-replicated SSD storage per month.

Where:
* 6: Number of service disks.
* 93: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using one GB of non-replicated SSD storage per month.

#### Total cost calculation

> 720 × ({% calc [currency=USD] 8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} %} + {% calc [currency=USD] 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=USD] 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) %} + {% calc [currency=USD] 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) %} + {% calc [currency=USD] 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }}) %} + {% calc [currency=USD] 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %} + {% calc [currency=USD] 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) %}) + {% calc [currency=USD] 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=USD] 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=USD] 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %} + {% calc [currency=USD] 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}  = {% calc [currency=USD] 720 × (8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 ×{{ sku|USD|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}
>
> Total: {% calc [currency=USD] 720 × (8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} + 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) + 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) + 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }}) + 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) + 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 ×{{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }})) + 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} + 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}, cost of using the cluster for 30 days.

Where:
* 720: Hours in 30 days.
* {% calc [currency=USD] 8 × {{ sku|USD|yt.compute-nodes.cpu.v3|number }} + 32 × {{ sku|USD|yt.compute-nodes.ram.v3|number }} %}: Per hour cost of an exec node.
* {% calc [currency=USD] 3 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}: Per hour cost of tablet nodes.
* {% calc [currency=USD] 3 × (4 × {{ sku|USD|yt.master-nodes.cpu.v3|number }} + 12 × {{ sku|USD|yt.master-nodes.ram.v3|number }}) %}: Per hour cost of master nodes.
* {% calc [currency=USD] 2 × (24 × {{ sku|USD|yt.system-nodes.cpu.v3|number }} + 64 × {{ sku|USD|yt.system-nodes.ram.v3|number }}) %}: Per hour cost of system nodes.
* {% calc [currency=USD] 2 × (4 × {{ sku|USD|yt.proxy-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.proxy-nodes.ram.v3|number }}) %}: Per hour cost of proxy nodes.
* {% calc [currency=USD] 2 × (8 × {{ sku|USD|yt.tablet-nodes.cpu.v3|number }} + 16 × {{ sku|USD|yt.tablet-nodes.ram.v3|number }}) %}: Per hour cost of service tablet nodes.
* {% calc [currency=USD] 6 × (8 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) + 3 × (4 × {{ sku|USD|yt.storage-nodes.cpu.v3|number }} + 8 × {{ sku|USD|yt.storage-nodes.ram.v3|number }}) %}: Per hour cost of storage nodes.
* {% calc [currency=USD] 3 × 2048 × {{ sku|USD|yt.storage.hdd.v1|month|number }} + 3 × 465 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using non-replicated SSD and network HDD storage per month.
* {% calc [currency=USD] 93 × 1 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using non-replicated SSD storage for the exec node per month.
* {% calc [currency=USD] 3 × 93 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using non-replicated SSD storage for the service storage nodes per month.
* {% calc [currency=USD] 93 × 6 × {{ sku|USD|yt.storage.ssd-nonreplicated.v1|month|number }} %}: Cost of using non-replicated SSD storage per month.
