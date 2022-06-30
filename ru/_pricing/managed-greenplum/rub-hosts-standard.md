| Ресурс           | Цена за 1 час                                          |
| ----- | ----- |
| **Intel Cascade Lake**                                                    |
| 100% vCPU        | {{ sku|RUB|mdb.cluster.greenplum.v2.cpu.c100|string }} |
| RAM (за 1 ГБ)    | {{ sku|RUB|mdb.cluster.greenplum.v2.ram|string }}      |
| **Intel Ice Lake**                                                        |
| 100% vCPU        | {{ sku|RUB|mdb.cluster.greenplum.v3.cpu.c100|string }} |
| RAM (за 1 ГБ)    | {{ sku|RUB|mdb.cluster.greenplum.v3.ram|string }}      |


{% if audience == "cvos" %}

| Ресурс           | Цена за 1 час | Цена с CVoS на 1 год                                                   | Цена с CVoS на 3 года |
|------------------|---------------|------------------------------------------------------------------------|-----------------------|
| **Intel Cascade Lake**                                                          |
| 100% vCPU        | 1,4960 ₽      | {{ sku|RUB|v1.commitment.y1.mdb.greenplum.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.greenplum.cpu.c100.v2|string }} (-45%) |
| RAM (за 1 ГБ)    | 0,3960 ₽      | {{ sku|RUB|v1.commitment.y1.mdb.greenplum.ram.v2|string }} (-35%)      | {{ sku|RUB|v1.commitment.y3.mdb.greenplum.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                              |
| 100% vCPU        | 1,3440 ₽      | {{ sku|RUB|v1.commitment.y1.mdb.greenplum.cpu.c100.v3|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.greenplum.cpu.c100.v3|string }} (-45%) |
| RAM (за 1 ГБ)    | 0,3560 ₽      | {{ sku|RUB|v1.commitment.y1.mdb.greenplum.ram.v3|string }} (-35%)      | {{ sku|RUB|v1.commitment.y3.mdb.greenplum.ram.v3|string }} (-50%)      |

{% endif %}