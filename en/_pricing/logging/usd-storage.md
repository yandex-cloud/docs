| Service | Price per 1 GB per month, without VAT |
| --- | --- |
| Data storage, first 1 GB per month | {{ sku|USD|logging.storage.data|month|string }} |
| Data storage, over 1 GB per month | {{ sku|USD|logging.storage.data|pricingRate.720|month|string }} |