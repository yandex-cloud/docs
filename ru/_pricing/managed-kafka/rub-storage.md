{% include [local-ssd for Intel Ice Lake only by request](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                            | Цена за ГБ в месяц                                                     |
|-----------------------------------|------------------------------------------------------------------------|
| Стандартное сетевое хранилище     | {{ sku|RUB|mdb.cluster.network-hdd.kafka|month|string }}               |
| Нереплицируемое сетевое хранилище | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.kafka|month|string }} |
| Быстрое сетевое хранилище         | {{ sku|RUB|mdb.cluster.network-nvme.kafka|month|string }}              |
| Быстрое локальное хранилище       | {{ sku|RUB|mdb.cluster.local-nvme.kafka|month|string }} *              |

\* Хранилище выделенных хостов оплачивается по тарифам, указанным в [документации {{ compute-full-name }}](../../compute/pricing.md#prices).