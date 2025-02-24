Calculating the cost of computing resources:

> ($0.00664 × 2 + $0.00344 × 2) × 1,000 = {% calc [currency=USD] (0,00664 × 2 + 0,00344 × 2) × 1000 %}
>
> {% calc [currency=USD] (0,00664 × 2 + 0,00344 × 2) × 1000 %}: Total cost of 1,000 hours of computing resource operation.

Where:
* $0.00664: Cost of using 50% vCPU per hour.
* 2: Number of vCPUs.
* $0.00344: Cost of using 1 GB of RAM per hour.
* 2: Amount of RAM (GB).
* 1,000: Total operating time of all desktops in the group over the month.

Cost calculation for boot disks:

> {% calc [currency=USD] 0,000176 × 720 %} × 50 × 10 = {% calc [currency=USD] 0,000176 × 720 × 50 × 10 %}
>
> {% calc [currency=USD] 0,000176 × 720 × 50 × 10 %}: Total cost of boot disk operation.

Where:
* {% calc [currency=USD] 0,000176 × 720 %}: Cost of using 1 GB of an SSD boot disk per month.
* 50: Boot disk size (GB).
* 10: Number of desktops in the group.

Cost calculation for working disks:

> {% calc [currency=USD] 0,000048 × 720 %} × 30 × 10 = {% calc [currency=USD] 0,000048 × 720 × 30 × 10 %}
>
> {% calc [currency=USD] 0,000048 × 720 × 30 × 10 %}: Total cost of working disk operation.

Where:
* {% calc [currency=USD] 0,000048 × 720 %}: Cost of using 1 GB of an HDD working disk per month.
* 30: Working disk size (GB).
* 10: Number of desktops in the group.

Total cost calculation:

> {% calc [currency=USD] (0,00664 × 2 + 0,00344 × 2) × 1000 %} + {% calc [currency=USD] 0,000176 × 720 × 50 × 10 %} + {% calc [currency=USD] 0,000048 × 720 × 30 × 10 %} = {% calc [currency=USD] ((0,00664 × 2 + 0,00344 × 2) × 1000) + (0,000176 × 720 × 50 × 10) + (0,000048 × 720 × 30 × 10) %}
>
> {% calc [currency=USD] ((0,00664 × 2 + 0,00344 × 2) × 1000) + (0,000176 × 720 × 50 × 10) + (0,000048 × 720 × 30 × 10) %}: Total cost of using {{ cloud-desktop-name }} per month.

Where:
* {% calc [currency=USD] (0,00664 × 2 + 0,00344 × 2) × 1000 %}: Cost of computing resources.
* {% calc [currency=USD] 0,000176 × 720 × 50 × 10 %}: Cost of boot disks.
* {% calc [currency=USD] 0,000048 × 720 × 30 × 10 %}: Cost of working disks.