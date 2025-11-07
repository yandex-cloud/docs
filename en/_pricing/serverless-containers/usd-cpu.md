Service | Price per vCPU/hr, <br>without VAT
---- | ----
CPU usage time, Less than 5 vCPU/hr per month | {{ sku|USD|serverless.containers.compute.cpu|string }}
CPU usage time, over 5 vCPU/hr per month | {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }}