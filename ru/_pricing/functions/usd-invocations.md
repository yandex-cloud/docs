    | Service | Cost of 1 million invokes, <br>without VAT |
    | ----- | ----- |
    | Invoking a function, <1 000 000 invocations per month | {{ sku|USD|serverless.functions.invocations.v1|string }} |
    | Invoking a function, >1 000 000 invocations per month | {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} |
