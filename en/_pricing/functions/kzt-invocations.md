| Service | Cost of 1 million invocations, <br>with VAT |
| ----- | ----- |
| Invoking a function, <1 000 000 invocations per month | {{ sku|KZT|serverless.functions.invocations.v1|string }} |
| Invoking a function, >1 000 000 invocations per month | {{ sku|KZT|serverless.functions.invocations.v1|pricingRate.1|string }} |
