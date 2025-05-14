---
title: '{{ network-load-balancer-full-name }} pricing policy'
description: This article covers the {{ network-load-balancer-name }} pricing policy.
editable: false
---

# {{ network-load-balancer-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ network-load-balancer-full-name }}, you pay for the incoming and outgoing traffic processed by a network load balancer and for the number of network load balancers.

For a network load balancer with a public IP address, you additionally pay for outbound internet traffic like in other [{{ yandex-cloud }}](../vpc/pricing.md#prices-traffic) services. Charges for outgoing traffic include the traffic generated when targets respond to health checks.


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### Incoming and outgoing traffic {#prices-traffic}

You are charged for traffic coming to the IP address and port specified as the network load balancer's listener. Any other traffic directed to the load balancer is not accepted and is not charged.




{% include [usd.md](../_pricing/network-load-balancer/usd-traffic.md) %}


### Network load balancers {#network-load-balancers}

You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a network load balancer has no target groups attached but has a listener, then the public IP address of the listener is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).




{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}
