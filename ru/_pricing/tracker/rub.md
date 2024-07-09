| Количество пользователей <br>с полным доступом| Стоимость {{ tracker-full-name }} <br>за одного пользователя, <br>в месяц * |
| ----- | ----- |
| не более 5 | {{ sku|RUB|b2b.tracker.license.v1|int|string }} |
| 6–100 | {{ sku|RUB|b2b.tracker.license.v1|pricingRate.6|string }} (с учетом первых 5) |
| 101–250 | {{ sku|RUB|b2b.tracker.license.v1|pricingRate.100|string }} |
| 251+ | {{ sku|RUB|b2b.tracker.license.v1|pricingRate.250|string }} |

\* Цена указана с учетом НДС. При использовании промокодов могут применяться пониженные тарифы.