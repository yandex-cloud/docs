| Ресурс        | Цена за 1 час                                           |
|---------------|---------------------------------------------------------|
| **Intel Broadwell**                                                     | 
| 5% vCPU       | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c5|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c20|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v1.ram|string }}      |
| **Intel Cascade Lake**                                                  | 
| 5% vCPU       | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c5|string }}   |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c20|string }}  |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v2.ram|string }}      |
| **Intel Ice Lake**                                                      | 
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }}      |

{%if audience == "cvos" %}
| Ресурс        | Цена за 1 час                                           | Цена с CVoS на 1 год                                            | Цена с CVoS на 3 года                                           |
|---------------|---------------------------------------------------------|-----------------------------------------------------------------|-----------------------------------------------------------------|
| **Intel Broadwell**                                                                                                                                                                                         |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v1.cpu.c100|string }} | −                                                               | −                                                               |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v1.ram|string }}      | −                                                               | −                                                               |
| **Intel Cascade Lake**                                                                                                                                                                                      |
| 5% vCPU       | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.ch.cpu.c100.v2|string }} (-27%) | {{ sku|RUB|v1.commitment.y3.mdb.ch.cpu.c100.v2|string }} (-43%) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.ch.ram.v2|string }} (-36%)      | {{ sku|RUB|v1.commitment.y3.mdb.ch.ram.v2|string }} (-52%)      |
| **Intel Ice Lake**                                                                                                                                                                                          |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c50|string }}  | —                                                               | —                                                               |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.clickhouse.v3.cpu.c100|string }} | 0,7880 ₽ (-27%)                                                 | 0,6130 ₽ (-43%)                                                 |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.clickhouse.v3.ram|string }}      | 0,1900 ₽ (-36%)                                                 | 0,1440 ₽ (-52%)                                                 |
{% endif %}