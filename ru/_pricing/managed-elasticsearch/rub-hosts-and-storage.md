### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- BASIC

   | Ресурс        | Цена за 1 час                                               | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                      | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} | 2,1000 ₽ |
   | **Intel Ice Lake**                                                          | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} | 2,1000 ₽ |
   
   
- GOLD

   | Ресурс        | Цена за 1 час                                              | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                     | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | 2,4600 ₽ |
   | **Intel Ice Lake**                                                         | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} | 2,4600 ₽ |


- PLATINUM

   | Ресурс        | Цена за 1 час                                                  | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                         | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | 2,8300 ₽ |
   | **Intel Ice Lake**                                                             | |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | 1,6800 ₽ |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | 2,8300 ₽ |


{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                             | |
| ----- | ----- | ----- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               | 3,2000 ₽ |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} | 8,8000 ₽ |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              | 13,0100 ₽ |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                | 13,0100 ₽ |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                                       | 1,9200 ₽ |
