### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

| Продукт | Цена за 1 vCPU в месяц | |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Windows Server Datacenter | 11 538 ₸ | 9 615 ₸ |
| Microsoft SQL Server Standard | 65 202 ₸ | 54 335 ₸ |
| Microsoft SQL Server Enterprise | 222 978 ₸ | 185 815 ₸ |

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      | |
| --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| **Intel Cascade Lake** | | |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }} | 9,6000 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }}      | 2,5500 ₸ |
| **Intel Ice Lake** | | |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v3.cpu.c100|string }} | 8,6000 ₸ |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v3.ram|string }}      | 2,3000 ₸ |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     | |
| --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.mssql|month|string }}               | 16,0000 ₸ |
| Хранилище на нереплицируемых SSD-дисках | 33,0000 ₸                                                              | 44,0000 ₸ |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.mssql|month|string }}              | 65,0500 ₸ |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }}                | 65,0500 ₸ |
| Резервные копии сверх размера хранилища | 15,2544 ₸                                                              | 9,6000 ₸ |
