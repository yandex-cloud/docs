---
editable: false
---

# {{ serverless-containers-name }} pricing



## What goes into the cost of using {{ serverless-containers-name }} {#rules}

In {{ serverless-containers-name }}, you are billed for the number of container invocations, computing resources allocated for the application, downtime of [provisioned instances](concepts/container.md#provisioned-instances), and outgoing traffic.

Computing resources are billed based on the number of processor cores (vCPUs), the [level of core performance](../compute/concepts/performance-levels.md), memory allocated for the application, and application running time:
* The number of cores specified when creating a revision is measured in vCPUs and is a positive real number.
* The core performance level specified when creating a revision is measured in %.
* The memory size specified when creating a revision is measured in GB.
* The total container time is measured in hours and is rounded up to a multiple of 100 ms.

{% note warning %}

You are only charged for the container invocations that have caused your application to run.

{% endnote %}

### Pricing formula {#formula}



Monthly cost = {{ sku|USD|serverless.containers.compute.memory|pricingRate.10|string }} × Memory (GB) × Invocation processing time (Hours) + {{ sku|USD|serverless.containers.compute.cpu|pricingRate.5|string }} × Number of cores × Invocation processing time (Hours) + {{ sku|USD|serverless.containers.invocations|pricingRate.1|string }} × Millions of invocations


{% include [not-charged-sc.md](../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Examples of cost calculation {#example}

Example of calculating the cost of a container with the following parameters:
* **Memory specified when creating a revision**: 2 GB
* **Number of cores**: 20% vCPU
* **Number of container invocations**: 3,000,000
* **Execution time of each call**: 150 ms



> 0.0256 × (2 × (150 / 3,600,000) × 3,000,000 – 10) + 0.0384 × (0.2 × (150 / 3,600,000) × 3,000,000 – 5) + 0.1280 × ((3,000,000 – 1,000,000) / 1,000,000)
>
> Total: $7.1680

Where:
* 0.0256: Price per 1 GB×hour in excess of 10 GB×hour per month.
* 2: Amount of RAM.
* 150 / 3,600,000 converts milliseconds to hours, as RAM usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 10: RAM usage time free of charge.
* 0.0384: Price per 1 hour of CPU usage in excess of 5 vCPUs × hour per month.
* 0.2: Number of vCPU cores.
* 150 / 3,600,000 converts milliseconds to hours, as CPU usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 5: CPU usage time free of charge.
* 0.1280: Price per 1 million container invocations in excess of 1 million per month.
* 3,000,000: Number of container invocations.
* 1,000,000: Subtracted because the first million invocations are free of charge.
* 1,000,000: Divisor to calculate the number of millions of container invocations.


Example of calculating the cost of a container with the following parameters:
* **Memory specified when creating a revision**: 2 GB
* **Number of cores**: 100% vCPU
* **Number of container invocations**: 3,000,000
* **Execution time of each call**: 150 ms



> 0.0256 × (2 × (150 / 3,600,000) × 3,000,000 – 10) + 0.0384 × (1 × (150 / 3,600,000) × 3,000,000 – 5) + 0.1280 × ((3,000,000 – 1,000,000) / 1,000,000)
>
> Total: $11.0080

Where:
* 0.0256: Price per 1 GB×hour in excess of 10 GB×hour per month.
* 2: Amount of RAM.
* 150 / 3,600,000 converts milliseconds to hours, as RAM usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 10: RAM usage time free of charge.
* 0.0384: Price per 1 hour of CPU usage in excess of 5 vCPUs × hour per month.
* 1: Number of vCPU cores.
* 150 / 3,600,000 converts milliseconds to hours, as CPU usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 5: CPU usage time free of charge.
* 0.1280: Price per 1 million container invocations in excess of 1 million per month.
* 3,000,000: Number of container invocations.
* 1,000,000: Subtracted because the first million invocations are free of charge.
* 1,000,000: Divisor to calculate the number of millions of container invocations.


## Prices for the Russia region {#prices}


### Invoking a container {#prices-invoking}



{% include notitle [usd-invocation.md](../_pricing/serverless-containers/usd-invocations.md) %}


### RAM usage time when processing requests {#prices-ram}



{% include notitle [usd-ram.md](../_pricing/serverless-containers/usd-ram.md) %}


### CPU usage time when processing requests {#prices-cpu}



{% include notitle [usd-cpu.md](../_pricing/serverless-containers/usd-cpu.md) %}


### Provisioned instances {#provisioned-instances}

#### RAM usage time {#prices-ram-provisioned-instances}



{% include notitle [usd-ram-provisioned-instances.md](../_pricing/serverless-containers/usd-ram-provisioned-instances.md) %}


#### CPU usage time {#prices-cpu-provisioned-instances}



{% include notitle [usd-cpu-provisioned-instances.md](../_pricing/serverless-containers/usd-cpu-provisioned-instances.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
