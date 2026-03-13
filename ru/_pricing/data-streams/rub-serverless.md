| Услуга | Цена | Ед. тарификации |
| --- | --- | --- |
| Yandex Data Streams. Фактическое потребление Request Units, от 0 до 1 единицы тарификации в месяц | {{ sku|RUB|yds.v1.serverless.requests|string }} | 1 млн RU |
| Yandex Data Streams. Фактическое потребление Request Units, от 1 единицы тарификации в месяц | {{ sku|RUB|yds.v1.serverless.requests|pricingRate.1|string }} | 1 млн RU |
| Yandex Data Streams. Хранение данных, от 0 до 720 единиц тарификации в месяц | {{ sku|RUB|yds.v1.serverless.storage|string }} | ГБ × час |
| Yandex Data Streams. Хранение данных, от 720 единиц тарификации в месяц | {{ sku|RUB|yds.v1.serverless.storage|pricingRate.720|string }} | ГБ × час |