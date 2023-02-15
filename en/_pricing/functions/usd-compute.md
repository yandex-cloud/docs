    | Service | Price per 1 GB×hour, <br>without VAT |
    | ----- | ----- |
    | Functions execution, 1 GB×hour or less per month | {{ sku|USD|serverless.functions.compute.v1|string }} |
    | Functions execution, over 1 GB×hour per month | {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} |
