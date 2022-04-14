### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно [за весь календарный месяц](../../managed-sqlserver/pricing/index.md#license), в котором запущен кластер, вне зависимости от времени фактической работы кластера и даты его запуска:

| Продукт | Цена за 1 vCPU в месяц |
| --- | --- |
| Windows Server Datacenter | 9 615 ₸ |
| Microsoft SQL Server Standard | 54 335 ₸ |
| Microsoft SQL Server Enterprise | 185 815 ₸ |

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      |
| --- | --- |
| **Intel Cascade Lake**                                             |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v3.ram|string }}      |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                        |
| --- | --- |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.mssql|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках | 44,0000 ₸                                                 |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.mssql|month|string }} |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }}   |
| Резервные копии сверх размера хранилища | 9,6000 ₸                                                  |
