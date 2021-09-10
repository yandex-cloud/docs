| Ресурс        | Цена за 1 час                                   | Цена с CVoS на 1 год | Цена с CVoS на 3 года |
|---------------|-------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c100|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.pg.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.pg.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.pg.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.pg.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.pg.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.pg.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.pg.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.pg.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.pg.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.pg.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.pg.v3.cpu.c50|string }}  | —               | —               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.pg.v3.cpu.c100|string }} | 0,7320 ₽ (-28%) | 0,5790 ₽ (-43%) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.pg.v3.ram|string }}      | 0,1810 ₽ (-35%) | 0,1350 ₽ (-52%) |
