## Pricing {#prices}

All prices are shown with VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

Service | Cost, with VAT
---------------------------------------------------------- | ------------------------------- 
Data operations, less than 1 million RU per months         | {{ sku|ILS|ydb.v1.serverless.requests|string }}
Data operations, over 1 million RU per month               | {{ sku|ILS|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU
Data operations with a 1-month commitment                  | ₽3.55 per hour per 100 RU/s
Data storage, less than 1 GB per month                     | {{ sku|ILS|ydb.v1.serverless.storage|month|string }}
Data storage, more than 1 GB per month                     | {{ sku|ILS|ydb.cluster.v1.ssd|month|string }} per 1 GB per month
Making on-demand backups                                   | ₽0.54 per 1 GB
Restoring data from backups                                | ₽10.24 per 1 GB
Storage of on-demand backups in {{ objstorage-full-name }} | ₽2.01 per 1 GB per month