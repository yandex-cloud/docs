> 720 × (8 × {% calc [currency=USD] 2,042 / 120 %} + 32 × {% calc [currency=USD] 0,545 / 120 %}) = {% calc [currency=USD] 720 × (8 × (2,042 / 120) + 32 × (0,545 / 120)) %}
>
> Total: {% calc [currency=USD] 720 × (8 × (2,042 / 120) + 32 × (0,545 / 120)) %}, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* 8: Total number of 100% vCPUs.
* {% calc [currency=USD] 2,042 / 120 %}: Cost of using 100% vCPU per hour.
* 32: Total amount of RAM (in GB).
* {% calc [currency=USD] 0,545 / 120 %}: Cost of using 1 GB of RAM per hour.