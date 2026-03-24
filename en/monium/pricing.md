---
title: '{{ monium-name }} pricing policy'
description: This article covers the {{ monium-name }} pricing policy.
editable: false
---

# {{ monium-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ monium-name }} {#rules}

When using {{ monium-name }} services, you pay for the following:

* Writing custom metrics via the [{{ monium-name }} API](api-ref/index.md).
* Writing any metrics via the [{{ prometheus-name }} Remote API](operations/prometheus/index.md).
* Reading any metrics via the {{ monium-name }} API.
* Exporting metrics in {{ prometheus-name }} format via the {{ monium-name }} API.
* Writing data to {{ monium-logs-name }}.
* Writing data to {{ traces-name }}.

There is no charge for writing {{ yandex-cloud }} resource metrics, reading metrics via the {{ prometheus-name }} Remote API, or reading logs and traces.

Pricing features:
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* There is no charge for reading data via the {{ monium-name }} interface and {{ yandex-cloud }} console.
* There is no charge for {{ monium-name }} incoming and outgoing traffic.

### Example of metric cost calculation {#example}






{% include [usd-example](../_pricing_examples/monitoring/usd-example.md) %}


### Examples of cost calculation for logs and traces {#example-logs-traces}






{% include [usd-logs-traces-example](../_pricing_examples/monium/usd-logs-traces-example.md) %}



## Prices for the Russia region {#prices}

{% note warning %}

The prices are effective starting March 4, 2026.

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Pricing for metrics {#metrics-prices}

For metrics, the minimum billing unit is one metric value. The cost is rounded to the nearest ₽0.01, ₸0.01, or $0.01.




{% include [usd.md](../_pricing/monium/usd-metrics.md) %}


### Pricing for logs and traces {#logs-traces-prices}

Billing for logs and traces is based on the size of data written to {{ monium-logs-name }} and {{ traces-name }}. The minimum billing unit is 1 MB. The prices are provided for 1 GB. The cost is rounded to the nearest ₽0.01, ₸0.01, or $0.01.




{% include [usd.md](../_pricing/monium/usd-logs-traces.md) %}

