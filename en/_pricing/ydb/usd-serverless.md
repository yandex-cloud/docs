## Pricing {#prices}

All prices are shown without VAT. Prices are given for a 30-day month. For shorter months, the price is higher. For longer months, it's lower.

| Service                                                    | Cost, without VAT |
----------------------------------------------------------   | -------------------------------
| Data operations, less than 1 million RUs per month          | {{ sku|USD|ydb.v1.serverless.requests|string }} |
| Data operations, over 1 million RUs per month               | {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU |
| Data operations with one-month commitment                | $0.028461 per hour per 100 RU/s |
| Data storage, less than 1 GB per month                     | {{ sku|USD|ydb.v1.serverless.storage|month|string }} |
| Data storage, over 1 GB per month                     | {{ sku|USD|ydb.cluster.v1.ssd|month|string }} per 1 GB per month |
| Storage of on-demand backups in {{ objstorage-full-name }} | $0.016166 per 1 GB per month |