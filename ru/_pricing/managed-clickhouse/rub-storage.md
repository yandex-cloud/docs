{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

| Услуга                                  | Цена за ГБ в месяц                                                            |
|-----------------------------------------|-------------------------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках         | {{ sku|RUB|mdb.cluster.network-hdd.ch|month|string }}                         |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|RUB|mdb.cluster.network-ssd-nonreplicated.ch|month|string }}           |
| Хранилище на сетевых SSD-дисках         | {{ sku|RUB|mdb.cluster.network-nvme.ch|month|string }}                        |
| Хранилище на локальных SSD-дисках       | {{ sku|RUB|mdb.cluster.local-nvme.ch|month|string }}                          |
| Холодные данные гибридного хранилища и их резервные копии                     | {{ sku|RUB|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
| Резервные копии хранилища на локальных и сетевых дисках | 1,92 ₽ |
