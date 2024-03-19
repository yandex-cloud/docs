### Вычислительные ресурсы хостов {#prices-hosts}

{% list tabs %}

- Цены в час

    | Ресурс        | Цена за 1 час                                           | Цена с CVoS на 6 месяцев                                                             | Цена с CVoS на 1 год                                                                 |
    |---------------|--------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                                                                |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c50|string }}  | —                                                                                    | —                                                                                    |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c100|string }} | —                                                                                    | —                                                                                    |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v2.ram|string }}      | —                                                                                    | —                                                                                    |
    | **Intel Ice Lake**                                                                                                                                                                                                                                    |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c50|string }}  | —                                                                                    | —                                                                                    |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c100|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v3.ram|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|string }} (-22%)      |

- Цены в месяц

    | Ресурс        | Цена за 1 месяц                                               | Цена с CVoS на 6 месяцев                                                             | Цена с CVoS на 1 год                                                                             |
    |---------------|--------------------------------------------------------------:|-------------------------------------------------------------------------------------:|-------------------------------------------------------------------------------------------------:|
    | **Intel Cascade Lake**                                                                                                                                                                                                                                                  |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c50|month|string }}  | —                                                                                    | —                                                                                                |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c100|month|string }} | —                                                                                    | —                                                                                                |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v2.ram|month|string }}      | —                                                                                    | —                                                                                                |
    | **Intel Ice Lake**                                                                                                                                                                                                                                                      |
    | 50% vCPU      | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c50|month|string }}  | —                                                                                    | —                                                                                                |
    | 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c100|month|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.opensearch.cpu.c100.v3|month|string }} (-15%) | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.opensearch.cpu.c100.v3|month|string }} (-22%) |
    | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v3.ram|month|string }}      | {{ sku|RUB|v1.commitment.selfcheckout.m6.mdb.opensearch.ram.v3|month|string }} (-15%)      | {{ sku|RUB|v1.commitment.selfcheckout.y1.mdb.opensearch.ram.v3|month|string }} (-22%)      |

{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                          |
|-----------------------------------------|----------------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.opensearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.opensearch|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.opensearch|month|string }}                |
| Резервные копии сверх размера хранилища | 1,92 ₽                                                                      |
