| Услуга                                                    | Цена за ГБ в месяц                                          |
|-----------------------------------------------------------|-------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках                           | {{ sku|RUB|mdb.cluster.network-hdd.mongodb|month|string }}  |
| Хранилище на нереплицируемых SSD-дисках<sup>*</sup>       | 5,5000 ₽                                                    |
| Хранилище на сетевых SSD-дисках                           | {{ sku|RUB|mdb.cluster.network-nvme.mongodb|month|string }} |
| Хранилище на локальных SSD-дисках<sup>*</sup>             | {{ sku|RUB|mdb.cluster.local-nvme.mongodb|month|string }}   |
| Резервные копии сверх размера хранилища                   | 2,5424 ₽                                                    |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
