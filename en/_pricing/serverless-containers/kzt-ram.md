| Service | Price per GB×hour, <br>including VAT |
| ---- | ---- |
| RAM usage time, 10 GB×hour or less per month | {{ sku|KZT|serverless.containers.compute.memory|string }} |
| RAM usage time, over 10 GB×hour per month | {{ sku|KZT|serverless.containers.compute.memory|pricingRate.10|string }} |