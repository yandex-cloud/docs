---
editable: false
---
# Pricing for {{ vpc-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

## Pricing {#prices}

### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.

1. **Inactive**: When a _static_ public IP address isn't linked to a cloud resource or is linked to a stopped resource. The price of an inactive public static address is calculated by adding the price of a public IP address to the price for reserving an inactive public static IP address. 

{% if region == "int"%}

   For example, if the cost of an hour of using a public IP address is $0.001953, and the cost of an hour of reserving an inactive public static IP address is $0.002538, the price of an inactive public static address will be:
   
   > $0.001953 + $0.002538 = $0.004491 per hour, without VAT

{% endif %}

{% if region == "ru"%}

{% include [rub-ip.md](../_pricing/vpc/rub-ip.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-ip.md](../_pricing/vpc/kzt-ip.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}

{% endif %}

### DDoS protection {#prices-ddos-protection}

{% if region == "ru"%}

{% include [rub-ddos.md](../_pricing/vpc/rub-ddos.md) %}

{% endif %}

{% if region == "kz"%}

{% include [kzt-ddos.md](../_pricing/vpc/kzt-ddos.md) %}

{% endif %}

{% if region == "int"%}

{% include [usd-ddos.md](../_pricing/vpc/usd-ddos.md) %}

{% endif %}

Filtered traffic is incoming traffic that the DDoS Protection filtering system passes to the user's cloud resources. Only filtered traffic is charged.

For example, a user's VM was subject to a typical 10 Gbit/s DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded 2 GB of filtered files from the internet to the VM. When the attack ended, the user downloaded another 2 GB of filtered files.

In this case, only 4 GB of filtered traffic are billed: 2 GB that DDoS Protection passed to cloud resources during the attack, and 2 GB downloaded after the attack. Malicious traffic is filtered out and not billed.

### Cloud Interconnect {#prices-interconnect}

The service is provided when technically possible. Yandex Cloud Interconnect prices are provided upon request and are subject to the technical characteristics of the connection to {{ yandex-cloud }}.

### Using security groups {#prices-security-groups}

The [security group](concepts/security-groups.md) functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and can be used free of charge.

### Outgoing traffic {#prices-traffic}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

