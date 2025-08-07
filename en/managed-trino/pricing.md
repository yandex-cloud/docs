---
title: '{{ mtr-full-name }} pricing policy'
description: This article covers the {{ mtr-name }} pricing policy.
editable: false
---

# {{ mtr-name }} pricing policy



In this section, you can find the {{ mtr-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. Other {{ yandex-cloud }} resources you may employ while using the service are charged based on their pricing plans.


{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## Cluster status {#running-stopped}

The prices apply differently depending on the cluster status:

* For a `Running` cluster, you pay for both the computing resources and storage size.
* For a `Stopped` cluster, you only pay for your storage size.

## What goes into the cost of using {{ mtr-name }} {#rules}

When using {{ mtr-name }}, you pay for:

* Computing resources of cluster components.
* Egress traffic from {{ yandex-cloud }}.

Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Example of cluster cost calculation {#example}

This is an example of calculating the cost of using a cluster with the following properties for 30 days:

* **Coordinator**: One `standard` configuration instance: 4 × 100% vCPU, 16 GB RAM.
* **Workers**: One `standard` configuration instance, fixed number: 4 × 100% vCPU, 16 GB RAM.



{% include [usd-trino](../_pricing_examples/managed-trino/usd.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Cluster computing resources {#prices-computing-resources}



{% include [usd-prices](../_pricing/managed-trino/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
