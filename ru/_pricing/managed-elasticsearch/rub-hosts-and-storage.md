Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- BASIC

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%)
   
- GOLD

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)

- PLATINUM

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|RUB|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|RUB|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|RUB|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%)

{% endlist %}

### Хранилище {#prices-storage}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                             |
|-----------------------------------------|--------------------------------------------------------------------------------|
| Стандартное сетевое хранилище           | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Нереплицируемое сетевое хранилище       | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Быстрое сетевое хранилище               | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Быстрое локальное хранилище             | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
