{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                  |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках         | {{ sku|KZT|mdb.cluster.network-hdd.pg|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|KZT|mdb.cluster.network-nvme.pg|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|mdb.cluster.local-nvme.pg|month|string }}                |
| Резервные копии сверх размера хранилища | 9,60 ₸                                                              |
