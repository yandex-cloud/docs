#### Configurable components

Cost calculation for an exec node:

> 8 × {% calc [currency=USD] 1,361 / 120 %} + 32 × {% calc [currency=USD] 0,363 / 120 %} = {% calc [currency=USD] 8 × 1,361 / 120 + 32 × 0,363 / 120 %}
>
> Total: {% calc [currency=USD] 8 × 1,361 + 32 × 0,363 %}, cost of operation of the exec node for one hour.

Where:
* 8: Number of vCPUs of one exec node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 32: Amount of RAM (GB) of one exec node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for a tablet node:

> 3 × (8 × {% calc [currency=USD] 1,361 / 120 %} + 16 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}, cost of operation of tablet nodes for one hour.

Where:
* 3: Number of tablet nodes.
* 8: Number of vCPUs of one tablet node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 16: Amount of RAM (GB) of one tablet node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Calculating the cost of cluster storage:

> 3 × 2048 × {% calc [currency=USD] 3,784 / 120 %} + 3 × 465 × {% calc [currency=USD] 11,405 / 120 %} = {% calc [currency=USD] 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 %}
>
> Total: {% calc [currency=USD] 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 %}, cost of using non-replicated SSD and network HDD storage for one month.

Where:
* 3: Number of HDDs.
* 2048: Size of one HDD (in GB).
* {% calc [currency=USD] 3,784 / 120 %}: Cost of using one GB of network HDD storage per month.
* 3: Number of non-replicated SSDs.
* 465: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] 11,405 / 120 %}: Cost of using one GB of non-replicated SSD storage per month.

#### Service components

Cost calculation for a master node:

> 3 × (4 × {% calc [currency=USD] 1,361 / 120 %} + 12 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) %}, cost of operation of master nodes for one hour.

Where:
* 3: Number of master nodes.
* 4: Number of vCPUs of one master node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 12: Amount of RAM (GB) of one master node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for a system node:

> 2 × (24 × {% calc [currency=USD] 1,361 / 120 %} + 64 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) %}, cost of operation of system nodes for one hour.

Where:
* 2: Number of system nodes.
* 24: Number of vCPUs of one system node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 64: Amount of RAM (GB) of one system node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for a proxy node:

> 2 × (4 × {% calc [currency=USD] 1,361 / 120 %} + 8 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}, cost of operation of proxy nodes for one hour.

Where:
* 2: Number of proxy nodes.
* 4: Number of vCPUs of one proxy node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 8: Amount of RAM (GB) of one proxy node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for a service tablet node:

> 2 × (8 × {% calc [currency=USD] 1,361 / 120 %} + 16 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}, cost of operation of service tablet nodes for one hour.

Where:
* 2: Number of tablet nodes.
* 8: Number of vCPUs of one tablet node.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 16: Amount of RAM (GB) of one tablet node.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for the exec node storage:

> 93 × 1 × {% calc [currency=USD] 11,405 / 120 %} = {% calc [currency=USD] 93 × 1 × 11,405 / 120 %}
>
> Total: {% calc [currency=USD] 93 × 1 × 11,405 / 120 %}, cost of using non-replicated SSD storage for the exec node.

Where:
* 93: Size of non-replicated SSD storage (in GB).
* 1: Number of non-replicated SSDs.
* {% calc [currency=USD] 11,405 / 120 %}: Cost of using one GB of non-replicated SSD storage per month.

Cost calculation for the service storage node storage:

> 3 × 93 × {% calc [currency=USD] 11,405 / 120 %} = {% calc [currency=USD] 3 × 93 × 11,405 / 120 %}
>
> Total: {% calc [currency=USD] 3 × 93 × 11,405 / 120 %}, cost of using non-replicated SSD storage for the service storage nodes.

Where:
* 3: Number of disks.
* 93: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] 11,405 / 120 %}: Cost of using one GB of non-replicated SSD storage per month.

Cost calculation for a storage node:

> 6 × (8 × {% calc [currency=USD] 1,361 / 120 %} + 8 × {% calc [currency=USD] 0,363 / 120 %}) + 3 × (4 × {% calc [currency=USD] 1,361 / 120 %} + 8 × {% calc [currency=USD] 0,363 / 120 %}) = {% calc [currency=USD] 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}
>
> Total: {% calc [currency=USD] 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}, cost of operation of storage nodes for one hour.

