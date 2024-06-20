| Услуга                                  | Цена за ГБ в месяц                                                             |
| --------------------------------------- | -----------------------------------------------------------------------------: |
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.elasticsearch|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.elasticsearch|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.elasticsearch|month|string }}              |
| Хранилище на сетевых SSD-дисках с тремя репликами | 21,78 ₽ |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.elasticsearch|month|string }}                |
| Резервные копии сверх размера хранилища | 1,92 ₽                                                                         |