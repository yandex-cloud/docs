> 8 × {{ sku|USD|alb.balancer.active|string }} = {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} %}
>
> Total: {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} %}, cost of using a load balancer per hour.

Where:

* 8: Number of resource units.
* {{ sku|USD|alb.balancer.active|string }}: Price per resource unit.
