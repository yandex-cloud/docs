| Ресурс        | Цена за 1 час                                      |
|---------------|----------------------------------------------------|
| **Intel Cascade Lake**                                             |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c50|string }}  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.kafka.v3.ram|string }} |

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                                      | Цена с CVoS на 1 год                                               | Цена с CVoS на 3 года                                              |
|---------------|----------------------------------------------------|--------------------------------------------------------------------|--------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                       |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                  | −                                                                  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.cpu.c100.v2|string }} (-30%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.cpu.c100.v2|string }} (-46%) |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.kafka.ram.v2|string }} (-36%)      | {{ sku|KZT|v1.commitment.y3.mdb.kafka.ram.v2|string }} (-50%)      |
| **Intel Ice Lake**                                                                                                                                                                                           |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c50|string }}  | —                                                                  | —                                                                  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.kafka.v3.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.kafka.cpu.c100.v3|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.kafka.cpu.c100.v3|string }} (-46%) |
| RAM (за 1 ГБ) | 1,5120 ₸                                           | {{ sku|KZT|v1.commitment.y1.mdb.kafka.ram.v3|string }} (-36%)      | {{ sku|KZT|v1.commitment.y3.mdb.kafka.ram.v3|string }} (-50%)      |

{% endif %}