| Service | Price per 1 GB×hour, <br>with VAT |
| ---- | ---- |
| RAM usage time, <10 GB×hour per month | {{ sku|KZT|serverless.containers.compute.memory|string }} |
| RAM usage time, >10 GB×hour per month | {{ sku|KZT|serverless.containers.compute.memory|pricingRate.10|string }} |