> {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }} × (2 × (150 / 3,600,000) × 3,000,000 – 10) + {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }} × (0.2 × (150 / 3,600,000) × 3,000,000 – 5) + {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }} × ((3,000,000 – 1,000,000) / 1,000,000)
>
> Total: {% calc [currency=USD] {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|number }} × (2 × (150 / 3600000) × 3000000 - 10) + {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|number }} × (0,2 × (150 / 3600000) × 3000000 - 5) + {{ sku|USD|serverless.containers.invocations|pricingRate.1|number }} × ((3000000 - 1000000) / 1000000) %}

Where:

* {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }}: Price per 1 GB×hour in excess of 10 GB×hour per month.
* 2: Amount of RAM.
* 150 / 3,600,000 converts milliseconds to hours, as RAM usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 10: RAM usage time free of charge.
* {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }}: Price per 1 hour of CPU usage in excess of 5 vCPUs × hour per month.
* 0.2: Number of vCPU cores.
* 150 / 3,600,000 converts milliseconds to hours, as CPU usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 5: CPU usage time free of charge.
* {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }}: Price per 1 million container invocations in excess of 1 million per month.
* 3,000,000: Number of container invocations.
* 1,000,000: Subtracted because the first million calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of container invocations.