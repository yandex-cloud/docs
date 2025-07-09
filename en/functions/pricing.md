---
title: '{{ sf-full-name }} pricing policy'
description: This article covers the {{ sf-name }} pricing policy.
editable: false
---

# {{ sf-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ sf-name }} {#rules}

In {{ sf-name }}, you pay for the number of function calls, computing resources allocated for the function, downtime of [provisioned instances](concepts/function.md#provisioned-instances), and outgoing traffic.

When billing computing resources (GB × hour), the memory allocated for the function and function execution time are taken into account:
* The amount of memory specified when [creating a version](operations/function/version-manage.md), in GB.
* The execution time for each function call in hours, rounded up to the nearest multiple of 100 ms.

{% note warning %}

You are only charged for the [function calls](concepts/function-invoke.md) that triggered your code to run.

{% endnote %}

### Cost calculation formula {#price-formula}



Price per month = {{ sku|USD|serverless.functions.compute.v1|pricingRate.10|string }} × Memory (GB) × Call processing time (Hours) + {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }} × Call count (in millions)

{% include [not-charged-functions.md](../_includes/pricing/price-formula/not-charged-functions.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}


### Cost calculation example {#price-example}

{% include [prices-example](../_includes/functions/prices-example.md) %}

## Using triggers {#triggers}

[Triggers](concepts/trigger/index.md) can be used free of charge. You can create and use triggers within the available [quotas and limits](concepts/limits.md).

## Alice skills

{{ sf-name }} functions used for Alice skills are not billable and do not consume your [free amount of services](../billing/concepts/serverless-free-tier.md#sf), if:
* The function is invoked by the [Yandex Dialogs platform](https://yandex.ru/dev/dialogs/).
* The Alice's skill was created by the [instructions](https://yandex.ru/dev/dialogs/alice/doc/deploy-ycloud-function.html#deploy-ycloud-function__register).

However, if the function uses other {{ yandex-cloud }} resources, they are billed. For example, if the function makes requests to the {{ message-queue-name }} queue, the requests are billed according to the [pricing](../message-queue/pricing.md#requests-to-queues).

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Invoking a function {#invoke}



{% include [usd.md](../_pricing/functions/usd-invocations.md) %}

You pay for the actual number of invocations. For instance, 1,000 calls over the included number cost {% calc [currency=USD] {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|number }} × 1000 / 1000000 %} if 1000000 calls are {{ sku|USD|serverless.functions.invocations.v1|pricingRate.1|string }}.


### Function execution time {#execution}



{% include [usd.md](../_pricing/functions/usd-compute.md) %}


### Provisioned instances {#provisioned-instances}



{% include [usd.md](../_pricing/functions/usd-compute-provisioned-instances.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

