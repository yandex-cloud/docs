---
editable: false
---
# Pricing for {{ sf-name }}

## What goes into the cost of using {{ sf-name }} {#rules}

In {{ sf-name }}, you're billed for the number of functions invoked, computing resources allocated for the function, and outgoing traffic.

When billing computing resources (GB×hour), the memory allocated for the function and function execution time are taken into account:

* The amount of memory specified when [creating a version](operations/function/version-manage.md#func-version-create), in GB.
* The execution time for each function invocation in hours, rounded up to the nearest multiple of 100 ms.

{% note warning %}

You're charged for all the [functions invoked](concepts/function-invoke.md) that trigger your code to run.

{% endnote %}




### Pricing formula

Monthly cost = $0.043846 × Memory (GB) × Call processing time (Hours) + $0.128205 × Million calls

At the same time, there is no charge for the first:
* 10 GB × hour.
* Million calls.

### Example of cost calculation {#price-example}

Example of calculating the cost of a function:
* **Memory specified when creating the version:** 512 MB.
* **Number of functions invoked:** 10000000.
* **Execution time of each call:** 800 ms.

Function cost calculation:

> 0.043846 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 -10) + 0.128205 × (10000000 / 1000000 - 1)
> 
> Total: $49.433163

Where:
* 0.043846 is the price for 1 GB × hour.
* 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB x hour are free.
* 0.128205 is the price of 1 million function calls.
* 10000000/1000000: Number of millions of functions invoked.
* 1 is subtracted because the first million calls are free.

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Pricing {#prices}


### Invoking a function {#invoke}




{% include [usd.md](../_pricing/functions/usd-invocations.md) %}

You are charged for an actual number of invokes. E.g., the cost of 1000 invokes will be `$0.000128` at the price of `$0.128205` for 1 million invokes.

### Function execution time {#execution}




{% include [usd.md](../_pricing/functions/usd-compute.md) %}

### Outgoing traffic {#prices-traffic}




{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}