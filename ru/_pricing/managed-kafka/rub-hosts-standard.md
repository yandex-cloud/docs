{% list tabs %}

- Цены в час

    | Ресурс        | Цена за 1 час                                      | Цена с CVoS на 6 месяцев                                                        | Цена с CVoS на 1 год                                                            |
    |---------------|---------------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                                                 |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|string }}  | −                                                                               | −                                                                               |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v2|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v2|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v2|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v2|string }} (-22%)      |
    | **Intel Ice Lake**                                                                                                                                                                                                                     |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|string }}  | −                                                                               | −                                                                               |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v3|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v3|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v3.ram|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v3|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v3|string }} (-22%)      |

- Цены в месяц

    | Ресурс        | Цена за 1 месяц                                          | Цена с CVoS на 6 месяцев                                                              | Цена с CVoS на 1 год                                                                  |
    |---------------|---------------------------------------------------------:|--------------------------------------------------------------------------------------:|--------------------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                                                                   |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c50|month|string }}  | −                                                                                     | −                                                                                     |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v2.cpu.c100|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v2|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v2|month|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v2.ram|month|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v2|month|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v2|month|string }} (-22%)      |
    | **Intel Ice Lake**                                                                                                                                                                                                                                       |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c50|month|string }}  | −                                                                                     | −                                                                                     |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.kafka.v3.cpu.c100|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.cpu.c100.v3|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.cpu.c100.v3|month|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.kafka.v3.ram|month|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.kafka.ram.v3|month|string }} (-15%)       | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.kafka.ram.v3|month|string }} (-22%)      |

{% endlist %}
