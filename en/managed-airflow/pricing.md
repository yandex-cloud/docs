---
editable: false
---

# {{ maf-name }} pricing policy



In this section, you can find {{ maf-name }} pricing [rules](#rules) and [effective prices](#prices) for the service resources. Other {{ yandex-cloud }} resources you may use while using the service will be charged based on their pricing plans.

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What goes into the cost of using {{ maf-name }} {#rules}

When using {{ maf-name }}, you pay for:

* Using the computing resources of the cluster's components.
* Amount of outgoing traffic.

Charges are made per hour of the cluster's uptime. The minimum billing unit is one hour; e.g., you will be charged for 2 hours when using a cluster for 90 minutes (1.5 hours).

Using {{ objstorage-full-name }} for [storing DAG-files](operations/upload-dags.md) is charged according to the [{{ objstorage-name }} pricing policy](../storage/pricing.md).

{% include [pricing-gb-size](../_includes/pricing-gb-size.md) %}

## Prices for the Russia region {#prices}




All prices below do not include VAT.


{% include [pricing-month-term](../_includes/mdb/pricing-month-term.md) %}

### Host computing resources {#prices-computing-resources}



{% include [usd-prices](../_pricing/managed-airflow/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}

