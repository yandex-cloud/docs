> 720 × (24 × {{ sku|USD|spark.cluster.generic.vcpu.v2|string }} + 96 × {{ sku|USD|spark.cluster.generic.ram.v2|string }}) = {% calc [currency=USD] 720 × (24 × ({{ sku|USD|spark.cluster.generic.vcpu.v2|number }}) + 96 × ({{ sku|USD|spark.cluster.generic.ram.v2|number }})) %}
>
> Total: {% calc [currency=USD] 720 × (24 × ({{ sku|USD|spark.cluster.generic.vcpu.v2|number }}) + 96 × ({{ sku|USD|spark.cluster.generic.ram.v2|number }})) %}, cost of using the cluster for 30 days.

Where:
* 720: Hours in 30 days.
* 24: Total number of vCPUs.
* {{ sku|USD|spark.cluster.generic.vcpu.v2|string }}: Cost of using 1 vCPU per hour.
* 96: Total amount of RAM (in GB).
* {{ sku|USD|spark.cluster.generic.ram.v2|string }}: Cost of using 1 GB of RAM per hour.