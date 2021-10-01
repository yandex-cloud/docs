Ресурс | Цена за ГБ в месяц, вкл. НДС
--- | ---
Объем диска, до 10 ГБ | {{ sku|USD|network.egress.inet|string }}
Объем диска, сверх 10 ГБ | {{ sku|USD|nbs.network-nvme.allocated|month|string }}