| Услуга                                  | Цена за ГБ в месяц                                     |
| --------------------------------------- | ------------------------------------------------------ |
| Хранилище на сетевых HDD-дисках         | {{ sku|ILS|mdb.cluster.network-hdd.pg|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|ILS|mdb.cluster.network-ssd-nonreplicated.pg|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|ILS|mdb.cluster.network-nvme.pg|month|string }} |
