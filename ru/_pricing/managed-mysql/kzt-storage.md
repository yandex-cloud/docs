{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                     |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | 9,60 ₸                                                                 |
