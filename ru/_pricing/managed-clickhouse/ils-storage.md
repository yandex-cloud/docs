| Услуга                                  | Цена за ГБ в месяц                                                            |
|-----------------------------------------|-------------------------------------------------------------------------------|
| Хранилище на сетевых HDD-дисках         | {{ sku|ILS|mdb.cluster.network-hdd.ch|month|string }}                         |
| Хранилище на нереплицируемых SSD-дисках | {{ sku|ILS|mdb.cluster.network-ssd-nonreplicated.ch|month|string }}           |
| Хранилище на сетевых SSD-дисках         | {{ sku|ILS|mdb.cluster.network-nvme.ch|month|string }}                        |
| Холодные данные гибридного хранилища и их резервные копии   | {{ sku|ILS|storage.bucket.used_space.standard|pricingRate.720|month|string }} |
