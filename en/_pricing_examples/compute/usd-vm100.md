> 720 × (2 × {{ sku|USD|compute.vm.cpu.c100.v3|string }} + 2 × {{ sku|USD|compute.vm.ram.v3|string }}) = {% calc [currency=USD] 720 × (2 × {{ sku|USD|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|USD|compute.vm.ram.v3|number }}) %}
>
> Total: {% calc [currency=USD] 720 × (2 × {{ sku|USD|compute.vm.cpu.c100.v3|number }} + 2 × {{ sku|USD|compute.vm.ram.v3|number }}) %}, cost of using a VM with 2 × 100% vCPU and 2 GB of RAM for 30 days.

Where:
* 720: Number of hours in 30 days.
* 2: Number of 100% vCPUs.
* {{ sku|USD|compute.vm.cpu.c100.v3|string }}: Cost of using 100% vCPU per hour.
* 2: Amount of RAM (GB).
* {{ sku|USD|compute.vm.ram.v3|string }}: Cost of using 1 GB of RAM per hour.