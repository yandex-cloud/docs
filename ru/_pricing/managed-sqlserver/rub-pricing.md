### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

| Ресурс | Цена за 1 vCPU в месяц |
| --- | --- |
| Windows Server Datacenter | 1 923 ₽ |
| Microsoft SQL Server Standard | 10 867 ₽ |
| Microsoft SQL Server Enterprise | 37 163 ₽ |

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      | |
| --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| **Intel Cascade Lake**                                             | | |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} | 1,9200 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}      | 0,5100 ₽ |
| **Intel Ice Lake**                                                 | | |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v3.cpu.c100|string }} | 1,7200 ₽ |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v3.ram|string }}      | 0,4600 ₽ |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     | |
| --- | --- | --- |
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}               | 3,2000 ₽ |
| Хранилище на нереплицируемых SSD-дисках | 5,5000 ₽                                                               | 8,8000 ₽ |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }}              | 13,0100 ₽ |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}                | 13,0100 ₽ |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                               | 1,9200 ₽ |
