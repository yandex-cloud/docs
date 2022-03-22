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

{% if region == "ru" %}

### Pricing formula

Monthly cost = ₽3.42 × Memory (GB) × Call processing time (Hours) + ₽10 × Million calls

At the same time, there is no charge for the first:

* 10 GB × hour.
* Million calls.

### Example of cost calculation {#price-example}

Example of calculating the cost of a function:
* **Memory specified when creating the version:** 512 MB.
* **Number of functions invoked:** 10000000.
* **Execution time of each call:** 800 ms.

Function cost calculation:

> 3.42 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 – 10) + 10 × (10000000 / 1000000 – 1)

Total: ₽3855.7999

Where:
* 3.42 is the price for 1 GB × hour.
* 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB x hour are free.
* 10: Cost per 1 million functions invoked.
* 10000000/1000000: Number of millions of functions invoked.
* 1 is subtracted because the first million calls are free.

{% endif %}

{% if region == "kz" %}

### Pricing formula

Monthly cost = ₸20.52 × Memory (GB) × Call processing time (Hours) + ₸60 × Million calls

At the same time, there is no charge for the first:
* 10 GB × hour.
* Million calls.

### Example of cost calculation {#price-example}

Example of calculating the cost of a function:
* **Memory specified when creating the version:** 512 MB.
* **Number of functions invoked:** 10000000.
* **Execution time of each call:** 800 ms.

Function cost calculation:

> 20.52 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 – 10) + 60 × (10000000 / 1000000 – 1)

Total: ₸23134.7999

Where:
* 20.52 is the price for 1 GB × hour.
* 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB x hour are free.
* 60 is the price of 1 million function calls.
* 10000000/1000000: Number of millions of functions invoked.
* 1 is subtracted because the first million calls are free.

{% endif %}

{% if region == "int"%}

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

{% endif %}

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Pricing {#prices}

{% if region != "int" %}

{% include [disclaimer-new-prices](../_pricing/disclaimer-new-prices.md) %}

{% endif %}

### Invoking a function {#invoke}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-invocations.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/functions/kzt-invocations.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-invocations.md) %}

{% endif %}

{% if region == "int" %}You are charged for an actual number of invokes. E.g., the cost of 1000 invokes will be `$0.000128` at the price of `$0.128205` for 1 million invokes.{% endif %}

### Function execution time {#execution}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-compute.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/functions/kzt-compute.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-compute.md) %}

{% endif %}

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}