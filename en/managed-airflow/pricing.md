---
title: '{{ maf-full-name }} pricing policy'
description: This article provides the {{ maf-name }} pricing policy.
editable: false
---

# {{ maf-name }} pricing policy



In this section, you can find the {{ maf-name }} pricing [policy](#rules) and [effective prices](#prices) for its resources. Other {{ yandex-cloud }} resources you may employ while using the service are charged based on their pricing plans.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What goes into the cost of using {{ maf-name }} {#rules}

To calculate the cost of using the service, use the [calculator](https://yandex.cloud/ru/prices?state=6d791b1487fb#calculator) on the {{ yandex-cloud }} website or see the pricing in this section.

* Computing resources of cluster components.
* Amount of outgoing traffic.

Cluster operation cost is charged per hour. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en-ru/prices?state=ab1804573e6c#calculator) on the {{ yandex-cloud }} website or see the pricing in this section.

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

### Example of cluster cost calculation {#example}

To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=c931c7dd8121#calculator) on the {{ yandex-cloud }} website or see the pricing in this section.

* **Web server**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Scheduler**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.
* **Workers**: One `standard` configuration instance: 1 × 100% vCPU, 4 GB RAM.



{% include [usd-airflow](../_pricing_examples/managed-airflow/usd.md) %}


## Prices for the Russia region {#prices}




All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Cluster computing resources {#prices-computing-resources}



{% include [usd-prices](../_pricing/managed-airflow/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}
