### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ OS }}:

{% list tabs %}

- Basic
   
   | Ресурс        | Цена за 1 час                                               |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                      |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} |
   | **Intel Ice Lake**                                                          |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} |
   
   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                               | Цена с CVoS на 1 год                                                       | Цена с CVoS на 3 года                                                      |
   |---------------|-------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}  | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                    |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}  | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.basic|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v3.basic|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v3.basic|string }} (-9%) |
   {% endif %}

- Gold

   | Ресурс        | Цена за 1 час                                              |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                     |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} |
   | **Intel Ice Lake**                                                         |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} |

   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                              | Цена с CVoS на 1 год                                                       | Цена с CVoS на 3 года                                                      |
   |---------------|------------------------------------------------------------|----------------------------------------------------------------------------|----------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                               |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%)  | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)  |
   | **Intel Ice Lake**                                                                                                                                                                                                                   |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }}(-29%)  | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%) |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.gold|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v3.gold|string }} (-6%)  | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v3.gold|string }} (-9%)  |
   {% endif %}

- Platinum

   | Ресурс        | Цена за 1 час                                                  |
   | ----- | ----- |
   | **Intel Cascade Lake**                                                         |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} |
   | **Intel Ice Lake**                                                             |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} |

   {% if audience == "cvos" %}
   | Ресурс        | Цена за 1 час                                                  | Цена с CVoS на 1 год                                                          | Цена с CVoS на 3 года                                                         |
   |---------------|----------------------------------------------------------------|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
   | **Intel Cascade Lake**                                                                                                                                                                                                                         |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }}     | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%)    | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)    |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%) |
   | **Intel Ice Lake**                                                                                                                                                                                                                             |
   | 100% vCPU     | {{ sku|KZT|mdb.cluster.elasticsearch.v3.cpu.c100|string }}     | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v3|string }} (-29%)    | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v3|string }} (-45%)    |
   | RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v3.ram.platinum|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v3.platinum|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v3.platinum|string }} (-9%) |
   {% endif %}

{% endlist %}

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                   | Цена за ГБ в месяц                                                             |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках          | {{ sku|KZT|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках  | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Хранилище на сетевых SSD-дисках          | {{ sku|KZT|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Хранилище на локальных SSD-дисках        | {{ sku|KZT|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Резервные копии сверх размера хранилища  | 9,60 ₸ |
