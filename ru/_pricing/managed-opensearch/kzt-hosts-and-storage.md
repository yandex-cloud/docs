{% if audience != "draft" %}

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час |
|---------------|---------------|
| **Intel Cascade Lake**        |
| 100% vCPU     | 8,4000 ₸      |
| RAM (за 1 ГБ) | 3,5000 ₸      |
| **Intel Ice Lake**            |
| 100% vCPU     | 8,4000 ₸      |
| RAM (за 1 ГБ) | 3,5000 ₸      |

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц |
|-----------------------------------------|--------------------|
| Хранилище на сетевых HDD-дисках         | 16,0000 ₸          |
| Хранилище на нереплицируемых SSD-дисках | 44,0000 ₸          |
| Хранилище на сетевых SSD-дисках         | 65,0500 ₸          |
| Хранилище на локальных SSD-дисках       | 65,0500 ₸          |
| Резервные копии сверх размера хранилища | 9,6000 ₸           |

{% else %}

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                           |
|---------------|---------------------------------------------------------|
| **Intel Cascade Lake**                                                  |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.opensearch.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.opensearch.v2.ram|string }}      |
| **Intel Ice Lake**                                                      |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.opensearch.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.opensearch.v3.ram|string }}      |

### Хранилище {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                          |
|-----------------------------------------|-----------------------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.opensearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.opensearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.opensearch|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.opensearch|month|string }}                |
| Резервные копии сверх размера хранилища | 9,6000 ₸                                                                    |

{% endif %}
