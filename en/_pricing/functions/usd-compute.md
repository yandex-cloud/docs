| Service | Price per 1 GB×hour, <br>without VAT |
| ----- | ----- |
| Functions execution, 10 GB×hour or less per month | {{ sku|USD|serverless.functions.compute.v1|string }} |
| Functions execution, over 10 GB×hour per month | {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} |
