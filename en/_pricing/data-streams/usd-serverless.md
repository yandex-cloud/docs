| Service | Price | Billing unit |
| --- | --- | --- |
| Yandex Data Streams. Data operations, from 0 to 1 billing units per month | {{ sku|USD|yds.v1.serverless.requests|string }} | 1 million RU |
| Yandex Data Streams. Data operations, from 1 billing units per month | {{ sku|USD|yds.v1.serverless.requests|pricingRate.1|string }}  | 1 million RU |
| Yandex Data Streams. Data storage, from 0 to 720 billing units per month | {{ sku|USD|yds.v1.serverless.storage|string }} | GB × hour |
| Yandex Data Streams. Data storage, from 720 billing units per month | {{ sku|USD|yds.v1.serverless.storage|pricingRate.720|string }} | GB × hour |