| Услуга                                  | Цена за ГБ в месяц                                                  |
| ----- | ----: |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.pg|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.pg|month|string }}              |
| Сверхбыстрое сетевое хранилище с тремя репликами (SSD) | 21,78 ₽ |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.pg|month|string }}                |
| Резервные копии сверх размера хранилища | {{ sku|RUB|mdb.cluster.pg.backup|month|string }}                    |
