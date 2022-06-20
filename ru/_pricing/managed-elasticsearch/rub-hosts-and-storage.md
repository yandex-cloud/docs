### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- Basic

   | Ресурс        | Цена за 1 час                                               |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                      |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} |
   | **Intel Ice Lake**                                                          |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.basic|string }} |
   
   
- Gold

   | Ресурс        | Цена за 1 час                                              |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                     |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} |
   | **Intel Ice Lake**                                                         |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.gold|string }} |


- Platinum

   | Ресурс        | Цена за 1 час                                                  |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                         |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} |
   | **Intel Ice Lake**                                                             |
   | 100% vCPU     | {{ sku|RUB|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     |
   | RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v3.ram.platinum|string }} |


{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                             |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Резервные копии сверх размера хранилища | 1,92 ₽ |
