| Service | Price of 1 GB, without VAT |
| ---- | ---- |
| Data writes, first 5 GB per month | {{ sku|USD|logging.ingested.traffic|string }}  |
| Data writes, over 5 GB per month | {{ sku|USD|logging.ingested.traffic|pricingRate.5|string }} |