| Услуга                                                 | Цена за ГБ в месяц,<br>вкл. НДС                                          |
| ------------------------------------------------------ | -----------------------------------------------------------------------: |
| Хранилище на сетевых HDD-дисках                        | {{ sku|KZT|mdb.cluster.network-hdd.mongodb|month|string }}               |
| Хранилище на нереплицируемых SSD-дисках^*^             | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.mongodb|month|string }} |
| Хранилище на сетевых SSD-дисках                        | {{ sku|KZT|mdb.cluster.network-nvme.mongodb|month|string }}              |
| Сверхбыстрое сетевое хранилище с тремя репликами (SSD) | {{ sku|KZT|mdb.cluster.network-ssd-io-m3.mongodb|month|string }}         |
| Хранилище на локальных SSD-дисках^*^                   | {{ sku|KZT|mdb.cluster.local-nvme.mongodb|month|string }}                |
| Резервные копии сверх размера хранилища                | {{ sku|KZT|mdb.cluster.mongodb.backup|month|string }}                    |

{% include [storage-limitations-mmg](../../_includes/mdb/mmg/storage-limitations-note.md) %}
