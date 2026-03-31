> 72 × 185,760 × 2 = 26,749,440 units for the node
> 26,749,440 × {{ sku|USD|ai.datasphere.computing.v1|string }} = {% calc [currency=USD] 26 749 440 × {{ sku|USD|ai.datasphere.computing.v1|number }} %}
>
> Total: {% calc [currency=USD] 26 749 440 × {{ sku|USD|ai.datasphere.computing.v1|number }} %}, cost of using {{ ml-platform-name }}.

Where:
* 72: Number of units per g1.1 configuration.
* 185,760 : Node runtime in seconds.
* 2: Number of instances per node.
* {{ sku|USD|ai.datasphere.computing.v1|string }}: Cost per unit.