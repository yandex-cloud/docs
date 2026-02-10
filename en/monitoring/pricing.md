---
title: '{{ monitoring-full-name }} pricing policy'
description: This article covers the {{ monitoring-name }} pricing policy.
editable: false
---

# {{ monitoring-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

Currently, you are charged for writing custom metrics via the [{{ monitoring-short-name }} API](api-ref/index.md) and writing any metrics via the [{{ prometheus-name }} Remote API](operations/prometheus/index.md), as well as reading any metrics via the [{{ monitoring-short-name }} API](api-ref/index.md).

You do not pay for writing metric values of {{ yandex-cloud }} resources and reading metrics via the Remote API.

Pricing features:
* After writing or reading the first 50,000,000 metric values via the {{ monitoring-short-name }} API, the writing fee is reduced. See  for details.
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* There is no charge for reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console.
* There is no charge for {{ monitoring-short-name }} incoming and outgoing traffic.

### Cost calculation example {#example}






{% include [usd-example](../_pricing_examples/monitoring/usd-example.md) %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

The minimum billing unit is one metric value. The cost is rounded to the nearest ₽0.01, ₸0.01, or $0.01.




{% include [usd-api-example](../_pricing_examples/monitoring/usd-api-example.md) %}

<MDX>
  <PriceList
    serviceIds={['{{ pcs|monitoring }}']}
    excludeSkuIds={['{{ pc|monitoring.alerts.notifications.sms }}', '{{ pc|monitoring.alerts.notifications.phone }}', '{{ pc|monitoring.prometheus.point.remote_api.read }}', '{{ pc|monitoring.point.ui.read }}', '{{ pc|monitoring.metrics.stored }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



{% include [trademark](../_includes/monitoring/trademark.md) %}
