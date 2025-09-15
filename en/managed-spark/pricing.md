---
title: '{{ msp-full-name }} pricing policy'
description: This article covers the {{ msp-name }} pricing policy.
editable: false
---

# {{ msp-name }} pricing policy

{% note info %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ msp-name }} is free of charge.

{% endnote %}

In this section, you can find the {{ msp-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. Other {{ yandex-cloud }} resources you may employ while using the service are charged based on their pricing plans.



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ msp-name }} {#rules}

When using {{ msp-name }}, you pay for:

* Computing resources of cluster components.
* Egress traffic from {{ yandex-cloud }}.

Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

* **Driver**: Two `standard` configuration instances, [host class](concepts/instance-types.md) `c4-m16`, fixed number: 4 vCPU, 16 GB RAM.
* **Executor**: Four `standard` configuration instances, host class `c4-m16`, fixed number: 4 vCPU, 16 GB RAM.




{% include [usd-host-spark](../_pricing_examples/managed-spark/usd-host.md) %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Cluster computing resources {#prices-computing-resources}

{% note info %}

The prices below will be effective starting September 22, 2025.

{% endnote %}




{% include [usd-hosts](../_pricing/managed-spark/usd-hosts.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
