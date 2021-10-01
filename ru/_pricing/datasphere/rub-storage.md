Ресурс | Цена за ГБ в месяц, вкл. НДС
--- | ---
Объем диска, до 10 ГБ | {{ sku|RUB|network.egress.inet|string }}
Объем диска, сверх 10 ГБ | {{ sku|RUB|nbs.network-nvme.allocated|month|string }}