| Услуга                                                    | Цена за ГБ в месяц                                                       |
| ----- | ---: |
| Хранилище на сетевых HDD-дисках                           | {{ sku|RUB|mdb.cluster.network-hdd.mongodb|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках^*^       | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }} |
| Хранилище на сетевых SSD-дисках                           | {{ sku|RUB|mdb.cluster.network-nvme.mongodb|month|string }}              |
| Сверхбыстрое сетевое хранилище с тремя репликами (SSD) | {{ sku|RUB|mdb.cluster.network-ssd-io-m3.mongodb|month|string }} |
| Хранилище на локальных SSD-дисках^*^             | {{ sku|RUB|mdb.cluster.local-nvme.mongodb|month|string }}                |
| Резервные копии сверх размера хранилища                   | {{ sku|RUB|mdb.cluster.mongodb.backup|month|string }} |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
