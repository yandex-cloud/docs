### Вычислительные ресурсы хостов {#prices-compute-units}

{% list tabs %}

- Цены в час

    | Ресурс        | Цена за 1 час                           | Цена с CVoS на 6 месяцев                                                  | Цена с CVoS на 1 год                                                      |
    |---------------|----------------------------------------:|--------------------------------------------------------------------------:|--------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                          |
    | 100% vCPU | {{ sku|RUB|ydb.cluster.v2.cpu|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|ydb.cluster.v2.ram|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.ydb.ram.v2|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.ydb.ram.v2|string }} (-22%)      |

- Цены в месяц

    | Ресурс        | Цена за 1 месяц                               | Цена с CVoS на 6 месяцев                                                        | Цена с CVoS на 1 год                                                            |
    |---------------|----------------------------------------------:|--------------------------------------------------------------------------------:|--------------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                                            |
    | 100% vCPU | {{ sku|RUB|ydb.cluster.v2.cpu|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.ydb.cpu.c100.v2|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.ydb.cpu.c100.v2|month|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|ydb.cluster.v2.ram|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.ydb.ram.v2|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.ydb.ram.v2|month|string }} (-22%) |

{% endlist %}
