> 720 × (3 × {{ sku|USD|airflow.cluster.generic.vcpu.v1|string }} + 12 × {{ sku|USD|airflow.cluster.generic.ram.v1|string }}) = {% calc [currency=USD] 720 × (3 × {{ sku|USD|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|USD|airflow.cluster.generic.ram.v1|number }}) %}
>
> Total: {% calc [currency=USD] 720 × (3 × {{ sku|USD|airflow.cluster.generic.vcpu.v1|number }} + 12 × {{ sku|USD|airflow.cluster.generic.ram.v1|number }}) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* 3: Total number of 100% vCPUs.
* {{ sku|USD|airflow.cluster.generic.vcpu.v1|string }}: Cost of using 100% vCPU per hour.
* 12: Total amount of RAM (in GB).
* {{ sku|USD|airflow.cluster.generic.ram.v1|string }}: Cost of using 1 GB of RAM per hour.