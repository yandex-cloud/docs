| Software network acceleration | Price per hour, without VAT |
--- | ---
**Intel Broadwell** |
For VMs with less than 18 cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v1|number }} × 2 %}
For VMs with 18 or more cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v1|number }} × 4 %}
**Intel Cascade Lake** |
For VMs with less than 20 cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v2|number }} × 2 %}
For VMs with 20 or more cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v2|number }} × 4 %}
**Intel Ice Lake** |
For VMs with less than 36 cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v3|number }} × 2 %}
For VMs with 36 or more cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.v3|number }} × 4 %}
**Intel Ice Lake (Compute Optimized)** |
For VMs with less than 16 core | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.highfreq-v3|number }} × 2 %}
For VMs with 16 or more cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.highfreq-v3|number }} × 4 %}
**AMD Zen 3**^*^ |
For VMs with less than 96 cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.amd.v1|number }} × 2 %}
For VMs with 96 or more cores | {% calc [currency=USD] {{ sku|USD|compute.vm.software_accelerated_network.cores.amd.v1|number }} × 4 %}

^*^ Feature is available on request, subject to technical availability.