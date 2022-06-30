| Service | Price per vCPU×hour, <br>with VAT |
| ---- | ---- |
| CPU usage time, <5 vCPU×hour per month | {{ sku|RUB|serverless.containers.compute.cpu|string }} |
| CPU usage time, >5 vCPU×hour per month | {{ sku|RUB|serverless.containers.compute.cpu|pricingRate.5|string }} |