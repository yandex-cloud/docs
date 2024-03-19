### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- Basic

   | Ресурс        | Цена за 1 час                                               | Цена за 1 месяц                                                   |
   | ----- | ----: | ----: |
   | **Intel Cascade Lake**                                                                                                                          |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }}  |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|month|string }} |
   | **Intel Ice Lake**                                                          |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }}  |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|month|string }} |
   

- Gold

   | Ресурс        | Цена за 1 час                                              | Цена за 1 месяц                                                  |
   | ----- | ----: | ----: |
   | **Intel Cascade Lake**                                                                                                                        |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }} |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|month|string }} |
   | **Intel Ice Lake**                                                                                                                            |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }} |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|month|string }} |


- Platinum

   | Ресурс        | Цена за 1 час                                                  | Цена за 1 месяц                                                      |
   | ----- | ----: | ----: |
   | **Intel Cascade Lake**                                                                                                                                |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|month|string }}     |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|month|string }} |
   | **Intel Ice Lake**                                                                                                                                    |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|month|string }}     |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|month|string }} |


{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                             |
| --------------------------------------- | -----------------------------------------------------------------------------: |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Резервные копии сверх размера хранилища | 1,92 ₽                                                                         |
