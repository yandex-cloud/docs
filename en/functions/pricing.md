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

> 3.42 × (512/1024) × (800/3600/1000) × 10,000,000 + 10 × (10,000,000/1,000,000)

Total: ₽3900 

Where:

- 3.42 is the GB×hour function execution cost.
- 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
- 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
- 10: Cost per 1 million functions invoked.
- 10,000,000/1,000,000: Number of millions of functions invoked.

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Pricing {#prices}

### Invoking a function {#invoke}

{% list tabs %}

- Prices in USD

    | Service | Cost of 1 million invokes, <br>without VAT |
    | ----- | ----- |
    | Invoking a function | $0.128205 |

- Prices in roubles

    | Service | Cost of 1 million invocations, <br>with VAT |
    | ----- | ----- |
    | Invoking a function | ₽10  |

{% endlist %}

You are charged for an actual number of invokes. E.g., the cost of 1000 invokes will be `$0.000128`.

### Function execution time {#execution}

{% list tabs %}

- Prices in USD

    | Service | Price per 1 GB×hour, <br>without VAT |
    | ----- | ----- |
    | Function execution | $0.043846 |
    
- Prices in roubles

    | Service | Price per 1 GB×hour, <br>with VAT |
    | ----- | ----- |
    | Function execution | ₽3.42  |

{% endlist %} 

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

