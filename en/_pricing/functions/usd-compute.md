    | Service | Price per GB/hr, <br>without VAT |
    | ----- | ----- |
    | Functions execution, less than 10 GB/hr per month | {{ sku|USD|serverless.functions.compute.v1|string }} |
    | Functions execution, over 10 GB/hr per month | {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} |