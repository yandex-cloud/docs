Все цены указаны с включением НДС.

### Вычислительные ресурсы хостов {#prices-hosts}

Цена вычислительных ресурсов зависит от выбранной редакции {{ ES }}:

{% list tabs %}

- BASIC

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.basic|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.basic|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.basic|string }} (-9%)
   
- GOLD

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.gold|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.gold|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.gold|string }} (-9%)

- PLATINUM

   Ресурс | Цена за 1 час | Цена с CVoS на 1 год | Цена с CVoS на 3 года
   ----- | ----- | ----- | -----
   **Intel Cascade Lake** |
   100% vCPU | {{ sku|KZT|mdb.cluster.elasticsearch.v2.cpu.c100|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.cpu.c100.v2|string }} (-29%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.cpu.c100.v2|string }} (-45%)
   RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.elasticsearch.v2.ram.platinum|string }} | {{ sku|KZT|v1.commitment.y1.mdb.elasticsearch.ram.v2.platinum|string }} (-6%) | {{ sku|KZT|v1.commitment.y3.mdb.elasticsearch.ram.v2.platinum|string }} (-9%)

{% endlist %}

### Хранилище {#prices-storage}

Услуга | Цена за ГБ в месяц
----- | -----
Стандартное сетевое хранилище  | {{ sku|KZT|mdb.cluster.network-hdd.elasticsearch|month|string }} |
Быстрое сетевое хранилище  | {{ sku|KZT|mdb.cluster.network-nvme.elasticsearch|month|string }} |
Быстрое локальное хранилище  | {{ sku|KZT|mdb.cluster.local-nvme.elasticsearch|month|string }} |
