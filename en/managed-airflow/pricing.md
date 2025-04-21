---
title: '{{ maf-full-name }} pricing policy'
description: This article provides the {{ maf-name }} pricing policy.
editable: false
---

# {{ maf-name }} pricing policy



In this section, you can find the {{ maf-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. Other {{ yandex-cloud }} resources you may employ while using the service are charged based on their pricing plans.

{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=c931c7dd8121#calculator) on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}

## What goes into the cost of using {{ maf-name }} {#rules}

When using {{ maf-name }}, you pay for:

* Computing resources of cluster components.
* Amount of outgoing traffic.

Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

Using {{ objstorage-full-name }} for storing [DAG files](operations/upload-dags.md) is charged according to the [{{ objstorage-name }}](../storage/pricing.md) pricing policy.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Example of cluster cost calculation {#example}

The cost of using a cluster with the following parameters for 30 days:

* **Web server**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Scheduler**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Workers**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.



{% include [usd-airflow](../_pricing_examples/managed-airflow/usd.md) %}


## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, the prices for {{ maf-full-name }} resources in the Russia region will increase. For new USD prices, see our [price list](https://yandex.cloud/en/price-list?currency=USD&installationCode=ru&services=dn2o8879r181fgps5lb3).

{% endnote %}





All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Cluster computing resources {#prices-computing-resources}



{% include [usd-prices](../_pricing/managed-airflow/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
