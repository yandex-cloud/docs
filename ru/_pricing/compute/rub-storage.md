Тип  | Цена за ГБ в месяц, вкл. НДС
---  | ---
Быстрый диск (SSD) | {{ sku|RUB|nbs.network-nvme.allocated|month|string }}
Стандартный диск (HDD) | {{ sku|RUB|nbs.network-hdd.allocated|month|string }}
Нереплицируемый диск (SSD) | 5,5000 ₽
Снимок | {{ sku|RUB|compute.snapshot|month|string }}
Образ | {{ sku|RUB|compute.image|month|string }}