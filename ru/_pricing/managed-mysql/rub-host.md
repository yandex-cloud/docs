| Ресурс        | Цена за 1 час                                      | Цена с CVoS на 1 год | Цена с CVoS на 3 года |
|---------------|----------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mysql.v1.cpu.c100|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mysql.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mysql.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mysql.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mysql.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mysql.cpu.c100.v2|cud.y3|discount|percent|string }})
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.mysql.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mysql.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mysql.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mysql.ram.v2|cud.y3|discount|percent|string }})
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c50|string }}  | —               | —               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mysql.v3.cpu.c100|string }} | 0,7300 ₽ (-31%) | 0,5700 ₽ (-46%) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mysql.v3.ram|string }}      | 0,1900 ₽ (-34%) | 0,1440 ₽ (-50%) |
