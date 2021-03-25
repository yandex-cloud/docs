| Service | Price per 1 GB×hour, <br>with VAT |
| ----- | ----- |
| Functions execution, <1 GB×hour per month | {{ sku|RUB|serverless.functions.compute.v1|string }} |
| Functions execution, >1 GB×hour per month | {{ sku|RUB|serverless.functions.compute.v1|pricingRate.10|string }} |
