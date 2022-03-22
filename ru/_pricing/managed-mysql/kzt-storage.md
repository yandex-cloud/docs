{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

|Услуга | Цена за ГБ в месяц| |
|----- | -----| ---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               | 16,00 ₸ |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | 44,00 ₸ |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              | 65,00 ₸ |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                | 65,00 ₸ |
| Резервные копии сверх размера хранилища | 15,2544 ₸                                                              | 9,60 ₸ |
