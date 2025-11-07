| Service | Price of 1,000,000 invocations, <br>without VAT |
| ----- | ----- |
| Invoking a container, Less than 1,000,000 invocations per month | {{ sku|USD|serverless.containers.invocations|string }} |
| Invoking a container, over 1,000,000 invocations per month | {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }} |