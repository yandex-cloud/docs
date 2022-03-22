{% include [local-ssd для Ice Lake только по запросу](../../_includes/ice-lake-local-ssd-note.md) %}

|Услуга | Цена за ГБ в месяц| |
|----- | -----| ---|
| | **До 12 апреля 2022<br>включительно** | **С 13 апреля 2022** |
|Хранилище на сетевых HDD-дисках | {{ sku|KZT|mdb.cluster.network-hdd.ch|month|string }}| 16,00 ₸ |
|Хранилище на нереплицируемых SSD-дисках | {{ sku|KZT|mdb.cluster.network-ssd-nonreplicated.ch|month|string }}| 44,00 ₸ |
|Хранилище на сетевых SSD-дисках | {{ sku|KZT|mdb.cluster.network-nvme.ch|month|string }}| 65,05 ₸ |
|Хранилище на локальных SSD-дисках | {{ sku|KZT|mdb.cluster.local-nvme.ch|month|string }}| 65,05 ₸ |
|Холодные данные гибридного хранилища и их резервные копии   | {{ sku|KZT|storage.bucket.used_space.standard|pricingRate.720|month|string }}| 10,05 ₸ |
|Резервные копии хранилища на локальных и сетевых дисках | 15,2544 ₸| 9,60 ₸ |
