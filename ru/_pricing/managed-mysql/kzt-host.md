| Ресурс        | Цена за 1 час                                           | |
|---------------|---------------------------------------------------------|---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c5|string }}   | 0,20 ₸|
| 20% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c20|string }}  | 2,15 ₸|
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c50|string }}  | 3,60 ₸|
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c100|string }} | 9,45 ₸|
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v1.ram|string }}      | 2,45 ₸ |
| **Intel Cascade Lake** | |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c5|string }}   | 0,20 ₸|
| 20% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c20|string }}  | 2,15 ₸|
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c50|string }}  | 3,60 ₸|
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c100|string }} | 9,35  ₸|
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v2.ram|string }}      | 2,55 ₸|
| **Intel Ice Lake** | |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c50|string }}  |  3,25 ₸|
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|string }} |  8,40 ₸|
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v3.ram|string }}      | 2,30 ₸|

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                                      | Цена с CVoS на 1 год | Цена с CVoS на 3 года |
|---------------|----------------------------------------------------|----------------------|-----------------------|
| **Intel Broadwell** |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v1.cpu.c100|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v1.ram|string }}      | − | − |
| **Intel Cascade Lake** |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c5|string }}   | − | − |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c20|string }}  | − | − |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c50|string }}  | − | − |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.mysql.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mysql.cpu.c100.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mysql.cpu.c100.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mysql.cpu.c100.v2|cud.y3|discount|percent|string }})
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.mysql.ram.v2|string }} ({{ sku|KZT|v1.commitment.y1.mdb.mysql.ram.v2|cud.y1|discount|percent|string }}) | {{ sku|KZT|v1.commitment.y3.mdb.mysql.ram.v2|string }} ({{ sku|KZT|v1.commitment.y3.mdb.mysql.ram.v2|cud.y3|discount|percent|string }})
| **Intel Ice Lake** |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c50|string }}  | —               | —               |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mysql.v3.cpu.c100|string }} | 4,3800 ₸ (-31%) | 3,4200 ₸ (-46%) |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mysql.v3.ram|string }}      | 1,1400 ₸ (-34%) | 0,8640 ₸ (-50%) |

{% endif %}