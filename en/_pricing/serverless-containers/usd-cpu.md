| Service | Price per vCPU×hour, <br>without VAT |
---- | ----
| CPU usage time, 5 vCPU×hour or less per month | {{ sku|USD|serverless.containers.compute.cpu|string }} |
| CPU usage time, over 5 vCPU×hour per month | {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }} |