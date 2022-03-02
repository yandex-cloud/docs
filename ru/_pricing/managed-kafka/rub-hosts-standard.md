| Ресурс        | Цена за 1 час                                      |
|---------------|----------------------------------------------------|
| **Intel Cascade Lake**                                             |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | 0,2520 ₽                                           |

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                                      | Цена с CVoS на 1 год                                               | Цена с CVoS на 3 года                                              |
|---------------|----------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                       |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                  | −                                                                  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|RUB|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|RUB|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%)      | {{ sku|RUB|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                                                                                                                                                           |
| 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|string }}  | —                                                                  | —                                                                  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} | 0,6670 ₽ (-29%)                                                    | 0,5130 ₽ (-46%)                                                    |
| RAM (за 1 ГБ) | 0,2520 ₽                                           | 0,1620 ₽ (-36%)                                                    | 0,1260 ₽ (-50%)                                                    |

{% endif %}
