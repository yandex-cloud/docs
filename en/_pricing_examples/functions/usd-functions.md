> {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} × ((512 / 1,024) × (800 / 3,600 / 1,000) × 10,000,000 – 10) + {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} × ((10,000,000 – 1,000,000) / 1,000,000)
>
> Total: {% calc [currency=USD] {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|number }} × ((512 / 1024) × (800 / 3600000) × 10000000 - 10) + {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|number }} × ((10000000 - 1000000) / 1000000) %}

Where:
* {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }}: Price per 1 GB×hour.
* 512 / 1,024 converts MB to GB, as execution time is calculated in GB×hour.
* 800 / 3,600 / 1,000 converts milliseconds to hours, as execution time is calculated in GB×hour.
* 10,000,000: Number of function calls.
* 10: Subtracted because the first 10 GB×hour are free of charge.
* {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }}: Price per 1 million function calls.
* 10,000,000: Number of function calls.
* 1,000,000: Subtracted because the first million calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of function calls.