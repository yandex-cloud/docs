### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

Ресурс | Цена в месяц 
----- | ----- 
Windows Server Standard* | 6 020 ₽ за хост 
Microsoft SQL Server Standard |  23 586 ₽ за каждые 4 vCPU  
Microsoft SQL Server Enterprise | 80 652 ₽ за каждые 4 vCPU

\* Стоимость Windows Server Standard является фиксированной и не зависит от конфигурации ВМ


### Вычислительные ресурсы хостов {#prices-hosts}

Ресурс | Цена за 1 час
----- | ----- 
**Intel Cascade Lake** |
100% vCPU | {{ sku|RUB|mdb.cluster.mssql.v2.cpu.c100|string }}
RAM (за 1 ГБ) | {{ sku|RUB|mdb.cluster.mssql.v2.ram|string }}


### Хранилище и резервные копии {#prices-storage}

{% include [nrd-disks-preview](../../_includes/mdb/non-replicated-disks-preview.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     |
|-----------------------------------------|------------------------------------------------------------------------|
| Стандартное сетевое хранилище           | {{ sku|RUB|mdb.cluster.network-hdd.mssql|month|string }}               |
| Нереплицируемое сетевое хранилище       | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mssql|month|string }} |
| Быстрое сетевое хранилище               | {{ sku|RUB|mdb.cluster.network-nvme.mssql|month|string }}              |
| Быстрое локальное хранилище             | {{ sku|RUB|mdb.cluster.local-nvme.mssql|month|string }}                |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                               |
