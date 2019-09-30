---
editable: false
---
# Pricing for {{ sf-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ sf-name }}

In {{ sf-name }}, you're billed for the number of function invokes, computing resources allocated for the function, and outgoing traffic.

When billing computing resources (GB×hour), the memory allocated for the function and function execution time are taken into account:

- The amount of memory specified when [creating a version](operations/version-manage.md#func-version-create), in GB.
- The execution time for each function invoke in hours, rounded up to the nearest multiple of 100 ms.

### Function pricing in the event of errors {#error}

{{ sf-name }} returns the results of function execution with the status code. The following status codes are billed:

- `200 OK`: Successful function execution.
- `502 BadGateway`: Incorrect function code or format of the returning JSON response.
- `504 Gateway Timeout`: Exceeded maximum function execution time before timeout.

You aren't charged for function invokes that result in [other status codes](concepts/function-invoke.md#http-state). For more information about function invokes and status codes, see [{#T}](concepts/function-invoke.md).

### Example of cost calculation {#price-example}

Example of calculating the cost of a function:

- **Memory specified when creating the version:** 512 MB.
- **Number of function invokes:** 10 000 000.
- **Execution time on each invoke:** 800 ms.

Function cost calculation:

> 3.42 × (512 / 1024) × (800 / 3 600 / 1 000) × 10 000 000 + 10 × (10 000 000 / 1 000 000)
>  
> Total: 3900 ₽

Where:

- 3.42 is the GB×hour function execution cost.
- 512 / 1024 converts MB to GB, since execution time is calculated in GB×hour.
- 800 / 3600 / 1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
- 10 is the cost per 1 million function invokes.
- 10 000 000 / 1 000 000 is the number of millions of invokes.

## Using triggers {#triggers}

[Triggers](concepts/trigger.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](../functions/concepts/limits.md).

## Pricing {#prices}

### Invoking a function {#invoke}

{% list tabs %}

- Prices in USD

    | Service | Cost of 1 million invokes, <br>without VAT
    | ----- | ----- |
    | Invoking a function | $0.128205 |

- Prices in roubles

    | Service | Cost of 1 million invokes, <br>with VAT |
    | ----- | ----- |
    | Invoking a function | ₽10 |

{% endlist %}

### Function execution time {#execution}

{% list tabs %}

- Prices in USD

    | Service | Price per 1 GB×hour, <br>without VAT |
    | ----- | ----- |
    | Function execution | $0.043846 |
    
- Prices in roubles

    | Service | Price per 1 GB×hour, <br>with VAT |
    | ----- | ----- |
    | Function execution | ₽3.42 |
    
{% endlist %}    

### Outgoing traffic {#prices-traffic}

{% include notitle [pricing-egress-traffic](../_includes/pricing/pricing-egress-traffic.md) %}

## Using triggers {#triggers}

[Triggers](concepts/trigger.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](../functions/concepts/limits.md).
