---
editable: false
---
# Pricing policy for {{ network-load-balancer-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ network-load-balancer-full-name }}, you are charged for the incoming traffic processed by a network load balancer and for the number of network load balancers.

Outgoing traffic is charged similarly to other {{ yandex-cloud }} services, such as [Compute Cloud](../compute/pricing.md#prices-traffic). Charges for outgoing traffic include the traffic that is generated when targets respond to health checks.

## Pricing {#prices}

### Using internal load balancer {#internal-load-balancer}

The internal load balancer function is currently at the [Preview](../overview/concepts/launch-stages.md) stage and is not charged.

### Incoming traffic {#prices-traffic}

You are charged for incoming traffic to the IP address and port specified as the network load balancer's listener. Any other traffic directed to the load balancer is not accepted and is not charged.

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-ingress.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-ingress.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-ingress.md) %}

{% endif %}

### Network load balancers {#network-load-balancers}

You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a network load balancer has no target groups attached but has a listener, then the public IP address of the listener is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-balancer.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-balancer.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}

{% endif %}
