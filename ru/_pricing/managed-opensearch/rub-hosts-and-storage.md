{% if audience != "draft" %}

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час |
|---------------|---------------|
| **Intel Cascade Lake**        |
| 100% vCPU     | 1,6800 ₽      |
| RAM (за 1 ГБ) | 0,7000 ₽      |
| **Intel Ice Lake**            |
| 100% vCPU     | 1,6800 ₽      |
| RAM (за 1 ГБ) | 0,7000 ₽      |

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц |
|-----------------------------------------|--------------------|
| Хранилище на сетевых HDD-дисках         | 3,2000 ₽           |
| Хранилище на нереплицируемых SSD-дисках | 8,8000 ₽           |
| Хранилище на сетевых SSD-дисках         | 13,0100 ₽          |
| Хранилище на локальных SSD-дисках       | 13,0100 ₽          |
| Резервные копии сверх размера хранилища | 1,9200 ₽           |

{% else %}

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                           |
|---------------|---------------------------------------------------------|
| **Intel Cascade Lake**                                                  |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v2.ram|string }}      |
| **Intel Ice Lake**                                                      |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.opensearch.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.opensearch.v3.ram|string }}      |

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                          |
|-----------------------------------------|-----------------------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.opensearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.opensearch|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.opensearch|month|string }}                |
| Резервные копии сверх размера хранилища | 1,9200 ₽                                                                    |

{% endif %}
