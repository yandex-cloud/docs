### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно [за весь календарный месяц](../../managed-sqlserver/pricing/index.md#license), в котором запущен кластер, вне зависимости от времени фактической работы кластера и даты его запуска:

| Ресурс | Цена за 1 vCPU в месяц |
| --- | --- |
| Windows Server Datacenter | 1923 ₽ |
| Microsoft SQL Server Standard | 10 867 ₽ |
| Microsoft SQL Server Enterprise | 37 163 ₽ |

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      |
| --- | --- |
| **Intel Cascade Lake**                                             |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v3.ram|string }}      |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                        |
| --- | --- |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках | 8,8000 ₽ |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }} |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}   |
| Резервные копии сверх размера хранилища | 1,9200 ₽ |
