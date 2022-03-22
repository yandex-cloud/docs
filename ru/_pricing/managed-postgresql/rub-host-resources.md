| Ресурс        | Цена за 1 час                                           | |
|---------------|---------------------------------------------------------|---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| **Intel Broadwell** | |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c5|string }}   | 0,06 ₽ |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c20|string }}  | 0,45 ₽ |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c50|string }}  | 0,75 ₽ |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.pg.v1.cpu.c100|string }} | 2,14 ₽ |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.pg.v1.ram|string }}      | 0,49 ₽ |
| **Intel Cascade Lake** | |
| 5% vCPU        | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c5|string }}   | 0,06 ₽ |
| 20% vCPU       | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c20|string }}  | 0,45 ₽ |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c50|string }}  | 0,75 ₽ |
| 100% vCPU      | {{ sku|RUB|mdb.cluster.pg.v2.cpu.c100|string }} | 1,81 ₽ |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.pg.v2.ram|string }}      | 0,49 ₽|
| **Intel Ice Lake** | |
| 50% vCPU       | {{ sku|RUB|mdb.cluster.pg.v3.cpu.c50|string }}  | 0,68 ₽|
| 100% vCPU      | {{ sku|RUB|mdb.cluster.pg.v3.cpu.c100|string }} | 1,63 ₽ |
| RAM (for 1 GB) | {{ sku|RUB|mdb.cluster.pg.v3.ram|string }}      | 0,44 ₽|

{% if audience == "cvos" %}

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

{% endif %}
