| Ресурс        | Цена за ГБ в месяц,<br>вкл. НДС |
|---------------|-----------------------------:|
| Хранилище на сетевых HDD-дисках | {% calc [currency=RUB] {{ sku|RUB|yt.storage.hdd.v1|month|number }} %} |
| Хранилище на нереплицируемых SSD-дисках | {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd-nonreplicated.v1|month|number }} %} |
| Хранилище на сетевых SSD-дисках | {% calc [currency=RUB] {{ sku|RUB|yt.storage.ssd.v1|month|number }} %} |
