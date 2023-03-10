---
editable: false
---

# Pricing for {{ vpc-name }}

{{ vpc-name }} usage is rated by the pricing policy described in this section.


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## {{ vpc-short-name }} pricing {#prices}

### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.
1. **Inactive**: When a _static_ public IP address is not linked to a cloud resource or is linked to a stopped resource.


All prices are shown without VAT.






{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}




The cost of an inactive public static address is calculated by adding the cost of a public IP address to the cost of reserving an inactive public static IP address.

For example, the cost of an inactive public static address will be:


> 
> 
> $0.001920 + $0.002480 = $0.004400
>
> Total: $0.004400 per hour.



Where:

* $0.001920 is the cost of using a public IP address per hour.
* $0.002480 is the cost of reserving an inactive public static IP address for an hour.

### Using security groups {#prices-security-groups}

The [security group](concepts/security-groups.md) functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and can be used free of charge.

### Egress traffic {#prices-traffic}


All prices are shown without VAT.






{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}





## {{ ddos-protection-full-name }} pricing {#prices-ddos-protection}


All prices are shown without VAT.






{% include [usd-ddos.md](../_pricing/vpc/usd-ddos.md) %}




Filtered traffic is incoming traffic that the DDoS Protection filtering system passes to the user's cloud resources. Only filtered traffic is charged.

For example, a user's VM was subject to a typical 10 Gbps DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded 2 GB of filtered files from the internet to the VM. When the attack ended, the user downloaded another 2 GB of useful files.

In this case, only 4 GB of filtered traffic are charged: 2 GB that DDoS Protection passed to cloud resources during the attack, and 2 GB downloaded after the attack. Malicious traffic is filtered out and not charged.


