---
editable: false
---

# Pricing for {{ sf-name }}

## What goes into the cost of using {{ sf-name }} {#rules}

In {{ sf-name }}, you're billed for the number of function invocations, computing resources allocated for the function, downtime of [provisioned instances](concepts/function.md#provisioned-instances), and outgoing traffic.

When billing computing resources (GB×hour), the memory allocated for the function and function execution time are taken into account:
* The amount of memory specified when [creating a version](operations/function/version-manage.md), in GB.
* The execution time for each function call in hours, rounded up to the nearest multiple of 100 ms.

{% note warning %}

You're charged for all the [function calls](concepts/function-invoke.md) that trigger your code to run.

{% endnote %}

{% if region == "ru" %}

### Pricing formula {#price-formula}

Monthly cost = ₽5.47 × Memory (GB) × Call processing time (Hours) + ₽16 × Million calls

{% include [not-charged-functions.md](../_includes/pricing/price-formula/not-charged-functions.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

Example of calculating the cost of a function that has:
* **Memory specified when creating the version**: 512 MB.
* **Number of function calls**: 10000000.
* **Execution time of each call**: 800 ms.

Function cost calculation:

> 5.47 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 – 10) + 16 × ((10000000 – 1000000) / 1000000)
>
> Total: ₽6167.08

Where:
* 5.47 is the price for 1 GB×hour.
* 512/1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800/3600/1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB×hour are free.
* 16: Cost per 1 million function calls.
* 10000000 is the number of function calls.
* 1000000 is subtracted because the first million calls are free.
* 1000000 is the divisor used to calculate the number of millions of function calls.

{% endif %}

{% if region == "kz" %}

### Pricing formula

Monthly cost = ₸27.35 × Memory (GB) × Call processing time (Hours) + ₸80 × Million calls

{% include [not-charged-functions.md](../_includes/pricing/price-formula/not-charged-functions.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

Example of calculating the cost of a function that has:
* **Memory specified when creating the version**: 512 MB.
* **Number of function calls**: 10000000.
* **Execution time of each call**: 800 ms.

Function cost calculation:

> 27.35 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 – 10) + 80 × ((10000000 – 1000000) / 1000000)
>
> Total: ₸30835.39

Where:
* 27.35 is the price for 1 GB×hour.
* 512/1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800/3600/1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB×hour are free.
* 80: Cost per 1 million function calls.
* 10000000/1000000: Number of millions of functions invoked.
* 1 is subtracted because the first million calls are free.

{% endif %}

{% if region == "int" %}

### Pricing formula {#price-formula}

Monthly cost = $0.043760 × Memory (GB) × Call processing time (Hours) + $0.128000 × Millions of calls

{% include [not-charged-functions.md](../_includes/pricing/price-formula/not-charged-functions.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Example of cost calculation {#price-example}

Example of calculating the cost of a function that has:
* **Memory specified when creating the version**: 512 MB.
* **Number of function calls**: 10000000.
* **Execution time of each call**: 800 ms.

Function cost calculation:

> 0.043760 × ((512 / 1024) × (800 / 3600 / 1000) × 10000000 – 10) + 0.128000 × ((10000000 – 1000000) / 1000000)
>
> Total: $49.336622

Where:
* 0.043760 is the price for 1 GB×hour.
* 512/1024 converts MB to GB, since execution time is calculated in GB×hour.
* 800/3600/1000 converts milliseconds to hours, since execution time is calculated in GB×hour.
* 10000000 is the number of function calls.
* 10 is subtracted because the first 10 GB×hour are free.
* 0.128000 is the price per 1 million function calls.
* 10000000 is the number of function calls.
* 1000000 is subtracted because the first million calls are free.
* 1000000 is the divisor used to calculate the number of millions of function calls.

{% endif %}

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Alice skills

{{ sf-name }} functions used for Alice skills aren't rated and don't consume your [free amount of services](../billing/concepts/serverless-free-tier.md#sf), if:
* The function is called by the [Yandex Dialogs platform](https://yandex.ru/dev/dialogs/).
* The Alice's skill was created by the [instructions](https://yandex.ru/dev/dialogs/alice/doc/deploy-ycloud-function.html#deploy-ycloud-function__register).

However, if the function uses other {{ yandex-cloud }} resources, they are billed. For example, if the function makes requests to the {{ message-queue-name }} queue, the requests are billed according to the [pricing](../message-queue/pricing.md#requests-to-queues).

## Pricing {#prices}

### Invoking a function {#invoke}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-invocations.md) %}

You pay for the actual number of invocations. For instance, 1000 calls over the included number cost ₽0.016 if 1000000 calls are ₽16.

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/functions/kzt-invocations.md) %}

You pay for the actual number of invocations. For instance, 1000 calls over the included number cost ₸0.08 if 1000000 calls are ₸80.

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-invocations.md) %}

You pay for the actual number of invocations. For instance, 1000 calls over the included number cost $0.000128 if 1000000 calls are $0.128000.

{% endif %}

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

### Provisioned instances {#provisioned-instances}

{% note info %}

The prices are in effect as of October 17, 2022.

{% endnote %}

{% if region == "ru" %}

{% include [rub.md](../_pricing/functions/rub-compute-provisioned-instances.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt.md](../_pricing/functions/kzt-compute-provisioned-instances.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd.md](../_pricing/functions/usd-compute-provisioned-instances.md) %}

{% endif %}

### Egress traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}