| Услуга                                                | Цена за ГБ в месяц                                                       |
| ----- | ----: |
| Хранилище на сетевых HDD-дисках                       | {{ sku|KZT|mdb.cluster.network-hdd.mongodb|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках^*^   | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }} |
| Хранилище на сетевых SSD-дисках                       | {{ sku|KZT|mdb.cluster.network-nvme.mongodb|month|string }}              |
| Сверхбыстрое сетевое хранилище с тремя репликами (SSD) | 108,90 ₸ |
| Хранилище на локальных SSD-дисках^*^         | {{ sku|KZT|mdb.cluster.local-nvme.mongodb|month|string }}                |
| Резервные копии сверх размера хранилища               | 9,60 ₸                                                                   |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
