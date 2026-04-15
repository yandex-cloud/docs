> 1,440 × 20 × {{ sku|USD|compute.snapshot|string }} = {% calc [currency=USD] 1440 × 20 × {{ sku|USD|compute.snapshot|number }} %}
>
> Total: {% calc [currency=USD] 1440 × 20 × {{ sku|USD|compute.snapshot|number }} %}, which is the cost of storing a 20 GB snapshot for 60 days.

Where:
* 1,440: Number of hours in 60 days.
* 20: Snapshot volume (in GB).
* {{ sku|USD|compute.snapshot|string }}: Cost of storing a 1 GB snapshot per hour.