Where:
* 6: Number of storage nodes for SSDs or non-replicated SSDs.
* 3: Number of storage nodes for HDDs.
* 8: Number of vCPUs per storage node for SSDs or non-replicated SSDs.
* 4: Number of vCPUs per storage node for HDDs.
* {% calc [currency=USD] 1,361 / 120 %}: Price per vCPU, per hour.
* 8: Amount of RAM (GB) per storage node for SSDs or non-replicated SSDs.
* {% calc [currency=USD] 0,363 / 120 %}: Сost of using 1 GB of RAM per hour.

Cost calculation for  storage with sevice disks:

> 93 × 6 × {% calc [currency=USD] 11,405 / 120 %} = {% calc [currency=USD] 93 × 6 × 11,405 / 120 %}
>
> Total: {% calc [currency=USD] 93 × 6 × 11,405 / 120 %}, cost of using non-replicated SSD storage.

Where:
* 6: Number of service disks.
* 93: Size of one non-replicated SSD (in GB).
* {% calc [currency=USD] 11,405 / 120 %}: Cost of using one GB of non-replicated SSD storage per month.

#### Total cost

> 720 × ({% calc [currency=USD] 8 × 1,361 / 120 + 32 × 0,363 / 120 %} + {% calc [currency=USD] 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %} + {% calc [currency=USD] 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) %} + {% calc [currency=USD] 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) %} + {% calc [currency=USD] 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %} + {% calc [currency=USD] 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %} + {% calc [currency=USD] 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}) + {% calc [currency=USD] 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 %} + {% calc [currency=USD] 93 × 1 × 11,405 / 120 %} + {% calc [currency=USD] 3 × 93 × 11,405 / 120 %} + {% calc [currency=USD] 93 × 6 × 11,405 / 120 %}  = {% calc [currency=USD] 720 × (8 × 1,361 / 120 + 32 × 0,363 / 120 + 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) + 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) + 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) + 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) + 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120)) + 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 + 93 × 1 × 11,405 / 120 + 3 × 93 × 11,405 / 120 + 93 × 6 × 11,405 / 120 %}
>
> Total: {% calc [currency=USD] 720 × (8 × 1,361 / 120 + 32 × 0,363 / 120 + 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) + 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) + 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) + 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) + 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120)) + 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 + 93 × 1 × 11,405 / 120 + 3 × 93 × 11,405 / 120 + 93 × 6 × 11,405 / 120 %}, cost of using the cluster for 30 days.

Where:
* 720: Hours in 30 days.
* {% calc [currency=USD] 8 × 1,361 / 120 + 32 × 0,363 / 120 %}: Cost of operation of the exec node for one hour.
* {% calc [currency=USD] 3 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}: Cost of operation of tablet nodes for one hour.
* {% calc [currency=USD] 3 × (4 × 1,361 / 120 + 12 × 0,363 / 120) %}: Cost of operation of master nodes for one hour.
* {% calc [currency=USD] 2 × (24 × 1,361 / 120 + 64 × 0,363 / 120) %}: Cost of operation of system nodes for one hour.
* {% calc [currency=USD] 2 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}: Cost of operation of proxy nodes for one hour.
* {% calc [currency=USD] 2 × (8 × 1,361 / 120 + 16 × 0,363 / 120) %}: Cost of operation of service tablet nodes for one hour.
* {% calc [currency=USD] 6 × (8 × 1,361 / 120 + 8 × 0,363 / 120) + 3 × (4 × 1,361 / 120 + 8 × 0,363 / 120) %}: Cost of operation of storage nodes for one hour.
* {% calc [currency=USD] 3 × 2048 × 3,784 / 120 + 3 × 465 × 11,405 / 120 %}: Cost of using non-replicated SSD and network HDD storage for one month.
* {% calc [currency=USD] 93 × 1 × 11,405 / 120 %}: Cost of using non-replicated SSD storage for the exec node.
* {% calc [currency=USD] 3 × 93 × 11,405 / 120 %}: Cost of using non-replicated SSD storage for the service storage nodes.
* {% calc [currency=USD] 93 × 6 × 11,405 / 120 %}: Cost of using non-replicated SSD storage.
