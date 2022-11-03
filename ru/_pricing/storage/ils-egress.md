| Категория ресурса | Цена за ГБ, вкл. НДС |
| --- | --- |
| Исходящий трафик, до 10 ГБ в месяц | {{ sku|ILS|storage.api.network.inet.egress|string }} |
| Исходящий трафик, сверх 10 ГБ до 1 ТБ | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.10|string }} |
| Исходящий трафик, сверх 1 ТБ до 50 ТБ | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.1024|string }} |
| Исходящий трафик, сверх 50 ТБ до 100 ТБ | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.51200|string }} |
| Исходящий трафик, сверх 100 ТБ | {{ sku|ILS|storage.api.network.inet.egress|pricingRate.102400|string }} |