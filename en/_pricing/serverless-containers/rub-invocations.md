| Service | Cost of 1 million calls, <br>including VAT |
| ---- | ---- |
| Container calls, 1 million or less per month | {{ sku|RUB|serverless.containers.invocations|string }} |
| Container calls, over 1 million per month | {{ sku|RUB|serverless.containers.invocations|pricingRate.1|string }} |