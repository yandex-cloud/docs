## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

| Data operations                                                                | Cost |
------------------------------------------------                                 | ----------------------
| Actual (on-demand) consumption of Request Units, less than 1 million per month | Free |
| Actual (on-demand) consumption of Request Units, over 1 million per month | {{ sku|RUB|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU |
| Provisioned capacity                                                           | ₽3.55 per 100 RU/s×hour |

| Other chargeable operations                                                    | Cost |
------------------------------------------------                                 | ----------------------
| Data storage, less than 1 GB per month                                         | Free |
| Data storage, over 1 GB per month                                         | {{ sku|RUB|ydb.cluster.v1.ssd|month|string }} per 1 GB per month |
| Storage of on-demand backups in {{ objstorage-full-name }}                     | ₽2.01 per 1 GB per month |
