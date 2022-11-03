| Услуга                                  | Цена за ГБ в месяц                                        |
| ----- | ----- |
| Хранилище на сетевых HDD-дисках         | {{ sku|ILS|mdb.cluster.network-hdd.mysql|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|ILS|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | {{ sku|ILS|mdb.cluster.network-nvme.mysql|month|string }} |
