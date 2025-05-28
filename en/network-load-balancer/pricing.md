---
title: '{{ network-load-balancer-full-name }} pricing policy'
description: This article covers the {{ network-load-balancer-name }} pricing policy.
editable: false
---

# {{ network-load-balancer-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ network-load-balancer-full-name }}, you pay for the inbound and outbound traffic processed by a network load balancer and for the number of network load balancers you use.

For a network load balancer with a public IP address, you additionally pay for outbound internet traffic like in other [{{ yandex-cloud }}](../vpc/pricing.md#prices-traffic) services. Outbound traffic also includes target responses to health checks.


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Inbound and outbound traffic {#prices-traffic}

You are charged for traffic arriving at the IP address and port specified as the network load balancer listener. Any other traffic sent to the load balancer is dropped and not charged.




{% include [usd.md](../_pricing/network-load-balancer/usd-traffic.md) %}


### Network load balancers {#network-load-balancers}

You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a network load balancer has a listener but no attached target groups, the listener public IP address is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).




{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}
