---
title: '{{ managed-k8s-full-name }} pricing policy'
description: This article covers the {{ managed-k8s-name }} pricing policy.
editable: false
---


# {{ managed-k8s-name }} pricing policy

{% note tip %}





To estimate your service costs, use [our calculator](https://yandex.cloud/en/prices?state=f05a4ab8c08f#calculator) on the {{ yandex-cloud }} website or see the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

In {{ managed-k8s-name }}, you are charged for using [masters](concepts/index.md#master) and outgoing traffic.

Nodes are charged based on the [{{ compute-full-name }} pricing policy](../compute/pricing.md).



## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Master {#master}

The monthly prices are based on 720 hours per month.

{% note warning %}

{% include [base-zonal-pricing](../_includes/managed-kubernetes/base-zonal-pricing.md) %}

{% include [ha-regional-pricing](../_includes/managed-kubernetes/ha-regional-pricing.md) %}

{% endnote %}




{% include [usd.md](../_pricing/managed-kubernetes/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}