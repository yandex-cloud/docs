| Ресурс        | Цена за 1 час                                        |
|---------------|------------------------------------------------------|
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }}      |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }}      |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }}      |

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                                        | Цена с CVoS на 1 год | Цена с CVoS на 3 года |
|---------------|------------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v1.cpu.c100|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.cpu.c100.v2|cud.y3|discount|percent|string }}) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y1.mdb.mongodb.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|string }} ({{ sku|RUB|v1.commitment.y3.mdb.mongodb.ram.v2|cud.y3|discount|percent|string }}) |
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c50|string }}  | —                | —
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mongodb.v3.cpu.c100|string }} | 0,7900 ₽ (-21 %) | 0,5900 ₽ (-41 %)
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mongodb.v3.ram|string }}      | 0,4400 ₽ (-12 %) | 0,3800 ₽ (-24 %)

{% endif %}