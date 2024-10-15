| Ресурс | Стоимость за час | Доступно | Итого |
| --- | --- | --- | ---: |
| vCPU | {{ sku|KZT|compute.hostgroup.cpu.c100.v3|string }}/vCPU | 108 vCPU | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.cpu.c100.v3|number }} × 108 %} |
| RAM | {{ sku|KZT|compute.hostgroup.ram.v3|string }}/ГБ | 704 ГБ | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.ram.v3|number }} × 704 %} |
| Диск | {{ sku|KZT|compute.hostgroup.localssd.v1|string }}/ГБ | 19&nbsp;200 ГБ | {% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.localssd.v1|number }} × 19200 %} |
| | | **Итого** | **{% calc [currency=KZT] {{ sku|KZT|compute.hostgroup.cpu.c100.v3|number }} × 108 + {{ sku|KZT|compute.hostgroup.ram.v3|number }} × 704 + {{ sku|KZT|compute.hostgroup.localssd.v1|number }} × 19200 %}** |