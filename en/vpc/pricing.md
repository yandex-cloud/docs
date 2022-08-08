---
editable: false
---
# Pricing for {{ vpc-name }}

{% if product == "cloud-il" %}

At the [Preview](../overview/concepts/launch-stages.md) stage, {{ vpc-name }} can be used free of charge.

{% endif %}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## {{ vpc-short-name }} pricing {#prices}

### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.

1. **Inactive**: When a _static_ public IP address isn't linked to a cloud resource or is linked to a stopped resource. The price of an inactive public static address is calculated by adding the price of a public IP address to the price for reserving an inactive public static IP address. 

{% if region == "int"%}

   For example, if the cost of an hour of using a public IP address is $0.001953, and the cost of an hour of reserving an inactive public static IP address is $0.002538, the price of an inactive public static address will be:
   
   > $0.001953 + $0.002538 = $0.004491 per hour, without VAT

{% endif %}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

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

### Using security groups {#prices-security-groups}

The [security group](concepts/security-groups.md) functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and can be used free of charge.

### Outgoing traffic {#prices-traffic}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

## {{ ddos-protection-full-name }} pricing {#prices-ddos-protection}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

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

{% if region == "ru"%}

## {{ adv-ddos-protection }} pricing {#prices-ddos-advanced}

{% note warning "Important" %}

Please note that user charge for {{ adv-ddos-protection }} and Managed Web Application Firewall is billed for the whole month and is not calculated proportionally to the number of the actual usage days. For example, if you enabled or disabled services in the middle of the month, you will still pay for the whole month. 

Billing of the services on top of the monthly user charge happens in the next month. For example, services that you used in July will be billed in August.

{% endnote %}

All prices are shown with VAT.

{% include [rub-advanced-ddos.md](../_pricing/vpc/rub-advanced-ddos.md) %}

The {{ adv-ddos-protection }} plan includes the following services:

{% include [rub-advanced-ddos-services.md](../_pricing/vpc/rub-advanced-ddos-services.md) %}

## Managed Web Application Firewall pricing {#prices-waf}

All prices are shown with VAT.

{% include [rub-waf.md](../_pricing/vpc/rub-waf.md) %}

The Managed Web Application Firewall plan includes the following services:

{% include [waf-services.md](../_pricing/vpc/waf-services.md) %}

{% endif %}

{% endif %}