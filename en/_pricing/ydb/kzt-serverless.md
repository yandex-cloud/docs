## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

| Data operations                                                        | Cost |
------------------------------------------------                         | ----------------------
| Actual (on-demand) consumption of RUs, less than 1 million per month   | Free |
| Actual (on-demand) consumption of RUs, over 1 million per month        | {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU |
| Provisioned capacity                                                   | ₸17.76 per 100 RU/s×hour |

| Other chargeable operations | Cost |
------------------------------------------------                         | ----------------------
| Data storage, less than 1 GB per month                                 | Free |
| Data storage, over 1 GB per month                                 | {{ sku|KZT|ydb.cluster.v1.ssd|month|string }} per 1 GB per month |
| Storage of on-demand backups in {{ objstorage-full-name }}             | ₸10.05 per 1 GB per month |
