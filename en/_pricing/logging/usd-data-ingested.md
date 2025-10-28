| Service | Price per GB, without VAT |
| ---- | ---- |
| Data writes, 5 GB or less per month | {{ sku|USD|logging.ingested.traffic|string }} |
| Data writes, over 5 GB per month | {{ sku|USD|logging.ingested.traffic|pricingRate.5|string }} |