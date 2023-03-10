
| Услуга                                  | Цена<br/>{{ compute-name }}                              | Цена MDB                                                               | Итоговая цена                                                          |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | -                                                        | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }}               | {{ sku|RUB|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | -                                                        | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | -                                                        | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }}              | {{ sku|RUB|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|compute.hostgroup.localssd.v1|month|string }} | 4,2100 ₽                                                               | {{ sku|RUB|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | -                                                        | 1,9200 ₽                                                               | 1,9200 ₽                                                               |

