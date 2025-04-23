---
title: '{{ managed-k8s-full-name }} pricing policy'
description: This article provides the {{ managed-k8s-name }} pricing policy.
editable: false
---


# {{ managed-k8s-name }} pricing policy

{% note tip %}





To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=f05a4ab8c08f#calculator) on the {{ yandex-cloud }} website or check the pricing data in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

In {{ managed-k8s-name }}, you are charged for using [masters](concepts/index.md#master) and outgoing traffic.

Nodes are charged based on the [{{ compute-full-name }} pricing policy](../compute/pricing.md).



## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, the prices for {{ managed-k8s-full-name }} resources in the Russia region will increase. For new USD prices, see our [price list](https://yandex.cloud/en/price-list?installationCode=ru&currency=USD&services=dn2af04ph5otc5f23o1h).

{% endnote %}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}



### Master {#master}

The monthly prices are based on 720 hours per month.




{% include [usd.md](../_pricing/managed-kubernetes/usd.md) %}


{% include [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}