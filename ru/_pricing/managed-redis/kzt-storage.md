| Услуга                                                            | Цена за ГБ в месяц                                                     |
| --- | --- |
| Хранилище на нереплицируемых SSD-дисках<sup>*</sup>               | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.redis|month|string }} |
| Хранилище на сетевых SSD-дисках                                   | {{ sku|KZT|mdb.cluster.network-nvme.redis|month|string }}              |
| Хранилище на локальных SSD-дисках<sup>*</sup>                     | {{ sku|KZT|mdb.cluster.local-nvme.redis|month|string }}                |
| Резервные копии сверх размера хранилища                           | 9,60 ₸                                                                 |

{% include [storage-limitations-mrd](../../_includes/mdb/mrd/storage-limitations-note.md) %}
