| Service | Cost of 1 million invocations, with VAT |
| --- | --- |
| Invoking a function, <1 000 000 invocations per month | {{ sku|RUB|serverless.functions.invocations.v1|string }} |
| Invoking a function, >1 000 000 invocations per month | {{ sku|RUB|serverless.functions.invocations.v1|pricingRate.1|string }} |
