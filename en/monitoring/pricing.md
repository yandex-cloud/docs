---
title: "{{ monitoring-full-name }} pricing policy"
description: "This article describes the {{ monitoring-name }} pricing policy."
editable: false
---

# {{ monitoring-full-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ monitoring-short-name }} {#rules}

Currently, {{ monitoring-short-name }} charges for writing custom metrics via the [{{ monitoring-short-name }} API](api-ref/index.md) and writing any metrics via the [{{ prometheus-name }} Remote API](operations/prometheus/index.md), as well as reading any metrics via the [{{ monitoring-short-name }} API](api-ref/index.md).

Reading metrics via the {{ prometheus-name }} Remote API is not yet billable.

Pricing features:
* After writing or reading the first 50 million values via the {{ monitoring-short-name }} API, the writing charge is reduced. See [{#T}](#prices).
* There is no charge for writing {{ yandex-cloud }} resource metrics collected automatically.
* There is no charge for reading metrics via the {{ monitoring-short-name }} interface and {{ yandex-cloud }} console.
* There is no charge for incoming and outgoing traffic in {{ monitoring-short-name }}.

### Cost calculation example {#example}






{% include [usd-example](../_pricing_examples/monitoring/usd-example.md) %}



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### {{ monitoring-short-name }} API {#monitoring-api}




The minimum billing unit is 1 metric value. The cost is rounded to the nearest cent.

For example, writing the first 100,000 values will cost `(100,000 values / 1 million) × $0.0784 = $0.00784`, rounded to `$0.01`. Whereas writing 150,000 values will cost `(150,000 values / 1 million) × $0.0784 = $0.01176`, rounded to `$0.01`. Where `$0.0784` is the price per 1 million values (if writing up to 50 million values).

{% include [usd.md](../_pricing/monitoring/usd.md) %}


### {{ prometheus-name }} Remote API {#prometheus-remote-api}




{% include [usd-prometheus.md](../_pricing/monitoring/usd-prometheus.md) %}


{% include [trademark](../_includes/monitoring/trademark.md) %}
