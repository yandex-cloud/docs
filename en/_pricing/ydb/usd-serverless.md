All prices are net of VAT. Prices are given for a 30-day month. For shorter months, the cost is higher. For longer months, it is lower.

| Service | Price, without VAT |
---------------------------------------------------------- | -------------------------------
| Data operations, less than 1 million RUs per month | {{ sku|USD|ydb.v1.serverless.requests|string }} |
| Data operations, over 1 million RUs per month | {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RUs |
| Data operations with one-month commitment | {% calc [currency=USD] {{ sku|USD|ydb.v1.serverless.provisioned_rcu|number }} × 100 %} per hour per 100 RU/s |
| Data storage, less than 1 GB per month | {{ sku|USD|ydb.v1.serverless.storage|month|string }} |
| Data storage, over 1 GB per month | {{ sku|USD|ydb.v1.serverless.storage|pricingRate.720|month|string }} per 1 GB per month |
| Storage of on-demand backups in {{ objstorage-full-name }} | {{ sku|USD|ydb.db.backup.v1|month|string }} per 1 GB per month |