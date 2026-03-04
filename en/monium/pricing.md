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

When using the {{ monium-name }} platform services, the following is billed:

* Write custom metrics via the [{{ monium-name }} API](api-ref/index.md).
* Write any metrics via the [{{ prometheus-name }} Remote API](operations/prometheus/index.md).
* Read any metrics via the {{ monium-name }} API.
* Export metrics in {{ prometheus-name }} format via the {{ monium-name }} API.
* Write data to {{ monium-logs-name }}.
* Write data to {{ traces-name }}.

You do not pay for writing metric values of {{ yandex-cloud }} resources, reading metrics via the Remote API, and reading logs and traces.

Pricing features:
* After writing or reading the first 50,000,000 metric values via the {{ monium-name }} API, the writing fee is reduced. See  for details.
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* There is no charge for reading data via the {{ monium-name }} interface and {{ yandex-cloud }} console.
* There is no charge for {{ monium-name }} incoming and outgoing traffic.

### Metrics cost calculation example {#example}






{% include [usd-example](../_pricing_examples/monitoring/usd-example.md) %}


### Logs and traces cost calculation example {#example-logs-traces}






{% include [usd-logs-traces-example](../_pricing_examples/monium/usd-logs-traces-example.md) %}



## Prices for the Russia region {#prices}

{% note warning %}

Prices are effective from March 4, 2026.

{% endnote %}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Metrics Pricing {#metrics-prices}

The minimum billing unit is one metric value. The cost is rounded to the nearest ₽0.01, ₸0.01, or $0.01.




{% include [usd.md](../_pricing/monium/usd-metrics.md) %}


### Logs and Traces Pricing {#logs-traces-prices}

For logs and traces, you are billed for the volume of data ingested into {{ monium-logs-name }} and {{ traces-name }}. The minimum billing unit is 1 MB. Prices are shown per 1 GB. The cost is rounded to the nearest ₽0.01, ₸0.01, or $0.01.




{% include [usd.md](../_pricing/monium/usd-logs-traces.md) %}
