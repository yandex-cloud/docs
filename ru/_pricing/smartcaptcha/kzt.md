| Услуга | Цена за 1 000 запросов, вкл. НДС |
| --- | --- |
| Запросы к API {{ captcha-name }}, первые 10 000 в месяц | {{ sku|KZT|smart_captcha.check.requests.v1|string }} |
| Запросы к API {{ captcha-name }}, от 10 001 до 100 000 в месяц | {{ sku|KZT|smart_captcha.check.requests.v1|pricingRate.10|string }} |
| Запросы к API {{ captcha-name }}, свыше 100 000 в месяц | {{ sku|KZT|smart_captcha.check.requests.v1|pricingRate.100|string }} |