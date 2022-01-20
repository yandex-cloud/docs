### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

Ресурс | Цена за 1 vCPU в месяц
--- | ---
Windows Server Datacenter | 1 202,40 ₽
Microsoft SQL Server Standard | 6 792,00 ₽
Microsoft SQL Server Enterprise | 23 227,35 ₽

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      |
|---------------|----------------------------------------------------|
| **Intel Cascade Lake**                                             |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 100% vCPU     | {{ sku|RUB|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v3.ram|string }}      |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     |
|-----------------------------------------|------------------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | 5,5000 ₽                                                               |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}                |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                               |
