> {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} × ((512 / 1,024) × (800 / 3,600 / 1,000) × 10,000,000 – 10) + {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} × ((10,000,000 – 1,000,000) / 1,000,000)
>
> Total: {% calc [currency=USD] {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|number }} × ((512 / 1024) × (800 / 3600000) × 10000000 - 10) + {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|number }} × ((10000000 - 1000000) / 1000000) %}

Where:
* {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }}: Price per GB/hr.
* 512 / 1,024: Converting MB to GB, since the execution time is calculated in GB/hr.
* 800 / 3,600 / 1,000: Converting milliseconds to hours, since the execution time is calculated in GB/hr.
* 10,000,000: Number of function calls.
* 10: Subtracted since the first 10 GB/hr are free of charge.
* {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }}: Price per 1,000,000 function calls.
* 10,000,000: Number of function calls.
* 1,000,000: Subtracted since the first 1,000,000 calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of function calls.