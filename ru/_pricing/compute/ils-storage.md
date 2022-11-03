| Тип  | Цена за ГБ в месяц, вкл. НДС |
| ---  | --- |
| Быстрый диск (SSD) | {{ sku|ILS|nbs.network-nvme.allocated|month|string }} | 
| Стандартный диск (HDD) | {{ sku|ILS|nbs.network-hdd.allocated|month|string }} | 
| Нереплицируемый диск (SSD) | {{ sku|ILS|nbs.network-ssd-nonreplicated.allocated|month|string }} | 
| Снимок | {{ sku|ILS|compute.snapshot|month|string }} |
| Образ | {{ sku|ILS|compute.image|month|string }} |