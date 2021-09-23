{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

Услуга | Цена за ГБ в месяц
----- | -----
Стандартное сетевое хранилище | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}
Нереплицируемое сетевое хранилище | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }}
Быстрое сетевое хранилище | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}
Быстрое локальное хранилище | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}
Холодные данные гибридного хранилища и их резервные копии   | {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }}
Резервные копии локального и сетевых хранилищ | 15,2544 ₸
