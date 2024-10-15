| Resource | Cost per hour | Available | Total |
| --- | --- | --- | ---: |
| vCPU | {{ sku|USD|compute.hostgroup.cpu.c100.v3|string }}/vCPU | 108 vCPU | {% calc [currency=USD] {{ sku|USD|compute.hostgroup.cpu.c100.v3|number }} × 108 %} |
| RAM | {{ sku|USD|compute.hostgroup.ram.v3|string }}/GB | 704 GB | {% calc [currency=USD] {{ sku|USD|compute.hostgroup.ram.v3|number }} × 704 %} |
| Disk | {{ sku|USD|compute.hostgroup.localssd.v1|string }}/GB | 19&nbsp;200 GB | {% calc [currency=USD] {{ sku|USD|compute.hostgroup.localssd.v1|number }} × 19200 %} |
| | | **Total** | **{% calc [currency=USD] {{ sku|USD|compute.hostgroup.cpu.c100.v3|number }} × 108 + {{ sku|USD|compute.hostgroup.ram.v3|number }} × 704 + {{ sku|USD|compute.hostgroup.localssd.v1|number }} × 19200 %}** |