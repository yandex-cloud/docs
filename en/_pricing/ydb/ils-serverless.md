## Pricing {#prices}

All prices are shown with VAT and refer to a 30-day month. For shorter months, the price is higher; for longer ones, it is lower.

| Data operations | Cost |
------------------------------------------------                    | ----------------------
| Actual (on-demand) consumption of Request Units, less than 1 million per month | {{ sku|ILS|ydb.v1.serverless.requests|string }} |
| Actual (on-demand) consumption of Request Units, over 1 million per month | {{ sku|ILS|ydb.v1.serverless.requests|pricingRate.1|string }} per 1 million RU |
| Provisioned capacity | {{ sku|ILS|ydb.v1.serverless.provisioned_rcu|string }} for 100 RU/s×hour |

| Other chargeable operations | Cost |
------------------------------------------------                    | ----------------------
| Data storage, less than 1 GB per month | {{ sku|ILS|ydb.v1.serverless.storage|month|string }} |
| Data storage, more than 1 GB per month | {{ sku|ILS|ydb.cluster.v1.ssd|month|string }} per 1 GB per month |
| Storage of on-demand backups in {{ objstorage-full-name }} | {{ sku|ILS|ydb.db.backup.v1|string }} per 1 GB per month |
