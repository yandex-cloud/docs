### Лицензии {#licence}

Списание средств для следующих продуктов происходит единовременно в момент запуска ВМ из расчета за один календарный месяц вперед, вне зависимости от времени фактической работы ВМ:

Ресурс | Цена в месяц 
----- | ----- 
Windows Server Standard* | 36 120 ₸ за хост 
Microsoft SQL Server Standard |  141 516 ₸ за каждые 4 vCPU  
Microsoft SQL Server Enterprise | 483 912 ₸ за каждые 4 vCPU

\* Стоимость Windows Server Standard является фиксированной и не зависит от конфигурации ВМ


### Вычислительные ресурсы хостов {#prices-hosts}

Ресурс | Цена за 1 час
----- | ----- 
**Intel Cascade Lake** |
100% vCPU | {{ sku|KZT|mdb.cluster.mssql.v2.cpu.c100|string }}
RAM (за 1 ГБ) | {{ sku|KZT|mdb.cluster.mssql.v2.ram|string }}


### Хранилище и резервные копии {#prices-storage}

Услуга | Цена за ГБ в месяц
----- | -----
Стандартное сетевое хранилище | {{ sku|KZT|mdb.cluster.network-hdd.mssql|month|string }}
Быстрое сетевое хранилище | {{ sku|KZT|mdb.cluster.network-nvme.mssql|month|string }} |
Быстрое локальное хранилище | {{ sku|KZT|mdb.cluster.local-nvme.mssql|month|string }}
Резервные копии сверх размера хранилища | 15,2544 ₸