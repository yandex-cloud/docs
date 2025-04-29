| Computing resources | Prices per hour,<br>without VAT | Prices per month,<br>without VAT |
|---------------------|--------------------------------:|---------------------------------:|
| **Intel Cascade Lake**                                                                                                    |
| 100% vCPU              | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|number }} + {{ sku|USD|compute.hostgroup.cpu.c100.v1|number }} %} | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.cpu.c100|month|number }} + {{ sku|USD|compute.hostgroup.cpu.c100.v1|month|number }} %} |
| RAM (for 1 GB)          | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|number }} + {{ sku|USD|compute.hostgroup.ram.v1|number }} %} | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v2.ram|month|number }} + {{ sku|USD|compute.hostgroup.ram.v1|month|number }} %} |
| **Intel Ice Lake**                                                                                                            |
| 100% vCPU              | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v3.cpu.c100|number }} + {{ sku|USD|compute.hostgroup.cpu.c100.v3|number }} %} | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v3.cpu.c100|month|number }} + {{ sku|USD|compute.hostgroup.cpu.c100.v3|month|number }} %} |
| RAM (for 1 GB)          | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v3.ram|number }} + {{ sku|USD|compute.hostgroup.ram.v3|number }} %} | {% calc [currency=USD] {{ sku|USD|mdb.dataproc.v3.ram|month|number }} + {{ sku|USD|compute.hostgroup.ram.v3|month|number }} %} |
