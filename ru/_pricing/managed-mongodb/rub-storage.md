{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                          |
|-----------------------------------------|-------------------------------------------------------------|
| Стандартное сетевое хранилище           | {{ sku|RUB|mdb.cluster.network-hdd.mongodb|month|string }}  |
| Быстрое сетевое хранилище               | {{ sku|RUB|mdb.cluster.network-nvme.mongodb|month|string }} |
| Быстрое локальное хранилище             | {{ sku|RUB|mdb.cluster.local-nvme.mongodb|month|string }}   |
| Резервные копии сверх размера хранилища | 2,5424 ₽                                                    |
