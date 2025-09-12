> 720 × (24 × {% calc [currency=USD] 1,5477 / 120 %} + 96 × {% calc [currency=USD] 0,40788 / 120 %}) = {% calc [currency=USD] 720 × (24 × (1,5477 / 120) + 96 × (0,40788 / 120)) %}
>
> Total: {% calc [currency=USD] 720 × (24 × (1,5477 / 120) + 96 × (0,40788 / 120)) %}, cost of using the cluster for 30 days.

Where:
* 720: Hours in 30 days.
* 24: Total number of vCPUs.
* {% calc [currency=USD] 1,5477 / 120 %}: Cost of using 1 vCPU per hour.
* 96: Total amount of RAM (in GB).
* {% calc [currency=USD] 0,40788 / 120 %}: Cost of using 1 GB of RAM per hour.