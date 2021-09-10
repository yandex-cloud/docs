{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                  |
|-----------------------------------------|---------------------------------------------------------------------|
| Стандартное сетевое хранилище           | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}               |
| Нереплицируемое сетевое хранилище       | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }} |
| Быстрое сетевое хранилище               | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}              |
| Быстрое локальное хранилище             | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}                |
| Резервные копии сверх размера хранилища | 15,2544 ₸                                                           |
