> 72 × 600 = 43,200 units for VM usage
> 43,200 × {{ sku|USD|ai.datasphere.computing.v1|string }} = {% calc [currency=USD] 43200 × {{ sku|USD|ai.datasphere.computing.v1|number }} %}
>
> Total: {% calc [currency=USD] 43200 × {{ sku|USD|ai.datasphere.computing.v1|number }} %}, cost of using {{ ml-platform-name }}.

Where:

* 72: Number of units per g1.1 configuration.
* 600: VM usage time in seconds.
* {{ sku|USD|ai.datasphere.computing.v1|string }}: Cost per unit.