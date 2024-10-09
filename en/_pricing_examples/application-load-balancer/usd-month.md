> {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} %} × 720 = {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} × 720 %}
>
> Total: {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} × 720 %}, cost of using a load balancer per month.

Where:

* {% calc [currency=USD] 8 × {{ sku|USD|alb.balancer.active|number }} %}: Cost of using a load balancer per hour.
* 720: Number of hours per month.
