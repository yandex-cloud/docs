---
editable: false
---

# Pricing for {{ vpc-name }}

{% if product == "yandex-cloud" %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% endif %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

## {{ vpc-short-name }} pricing {#prices}

### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.
1. **Inactive**: When a _static_ public IP address is not linked to a cloud resource or is linked to a stopped resource.

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-ip.md](../_pricing/vpc/rub-ip.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-ip.md](../_pricing/vpc/kzt-ip.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-ip.md](../_pricing/vpc/ils-ip.md) %}

{% endif %}

The cost of an inactive public static address is calculated by adding the cost of a public IP address to the cost of reserving an inactive public static IP address.

{% if product == "yandex-cloud" %}

For example, the cost of an inactive public static address will be:

{% if region == "ru" %}> ₽0.2400 + ₽0.3100 = ₽0.5500{% endif %}
{% if region == "kz" %}> ₸1.2000 + ₸1.5500 = ₸2.7500{% endif %}
{% if region == "int" %}> $0.001920 + $0.002480 = $0.004400{% endif %}
>
> Total: {% if region == "ru" %}₽0.5500{% endif %}{% if region == "kz" %}₸2.7500{% endif %}{% if region == "int" %}$0.004400{% endif %} per hour.

Where:

* {% if region == "ru" %}₽0.2400{% endif %}{% if region == "kz" %}₸1.2000{% endif %}{% if region == "int" %}$0.001920{% endif %} is the cost of using a public IP address per hour.
* {% if region == "ru" %}₽0.3100{% endif %}{% if region == "kz" %}₸1.5500{% endif %}{% if region == "int" %}$0.002480{% endif %} is the cost of reserving an inactive public static IP address for an hour.

{% endif %}

### Using security groups {#prices-security-groups}

The [security group](concepts/security-groups.md) functionality is at the [Preview](../overview/concepts/launch-stages.md) stage and can be used free of charge.

### Egress traffic {#prices-traffic}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include notitle [ils-egress-traffic.md](../_pricing/ils-egress-traffic.md) %}

{% endif %}

{% if product == "yandex-cloud" %}

## {{ ddos-protection-full-name }} pricing {#prices-ddos-protection}

{% if region != "int" %}

All prices are shown with VAT.

{% else %}

All prices are shown without VAT.

{% endif %}

{% if product == "yandex-cloud" %}

{% if region == "ru" %}

{% include [rub-ddos.md](../_pricing/vpc/rub-ddos.md) %}

{% endif %}

{% if region == "kz" %}

{% include [kzt-ddos.md](../_pricing/vpc/kzt-ddos.md) %}

{% endif %}

{% if region == "int" %}

{% include [usd-ddos.md](../_pricing/vpc/usd-ddos.md) %}

{% endif %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-ddos.md](../_pricing/vpc/ils-ddos.md) %}

{% endif %}

Filtered traffic is incoming traffic that the DDoS Protection filtering system passes to the user's cloud resources. Only filtered traffic is charged.

For example, a user's VM was subject to a typical 10 Gbit/s DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded 2 GB of filtered files from the internet to the VM. When the attack ended, the user downloaded another 2 GB of filtered files.

In this case, only 4 GB of filtered traffic are charged: 2 GB that DDoS Protection passed to cloud resources during the attack, and 2 GB downloaded after the attack. Malicious traffic is filtered out and not charged.

{% endif %}

{% if region == "ru" %}

## {{ adv-ddos-protection }} pricing {#prices-ddos-advanced}

The {{ adv-ddos-protection }} service is activated upon request through the [form](https://forms.yandex.com/surveys/13203262.d03e905cf02195bec1093aa2b032802fe13caac0/).


{% note warning "Important" %}

Please note that a subscription fee for the {{ adv-ddos-protection }} and Managed Web Application Firewall services is immediately charged for an entire month and isn't calculated in proportion to the number of days. For example, if you activated or deactivated the services in the middle of a month, you're still charged the entire subscription fee.

Service usage beyond what's included in the subscription fee is paid for in the next reporting month. For example, services used in July are included in consumption for August.

{% endnote %}

All prices are shown with VAT.

{% if product == "yandex-cloud" %}

{% include [rub-advanced-ddos.md](../_pricing/vpc/rub-advanced-ddos.md) %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-advanced-ddos.md](../_pricing/vpc/ils-advanced-ddos.md) %}

{% endif %}

The {{ adv-ddos-protection }} plan includes the following services:

{% include [rub-advanced-ddos-services.md](../_pricing/vpc/rub-advanced-ddos-services.md) %}

## Managed Web Application Firewall pricing {#prices-waf}

{% if product == "yandex-cloud" %}

{% note warning "Important" %}

The cost of traffic used beyond what is included in the subscription fee will change from December 1, 2022.

{% endnote %}

{% endif %}

All prices are shown with VAT.

{% if product == "yandex-cloud" %}

{% include [rub-waf.md](../_pricing/vpc/rub-waf.md) %}

{% endif %}

{% if product == "cloud-il" %}

{% include [ils-waf.md](../_pricing/vpc/ils-waf.md) %}

{% endif %}

The Managed Web Application Firewall plan includes the following services:

{% include [waf-services.md](../_pricing/vpc/waf-services.md) %}

{% endif %}
