Calculating the cost of computing resources:

> ({{ sku|USD|cloud_desktop.vcpu.c50.v1|string }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|string }} × 2) × 1,000 = {% calc [currency=USD] ({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000 %}
>
> Total: {% calc [currency=USD] ({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000 %}: Total cost of 1,000 hours of computing resource operation.

Where:
* {{ sku|USD|cloud_desktop.vcpu.c50.v1|string }}: Cost of using 50% vCPU per hour.
* 2: Number of vCPUs.
* {{ sku|USD|cloud_desktop.ram.v1|string }}: Cost of using 1 GB of RAM per hour.
* 2: Amount of RAM (GB).
* 1,000: Total operating time of all desktops in the group over the month.

Cost calculation for boot disks:

> {{ sku|USD|cloud_desktop.ssd.v1|month|string }} × 50 × 10 = {% calc [currency=USD] {{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %}
>
> Total: {% calc [currency=USD] {{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %}: Cost of boot disk operation.

Where:
* {{ sku|USD|cloud_desktop.ssd.v1|month|string }}: Cost of using an SSD boot disk per 1 GB per month.
* 50: Boot disk size (GB).
* 10: Number of desktops in the group.

Cost calculation for data disks:

> {{ sku|USD|cloud_desktop.hdd.v1|month|string }} × 30 × 10 = {% calc [currency=USD] {{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %}
>
> Total: {% calc [currency=USD] {{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %}: Cost of data disk operation.

Where:
* {{ sku|USD|cloud_desktop.hdd.v1|month|string }}: Cost of using an HDD data disk per 1 GB per month.
* 30: Data disk size (GB).
* 10: Number of desktops in the group.

Total cost calculation:

> {% calc [currency=USD] ({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000 %} + {% calc [currency=USD] {{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %} + {% calc [currency=USD] {{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %} = {% calc [currency=USD] (({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %}
>
> Total: {% calc [currency=USD] (({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000) + ({{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10) + ({{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10) %}: Per month cost of {{ cloud-desktop-name }}.

Where:
* {% calc [currency=USD] ({{ sku|USD|cloud_desktop.vcpu.c50.v1|number }} × 2 + {{ sku|USD|cloud_desktop.ram.v1|number }} × 2) × 1000 %}: Cost of computing resources.
* {% calc [currency=USD] {{ sku|USD|cloud_desktop.ssd.v1|month|number }} × 50 × 10 %}: Cost of boot disks.
* {% calc [currency=USD] {{ sku|USD|cloud_desktop.hdd.v1|month|number }} × 30 × 10 %}: Cost of data disks.