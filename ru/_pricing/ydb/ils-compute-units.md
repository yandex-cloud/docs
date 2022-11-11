### Вычислительные ресурсы хостов {#prices-compute-units}

{% if audience == "cvos" %}

| Ресурс        | Цена за 1 час                           | Цена с CVoS на 6 месяцев                                                  | Цена с CVoS на 1 год                                                      |
|---------------|-----------------------------------------|---------------------------------------------------------------------------|---------------------------------------------------------------------------|
| **Intel Cascade Lake**                                                                                                                                                                                          |
| 100% vCPU     | {{ sku|ILS|ydb.cluster.v2.cpu|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2|string }} (-15%) | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2|string }} (-22%) |
| RAM (за 1 ГБ) | {{ sku|ILS|ydb.cluster.v2.ram|string }} | {{ sku|ILS|v1.commitment.selfcheckout.m6.ydb.ram.v2|string }} (-15%)      | {{ sku|ILS|v1.commitment.selfcheckout.y1.ydb.ram.v2|string }} (-22%)      |

{% else %}

| Ресурс        | Цена за 1 час                           |
|---------------|-----------------------------------------|
| **Intel Cascade Lake**                                  |
| 100% vCPU     | {{ sku|ILS|ydb.cluster.v2.cpu|string }} |
| RAM (за 1 ГБ) | {{ sku|ILS|ydb.cluster.v2.ram|string }} |

{% endif %}