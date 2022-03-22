### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- BASIC
   
   | Ресурс        | Цена за 1 час                                               | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                      | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | 10,5000 ₸ |
   | **Intel Ice Lake**                                                          | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} | 10,5000 ₸ |
   
   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                               | Цена с CVoS на 1 год                                                       | Цена с CVoS на 3 года                                                      |
   |---------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                    |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | 4,5000 ₸ (-29%)                                                            | 3,4800 ₸ (-45%)                                                            |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} | 7,3800 ₸ (-6%)                                                             | 7,1400 ₸ (-9%)                                                             |
   {% endif %}

- GOLD

   | Ресурс        | Цена за 1 час                                              | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                     | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | 12,3000 ₸ |
   | **Intel Ice Lake**                                                         | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} | 12,3000 ₸ |

   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                              | Цена с CVoS на 1 год                                                       | Цена с CVoS на 3 года                                                      |
   |---------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                               |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                   |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | 4,5000 ₸ (-29%)                                                            | 3,4800 ₸ (-45%)                                                            |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} | 8,7000 ₸ (-6%)                                                             | 8,4000 ₸ (-9%)                                                             |
   {% endif %}

- PLATINUM

   | Ресурс        | Цена за 1 час                                                  | |
   | ----- | ----- | ----- |
   | | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
   | **Intel Cascade Lake**                                                         | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | 14,1500 ₸ |
   | **Intel Ice Lake**                                                             | |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | 8,4000 ₸ |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | 14,1500 ₸ |

   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                                  | Цена с CVoS на 1 год                                                          | Цена с CVoS на 3 года                                                         |
   |---------------|----------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                         |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                             |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | 4,5000 ₸ (-29%)                                                               | 3,4800 ₸ (-45%)                                                               |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | 10,0200 ₸ (-6%)                                                               | 9,6600 ₸ (-9%)                                                                |
   {% endif %}

{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                   | Цена за ГБ в месяц                                                             | |
| ----- | ----- | ----- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках          | {{ sku|KZT|mdb.cluster.network-hdd.elasticsearch|month|string }}               | 16,0000 ₸ |
| Хранилище на нереплицируемых SSD-дисках  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} | 44,0000 ₸ |
| Хранилище на сетевых SSD-дисках          | {{ sku|KZT|mdb.cluster.network-nvme.elasticsearch|month|string }}              | 65,0500 ₸ |
| Хранилище на локальных SSD-дисках        | {{ sku|KZT|mdb.cluster.local-nvme.elasticsearch|month|string }}                | 65,0500 ₸ |
| Резервные копии сверх размера хранилища  | 15,2544 ₸                                                                       | 9,6000 ₸ |
