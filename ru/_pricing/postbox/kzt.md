|                          Услуга                                   | Цена за 1 000 писем, вкл. НДС |
|:------------------------------------------------------------------|------------------------------:|
| Исходящее электронное письмо, первые 2 000 писем в месяц          | {{ sku|KZT|postbox.email.count.v1|string }}                 |
| Исходящее электронное письмо, от 2 001 до 10 000 писем в месяц    | {{ sku|KZT|postbox.email.count.v1|pricingRate.2|string }}   |
| Исходящее электронное письмо, от 10 001 до 50 000 писем в месяц   | {{ sku|KZT|postbox.email.count.v1|pricingRate.10|string }}  |
| Исходящее электронное письмо, от 50 001 до 100 000 писем в месяц  | {{ sku|KZT|postbox.email.count.v1|pricingRate.50|string }}  |
| Исходящее электронное письмо, от 100 001 до 250 000 писем в месяц | {{ sku|KZT|postbox.email.count.v1|pricingRate.100|string }} |
| Исходящее электронное письмо, от 250 001 до 500 000 писем в месяц | {{ sku|KZT|postbox.email.count.v1|pricingRate.250|string }} |