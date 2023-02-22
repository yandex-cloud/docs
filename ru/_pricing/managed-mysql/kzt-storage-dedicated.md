{% if audience != "draft" %}

| Услуга                                  | Цена<br/>{{ compute-name }}                              | Цена MDB                                                               | Итоговая цена                                                          |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | -                                                        | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | -                                                        | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | -                                                        | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|compute.hostgroup.localssd.v1|month|string }} | 21,0500 ₸                                                              | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | -                                                        | 9,6000 ₸                                                               | 9,6000 ₸                                                               |

{% else %}

| Услуга                                  | Цена<br/>{{ compute-name }}                              | Цена MDB                                                               | Итоговая цена                                                          |
|-----------------------------------------|---------------------------------------------------------:|-----------------------------------------------------------------------:|-----------------------------------------------------------------------:|
| Хранилище на сетевых HDD-дисках         | -                                                        | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               | {{ sku|KZT|mdb.cluster.network-hdd.mysql|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках | -                                                        | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mysql|month|string }} |
| Хранилище на сетевых SSD-дисках         | -                                                        | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              | {{ sku|KZT|mdb.cluster.network-nvme.mysql|month|string }}              |
| Хранилище на локальных SSD-дисках       | {{ sku|KZT|compute.hostgroup.localssd.v1|month|string }} | {{ sku|KZT|mdb.cluster.local-nvme.mysql.dedicated|month|string }}      | {{ sku|KZT|mdb.cluster.local-nvme.mysql|month|string }}                |
| Резервные копии сверх размера хранилища | -                                                        | 9,6000 ₸                                                               | 9,6000 ₸                                                               |

{% endif %}
