---
editable: false
---
# Pricing for {{ sf-name }}

## What goes into the cost of using {{ sf-name }} {#rules}

In {{ sf-name }}, you're billed for the number of functions invoked, computing resources allocated for the function, and outgoing traffic.

When billing computing resources (GB×hour), the memory allocated for the function and function execution time are taken into account:

- The amount of memory specified when [creating a version](operations/function/version-manage.md#func-version-create), in GB.
- The execution time for each function invocation in hours, rounded up to the nearest multiple of 100 ms.

{% note warning %}

You're charged for all the [functions invoked](concepts/function-invoke.md) that trigger your code to run.

{% endnote %}

### Example of cost calculation {#price-example}

Example of calculating the cost of a function:

- **Memory specified when creating the version:** 512 MB.
- **Number of functions invoked:** 10,000,000.
- **Execution time of each call:** 800 ms.

Function cost calculation:

> 0.043846 × (512 / 1024) × (800 / 3600 / 1000) × 10,000,000 + 0.128205 × (10,000,000 / 1,000,000)
>  
> Total: $49.99982

Where:

- 0.043846 is the GB×hour function execution cost.
- 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
- 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
- 0.128205 is the cost per 1 million function invokes.
- 10,000,000 / 1,000,000 is the number of millions of invokes.

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Pricing {#prices}

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

You are charged for an actual number of invokes. E.g., the cost of 1000 invokes will be `$0.000128` at the price of `$0.128205` for 1 million invokes.

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