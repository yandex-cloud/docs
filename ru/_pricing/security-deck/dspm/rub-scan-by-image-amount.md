| Количество изображений | Стоимость за изображение,<br/>вкл. НДС |
| --- | --- |
| От 1 до 1000                | {{ sku|RUB|security_deck.dspm.scanned.image.v1|string }} |
| От 1001 до 10 000           | {{ sku|RUB|security_deck.dspm.scanned.image.v1|pricingRate.1000|string }} |
| От 10 001 до 100 000        | {{ sku|RUB|security_deck.dspm.scanned.image.v1|pricingRate.10000|string }} |
| От 100 001 до 1 000 000     | {{ sku|RUB|security_deck.dspm.scanned.image.v1|pricingRate.100000|string }} |
| От 1 000 001 до 10 000 000  | {{ sku|RUB|security_deck.dspm.scanned.image.v1|pricingRate.1000000|string }} |
| Более 10 000 000            | {{ sku|RUB|security_deck.dspm.scanned.image.v1|pricingRate.10000000|string }} |