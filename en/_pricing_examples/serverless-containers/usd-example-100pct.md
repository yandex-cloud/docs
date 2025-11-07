> {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }} × (2 × (150 / 3,600,000) × 3,000,000 – 10) + {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }} × (1 × (150 / 3,600,000) × 3,000,000 – 5) + {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }} × ((3,000,000 – 1,000,000) / 1,000,000)
>
> Total: {% calc [currency=USD] {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|number }} × (2 × (150 / 3600000) × 3000000 - 10) + {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|number }} × (1 × (150 / 3600000) × 3000000 - 5) + {{ sku|USD|serverless.containers.invocations|pricingRate.1|number }} × ((3000000 - 1000000) / 1000000) %}

Where:

* {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }}: Price per 1 GB/hr (over 10 GB/hr per month).
* 2: Amount of RAM.
* 150 / 3,600,000: Converting milliseconds to hours, since RAM usage time is calculated in GB/hr.
* 3,000,000: Number of container invocations.
* 10: RAM usage time that is free of charge.
* {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }}: Price per hour of CPU usage beyond 5 vCPU/hr per month.
* 1 : Number of vCPU cores.
* 150 / 3,600,000: Converting milliseconds to hours, since CPU usage time is calculated in GB/hr.
* 3,000,000: Number of container invocations.
* 5: CPU usage time that is free of charge.
* {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }}: Price per 1,000,000 container invocations beyond 1,000,000 per month.
* 3,000,000: Number of container invocations.
* 1,000,000: Subtracted since the first 1,000,000 calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of container invocations.