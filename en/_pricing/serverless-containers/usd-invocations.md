| Service | Cost of 1 million invocations, <br>including VAT |
| ----- | ----- |
| Invoking a container, <1 million invocations per month | {{ sku|USD|serverless.containers.invocations|string }} |
| Invoking a container, >1 million invocations per month | {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }} |