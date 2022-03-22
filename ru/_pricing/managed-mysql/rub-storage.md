{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

|Услуга | Цена за ГБ в месяц| |
|----- | -----| ---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }}               | 3,20 ₽|
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | 8,80 ₽ |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }}              | 13,01 ₽ |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }}                | 13,01 ₽ |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                               | 1,92 ₽ |
