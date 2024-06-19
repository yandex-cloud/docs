---
editable: false
---

# {{ vpc-name }} pricing

{{ vpc-name }} usage is rated by the pricing policy described in this section.

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

After deleting or stopping resources, you will continue to pay for the reserved public IP addresses. If you no longer need the IP addresses, delete them.


## Prices for Russia {#prices}




### {{ vpc-short-name }} {#vpc-prices}

#### Public IP addresses {#prices-public-ip}

A public IP address can be in one of the following two states:

1. **Active**: When a _dynamic_ or _static_ public IP address is linked to a running cloud resource.
1. **Inactive**: When a _static_ public IP address is not linked to a cloud resource or is linked to a stopped resource.


All prices are shown without VAT.





{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}


The cost of an inactive public static address is calculated by adding the cost of a public IP address to the cost of reserving an inactive public static IP address.


For example, the cost of an inactive public static address will be:



> $0.001920 + $0.002480 = $0.004400
>
> Total: $0.004400 per hour.

Where:

* $0.001920 is the cost of using a public IP address per hour.
* $0.002480 is the cost of reserving an inactive public static IP address for an hour.



#### NAT gateways {#nat-gateways}

You will be charged per hour of NAT gateway usage and for outgoing traffic via the gateway. Charges will apply as soon as you add a gateway to a route table.




{% include notitle [usd-egress-nat.md](../_pricing/vpc/usd-egress-nat.md) %}


##### Outgoing traffic via NAT gateways {#nat-gateway-egress-traffic}

Outgoing traffic via a NAT gateway exceeding 100 GB per month is billable.

Please note that traffic transmitted via a NAT gateway is charged separately from other [outgoing traffic](#prices-traffic) but according to the same pricing policy.

> For example:
>
> If you transmit 110 GB of outgoing traffic via a NAT gateway and 5 GB of outgoing traffic using other ways per month, you pay for 10 GB of the outgoing traffic sent via the NAT gateway.
>
> If you transmit 110 GB of outgoing traffic via a NAT gateway and 105 GB of outgoing traffic using other ways per month, you pay for 10 GB of the outgoing traffic sent via the NAT gateway and 5 GB of the other outgoing traffic.




The first 100 GB of outgoing traffic via NAT gateway are provided free of charge every month.

The minimum billing unit is 1 MB.

{% include notitle [usd-egress-nat-traffic.md](../_pricing/vpc/usd-egress-nat-traffic.md) %}


#### Using security groups {#prices-security-groups}

[Security groups](concepts/security-groups.md) can be used free of charge.

#### Egress traffic {#prices-traffic}

{% include notitle [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}



### {{ ddos-protection-full-name }} {#prices-ddos-protection}



All prices are shown without VAT.

{% include [usd-ddos](../_pricing/vpc/usd-ddos.md) %}


Filtered traffic is incoming traffic that the DDoS Protection filtering system passes to the user's cloud resources. Only filtered traffic is charged.

For example, let's assume a user's VM was subject to a typical 10 Gbps DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded 2 GB of filtered files from the internet to the VM. When the attack ended, the user downloaded another 2 GB of useful files.

In this case, only 4 GB of filtered traffic are charged: 2 GB that DDoS Protection passed to cloud resources during the attack, and 2 GB downloaded after the attack. Malicious traffic is filtered out and not charged.

### {{ adv-ddos-protection }} {#prices-ddos-advanced}

The {{ adv-ddos-protection }} service is activated upon request through the [form](https://forms.yandex.ru/surveys/13203262.d03e905cf02195bec1093aa2b032802fe13caac0/).

{% note warning "Important" %}

Please note that the subscription fee for the {{ adv-ddos-protection }} and Managed Web Application Firewall services is charged for the whole month and is not in proportion to the number of days. For example, if you activate or deactivate the services mid-month you will still be charged the full subscription fee.

Usage beyond the subscription fee is billed in the next reporting month. For example, services consumed in July will be included into the August bill.

{% endnote %}

The prevailing traffic bandwidth for the billing period is calculated as a one-minute average of the highest traffic between the site's incoming and outgoing traffic filtered by the network. At the end of the billing period, 90 recorded maximum traffic values are discarded, and the maximum remaining value is rounded down to the nearest whole number of Mbps. The resulting number represents the prevailing traffic bandwidth for the purpose of calculating the traffic fee.

The excess is calculated by multiplying 1 Mbps of traffic by the prevailing traffic bandwidth.



All prices are shown without VAT.

{% include [usd-advanced-ddos](../_pricing/vpc/usd-advanced-ddos.md) %}


{% cut "**Service plan parameters:**" %}

| Service plan | Professional<br/>(Pro) | Business<br/>(Bsns) | Corporate<br/>(Corp) | Enterprise<br/>(ENT) |
| --- | --- | --- | --- | --- |
| Included volumes to filter out malicious (unwanted) traffic, up to | 10 Gbps | 50 Gbps | 500 Gbps | No limit |
| Guaranteed uptime of IT resources/websites per month (SLA) | At least 97% | At least 99% | At least 99.5% | Over 99.5% |
| Billable traffic | Legitimate | Legitimate | Legitimate | Legitimate |
| HTTPS traffic filtering using customer's private keys | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Let's Encrypt® certificate | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Active availability testing of customer's platform | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| HTTPS filtering without private keys | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| API access | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |

{% endcut %}

With the {{ adv-ddos-protection }} service plan, you can additionally activate the following services:



All prices are shown without VAT.

{% include [usd-advanced-ddos-services](../_pricing/vpc/usd-advanced-ddos-services.md) %}


### Managed Web Application Firewall {#prices-waf}



All prices are shown without VAT.

{% include [usd-waf](../_pricing/vpc/usd-waf.md) %}


The Managed Web Application Firewall plan includes the following services:

{% include [waf-services.md](../_pricing/vpc/waf-services.md) %}
