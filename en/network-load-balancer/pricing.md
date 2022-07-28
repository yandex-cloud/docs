---
editable: false
---
# Pricing for {{ network-load-balancer-name }}



{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ network-load-balancer-full-name }}, you are charged for the incoming traffic processed by a network load balancer and for the number of network load balancers.

Outgoing traffic is charged the same as for other {{ yandex-cloud }} services, such as [Compute Cloud](../compute/pricing.md#prices-traffic). Charges for outgoing traffic include the traffic that is generated when targets respond to health checks.

## Pricing {#prices}

### Incoming and outgoing traffic {#prices-traffic}


{% note warning %}

Prices for the incoming and outgoing traffic routed through load balancers will change on August 12th, 2022.

{% endnote %}


You are charged for traffic to the IP address and port specified as the network load balancer's listener. Any other traffic directed to the load balancer is not accepted and is not charged.




{% include [usd.md](../_pricing/network-load-balancer/usd-traffic.md) %}


### Network load balancers {#network-load-balancers}


{% note warning %}

Internal load balancer will become [generally available](../overview/concepts/launch-stages.md) and paid on August 12th, 2022.

{% endnote %}


You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a load balancer has no target groups attached but has a listener, then the public IP address of the listener is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).




{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}


