    | Service | Price of 1,000,000 invocations, <br>without VAT |
    | ----- | ----- |
    | Invoking a function, less than 1,000,000 invocations per month | {{ sku|USD|serverless.functions.invocations.v1|string }} |
    | Invoking a function, over 1,000,000 invocations per month | {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} |