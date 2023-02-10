---
editable: false
---
# Pricing for {{ network-load-balancer-name }}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

When using {{ network-load-balancer-full-name }}, you are charged for the incoming traffic processed by a network load balancer and for the number of network load balancers.

Outgoing traffic is charged the same as for other {{ yandex-cloud }} services, such as [Compute Cloud](../compute/pricing.md#prices-traffic). Charges for outgoing traffic include the traffic that is generated when targets respond to health checks.

## Pricing {#prices}

### Incoming and outgoing traffic {#prices-traffic}

You are charged for traffic to the IP address and port specified as the network load balancer's listener. Any other traffic directed to the load balancer is not accepted and is not charged.

{% if product == "yandex-cloud" %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-traffic.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-traffic.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/network-load-balancer/ils-traffic.md) %}

{% endif %}

### Network load balancers {#network-load-balancers}

You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a load balancer has no target groups attached but has a listener, then the public IP address of the listener is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).

{% if product == "yandex-cloud" %}

{% if region == "ru"%}

{% include [rub.md](../_pricing/network-load-balancer/rub-balancer.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt.md](../_pricing/network-load-balancer/kzt-balancer.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd.md](../_pricing/network-load-balancer/usd-balancer.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils.md](../_pricing/network-load-balancer/ils-balancer.md) %}

{% endif %}
