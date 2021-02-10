---
editable: false
---
# Pricing policy for {{ network-load-balancer-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ network-load-balancer-full-name }}, you are charged for the incoming traffic processed by a network load balancer and for the number of network load balancers.

Outgoing traffic is charged similarly to other Yandex.Cloud services, such as [Compute Cloud](../compute/pricing.md#prices-traffic). Charges for outgoing traffic include the traffic that is generated when targets respond to health checks.

### Using internal load balancer {#internal-load-balancer}

The internal load balancer function is currently at the [Preview](../overview/concepts/launch-stages.md) stage and is not charged.

### Incoming traffic {#prices-traffic}

You are charged for incoming traffic to the IP address and port specified as the network load balancer's listener. Any other traffic directed to the load balancer is not accepted and is not charged.

{% list tabs %}

- Prices in USD
  
  | Service | Rate for 1 GB of processed traffic, without VAT | 
  | ----- | ----- |
  | Processing of incoming traffic by the load balancer | $0.002215 |
  
- Prices in roubles
  
  | Service | Rate for 1 GB of processed traffic, with VAT |
  | ----- | ----- |
  | Processing of incoming traffic by the load balancer | ₽0,1728 |
  
{% endlist %}

### Network load balancers {#network-load-balancers}

You are charged for network load balancers if they have a listener and a non-empty target group attached.

If a network load balancer has no target groups attached but has a listener, then the public IP address of the listener is charged as an [inactive public IP address](../vpc/pricing.md#prices-public-ip).

{% list tabs %}

- Prices in USD
  
  | Resource type | Rate for 1 balancer per hour, without VAT |
  | ----- | ----- |
  | Network load balancer | $0.007123 |
  
- Prices in roubles
  
  | Resource type | Rate for 1 balancer per hour, with VAT |
  | ----- | ----- |
  | Network load balancer | ₽0,5556 |
  
{% endlist %}
