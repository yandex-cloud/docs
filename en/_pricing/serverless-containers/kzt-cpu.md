| Service | Price per vCPU×hour, <br>including VAT |
| ---- | ---- |
| CPU usage time, 5 vCPUs×hour or less per month | {{ sku|KZT|serverless.containers.compute.cpu|string }} |
| CPU usage time, over 5 vCPUs×hour per month | {{ sku|KZT|serverless.containers.compute.cpu|pricingRate.5|string }} |