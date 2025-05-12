| Service | Price per 1 million calls, <br>without VAT |
| ----- | ----- |
| Function calls, 1 million or less calls per month | {{ sku|USD|serverless.functions.invocations.v1|string }} |
| Function calls, over 1 million invocations per month | {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} |
