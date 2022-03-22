| Ресурс        | Цена за 1 час                                           | |
|---------------|---------------------------------------------------------|---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| **Intel Broadwell**                                                     | |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c5|string }}   | 0,15 ₸ |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c20|string }}  | 2,05 ₸ |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c50|string }}  | 3,40 ₸ |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c100|string }} | 11,40 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v1.ram|string }}      | 2,60 ₸ |
| **Intel Cascade Lake**                                                  | |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c5|string }}   | 0,15 ₸ |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c20|string }}  | 2,05 ₸ |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c50|string }}  | 3,40 ₸ |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c100|string }} | 9,60 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v2.ram|string }}      | 2,60 ₸ |
| **Intel Ice Lake**                                                      | |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c50|string }}  | 3,05 ₸ |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} | 8,60 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }}      | 2,35 ₸ |

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                                           | Цена с CVoS на 1 год                                            | Цена с CVoS на 3 года                                           |
|---------------|---------------------------------------------------------|-----------------------------------------------------------------|-----------------------------------------------------------------|
| **Intel Broadwell**                                                                                                                                                                                         |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v1.cpu.c100|string }} | −                                                               | −                                                               |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v1.ram|string }}      | −                                                               | −                                                               |
| **Intel Cascade Lake**                                                                                                                                                                                      |
| 5% vCPU       | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c5|string }}   | −                                                               | −                                                               |
| 20% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c20|string }}  | −                                                               | −                                                               |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c50|string }}  | −                                                               | −                                                               |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.ch.cpu.c100.v2|string }} (-27%) | {{ sku|KZT|v1.commitment.y3.mdb.ch.cpu.c100.v2|string }} (-43%) |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v2.ram|string }}      | {{ sku|KZT|v1.commitment.y1.mdb.ch.ram.v2|string }} (-36%)      | {{ sku|KZT|v1.commitment.y3.mdb.ch.ram.v2|string }} (-52%)      |
| **Intel Ice Lake**                                                                                                                                                                                          |
| 50% vCPU      | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c50|string }}  | —                                                               | —                                                               |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.clickhouse.v3.cpu.c100|string }} | 4,7280 ₸ (-27%)                                                 | 3,6780 ₸ (-43%)                                                 |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.clickhouse.v3.ram|string }}      | 1,1400 ₸ (-36%)                                                 | 0,8640 ₸ (-52%)                                                 |
{% endif %}
