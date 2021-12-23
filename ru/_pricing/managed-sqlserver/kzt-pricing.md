### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

| Продукт | Цена за 1 vCPU в месяц
| --- | ---
| Windows Server Datacenter | 7 214.4 ₸
| Microsoft SQL Server Standard | 40 752,0 ₸
| Microsoft SQL Server Enterprise | 139 364,1 ₸

### Вычислительные ресурсы хостов {#prices-hosts}

| Ресурс        | Цена за 1 час                                      |
|---------------|----------------------------------------------------|
| **Intel Cascade Lake**                                             |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }}      |
| **Intel Ice Lake**                                                 |
| 100% vCPU     | {{ sku|KZT|mdb.cluster.mssql.v3.cpu.c100|string }} |
| RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v3.ram|string }}      |

### Хранилище и резервные копии {#prices-storage}

{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     |
|-----------------------------------------|------------------------------------------------------------------------|
| Стандартное сетевое хранилище           | {{ sku|KZT|mdb.cluster.network-hdd.mssql|month|string }}               |
| Нереплицируемое сетевое хранилище       | 33,0000 ₸                                                              |
| Быстрое сетевое хранилище               | {{ sku|KZT|mdb.cluster.network-nvme.mssql|month|string }}              |
| Быстрое локальное хранилище             | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }}                |
| Резервные копии сверх размера хранилища | 15,2544 ₸                                                              |
