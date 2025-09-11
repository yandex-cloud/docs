| Объем сканируемых данных | Стоимость за ГБ,<br/>вкл. НДС |
| --- | --- |
| От 1 до 10 ГБ      | {{ sku|RUB|security_deck.dspm.scanned.text.v1|string }} |
| От 10 до 100 ГБ    | {{ sku|RUB|security_deck.dspm.scanned.text.v1|pricingRate.10|string }} |
| От 100 до 1 000 ГБ | {{ sku|RUB|security_deck.dspm.scanned.text.v1|pricingRate.100|string }} |
| От 1 до 10 ТБ      | {{ sku|RUB|security_deck.dspm.scanned.text.v1|pricingRate.1024|string }} |
| От 10 до 100 ТБ    | {{ sku|RUB|security_deck.dspm.scanned.text.v1|pricingRate.10240|string }} |
| От 100 до 1 000 ТБ | {{ sku|RUB|security_deck.dspm.scanned.text.v1|pricingRate.102400|string }} |