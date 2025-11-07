Service | Price per GB/hr, <br>without VAT
---- | ----
RAM usage time, Less than 10 GB/hr per month | {{ sku|USD|serverless.containers.compute.memory|string }}
RAM usage time, over 10 GB/hr per month | {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }}