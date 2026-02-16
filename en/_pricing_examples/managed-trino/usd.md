> 720 × (8 × {{ sku|USD|trino.cluster.generic.vcpu.v1|string }} + 32 × {{ sku|USD|trino.cluster.generic.ram.v1|string }}) = {% calc [currency=USD] 720 × (8 × {{ sku|USD|trino.cluster.generic.vcpu.v1|number }} + 32 × {{ sku|USD|trino.cluster.generic.ram.v1|number }}) %}
>
> Total: {% calc [currency=USD] 720 × (8 × {{ sku|USD|trino.cluster.generic.vcpu.v1|number }} + 32 × {{ sku|USD|trino.cluster.generic.ram.v1|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Hours in 30 days.
* 8: Total number of 100% vCPUs.
* {{ sku|USD|trino.cluster.generic.vcpu.v1|string }}: Cost of using 100% vCPU per hour.
* 32: Total amount of RAM (in GB).
* {{ sku|USD|trino.cluster.generic.ram.v1|string }}: Cost of using 1 GB of RAM per hour.