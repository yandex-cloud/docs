{% if audience != "draft" %}   

| Услуга                                  | Цена {{ compute-name }}                                  | Цена MDB                                                               | Итоговая цена                                                          |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | -                                                        | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }}               | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | -                                                        | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | -                                                        | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }}              | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | 0,053974 $                                                             | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | -                                                        | 0,024615 $                                                             | 0,024615 $                                                             |

{% else %}

| Услуга                                  | Цена {{ compute-name }}                                  | Цена MDB                                                               | Итоговая цена                                                          |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | -                                                        | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }}               | {{ sku|USD|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | -                                                        | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|USD|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | -                                                        | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }}              | {{ sku|USD|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|USD|compute.hostgroup.localssd.v1|month|string }} | {{ sku|USD|mdb.cluster.local-nvme.mysql.dedicated|month|string }}      | {{ sku|USD|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | -                                                        | 0,024615 $                                                             | 0,024615 $                                                             |

{% endif %}
