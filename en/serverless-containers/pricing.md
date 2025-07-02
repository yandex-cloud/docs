---
title: '{{ serverless-containers-full-name }} pricing policy'
description: This article covers the {{ serverless-containers-name }} pricing policy.
editable: false
---

# {{ serverless-containers-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ serverless-containers-name }} {#rules}

In {{ serverless-containers-name }}, you pay for the number of container invocations, computing resources allocated for the application, downtime of [provisioned instances](concepts/container.md#provisioned-instances), and outgoing traffic.

Computing resources are billed based on the number of processor cores (vCPUs), the [level of core performance](../compute/concepts/performance-levels.md), memory allocated for the application, and application running time:

* The number of cores specified when creating a revision is measured in vCPUs and is a positive real number.
* The core performance level specified when creating a revision is measured in %.
* The memory size specified when creating a revision is measured in GB.
* The total container time is measured in hours and is rounded up to a multiple of 100 ms.

{% note warning %}

You are only charged for the container invocations that have caused your application to run.

{% endnote %}

### Cost calculation formula {#formula}



{% include [usd-formula](../_pricing_examples/serverless-containers/usd-formula.md) %}


{% include [not-charged-sc.md](../_includes/pricing/price-formula/not-charged-serverless-containers.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

### Examples of cost calculation {#example}

Example of calculating the cost of a container with the following parameters:

* **Amount of memory specified when creating a revision**: 2 GB.
* **Number of cores**: 20% vCPU.
* **Number of container invocations**: 3,000,000.
* **Execution time of each invocation**: 150 ms.



{% include [usd-example-20pct](../_pricing_examples/serverless-containers/usd-example-20pct.md) %}


Example of calculating the cost of a container with the following parameters:

* **Amount of memory specified when creating a revision**: 2 GB.
* **Number of cores**: 100% vCPU.
* **Number of container invocations**: 3,000,000.
* **Execution time of each invocation**: 150 ms.



{% include [usd-example-100pct](../_pricing_examples/serverless-containers/usd-example-100pct.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

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
