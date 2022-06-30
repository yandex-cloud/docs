| Service | Cost of 1 million invokes, <br>with VAT |
| ----- | ----- |
| Invoking a container, <1 000 000 invocations per month | {{ sku|RUB|serverless.containers.invocations|string }} |
| Invoking a container, >1 000 000 invocations per month | {{ sku|RUB|serverless.containers.invocations|pricingRate.1|string }} |