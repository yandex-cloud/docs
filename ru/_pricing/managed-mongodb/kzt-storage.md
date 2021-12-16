| Услуга                                                | Цена за ГБ в месяц                                          |
|-------------------------------------------------------|-------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках                       | {{ sku|KZT|mdb.cluster.network-hdd.mongodb|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках<sup>*</sup>   | 33,0000 ₸                                                   |
| Хранилище на сетевых SSD-дисках                       | {{ sku|KZT|mdb.cluster.network-nvme.mongodb|month|string }} |
| Хранилище на локальных SSD-дисках<sup>*</sup>         | {{ sku|KZT|mdb.cluster.local-nvme.mongodb|month|string }}   |
| Резервные копии сверх размера хранилища               | 15,2544 ₸                                                   |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
