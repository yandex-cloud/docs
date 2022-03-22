## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

Service | Cost, with VAT | |
---------------------------------------------------------- | ------------------------------- | -----
| | **Up until April 12, 2022** | **Starting April 13, 2022** |
Data operations, less than 1 million RU per months         | {{ sku|KZT|ydb.v1.serverless.requests|string }} | {{ sku|KZT|ydb.v1.serverless.requests|string }}
Data operations, over 1 million RU per month               | {{ sku|KZT|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU | ₸106.88 per 1 million RU
Data operations with a 1-month commitment                  | ₸13.3200 per hour per 100 RU/s | ₸17.76 per hour per 100 RU/s
Data storage, less than 1 GB per month                     | {{ sku|KZT|ydb.v1.serverless.storage|month|string }} | {{ sku|KZT|ydb.v1.serverless.storage|month|string }}
Data storage, more than 1 GB per month                     | {{ sku|KZT|ydb.cluster.v1.ssd|month|string }} per 1 GB per month | ₸107.28 per 1 GB per month
Making on-demand backups                                   | ₸2.0400 per 1 GB | ₸2.72 per 1 GB
Restoring data from backups                                | ₸38.4000 per 1 GB | ₸51.20 per 1 GB
Storage of on-demand backups in {{ objstorage-full-name }} | ₸7.5660 per 1 GB per month | ₸10.05 per 1 GB per month
