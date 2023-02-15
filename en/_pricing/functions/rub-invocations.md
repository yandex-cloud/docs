| Service | Cost of 1 million calls, including VAT |
| --- | --- |
| Function calls, 1 million or less per month | {{ sku|RUB|serverless.functions.invocations.v1|string }} |
| Function calls, over 1 million per month | {{ sku|RUB|serverless.functions.invocations.v1|pricingRate.1|string }} |
