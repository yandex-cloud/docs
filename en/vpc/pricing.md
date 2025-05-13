---
title: '{{ vpc-full-name }} pricing policy'
description: This article covers the {{ vpc-name }} pricing policy.
editable: false
---

# {{ vpc-name }} pricing policy

{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vpc-short-name }} {#rules}

In {{ vpc-short-name }}, you pay for the hourly use of public IP addresses.

{% include [not-charged-vpc.md](../_includes/pricing/price-formula/not-charged-vpc.md) %}

{% include [free-tier.md](../_includes/pricing/price-formula/free-tier.md) %}

After deleting or stopping resources, you will continue to pay for the reserved public IP addresses. To avoid it, delete the IP addresses you no longer need.


## Prices for the Russia region {#prices}



{% note warning %}

Starting May 1, 2025, prices for {{ vpc-full-name }} resources will increase in the Russia region. You can view the new prices in USD [here](https://yandex.cloud/en/price-list?currency=USD&installationCode=ru&services=dn21qssbrdtcaus362kp).

{% endnote %}




{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}


### {{ vpc-short-name }} {#vpc-prices}

#### Public IP addresses {#prices-public-ip}

A public IP address can have one of the two statuses:

1. **Active**: When a _dynamic_ or _static_ public IP address is associated with a running cloud resource.
1. **Inactive**: When a _static_ public IP address is not associated with a cloud resource or it is associated with a stopped resource.


All prices are net of VAT.





{% include [usd-ip.md](../_pricing/vpc/usd-ip.md) %}


The cost of an inactive public static address includes the cost of a public IP address plus the cost of reserving an inactive public static IP address.

For example, the cost of an inactive public static address will be:




{% include [examples-usd-hour](../_pricing_examples/vpc/usd-hour.md) %}


#### NAT gateways {#nat-gateways}

You will be charged per hour of NAT gateway usage and for outgoing traffic via the gateway. Charges will apply as soon as you add a gateway to a route table.




{% include notitle [usd-egress-nat.md](../_pricing/vpc/usd-egress-nat.md) %}


##### Outgoing traffic via NAT gateways {#nat-gateway-egress-traffic}

Outgoing traffic via a NAT gateway exceeding 100 GB per month is billable.

Please note that the traffic transmitted via a NAT gateway is charged separately from other [outgoing traffic](#prices-traffic) but according to the same pricing policy.

> For example:
>
> If you transmit 110 GB of outgoing traffic via a NAT gateway and 5 GB of outgoing traffic using other ways per month, you pay for 10 GB of the outgoing traffic sent via the NAT gateway.
>
> If you transmit 110 GB of outgoing traffic via a NAT gateway and 105 GB of outgoing traffic using other ways per month, you pay for 10 GB of the outgoing traffic sent via the NAT gateway and 5 GB of the other outgoing traffic.




The first 100 GB of outgoing traffic via NAT gateway are provided free of charge every month.

The minimum charging unit is 1 MB.

{% include notitle [usd-egress-nat-traffic.md](../_pricing/vpc/usd-egress-nat-traffic.md) %}


#### Using security groups {#prices-security-groups}

You can use [security groups](concepts/security-groups.md) free of charge.

#### Outgoing traffic {#prices-traffic}

{% include notitle [note-public-ip-traffic.md](../_includes/pricing/note-public-ip-traffic.md) %}

{% include notitle [egress-traffic-pricing](../_includes/egress-traffic-pricing.md) %}



### {{ ddos-protection-full-name }} {#prices-ddos-protection}



All prices are net of VAT.

{% include [usd-ddos](../_pricing/vpc/usd-ddos.md) %}


Legitimate traffic is incoming traffic that passes through the DDoS Protection system to the user's cloud resources. You are only charged for the legitimate traffic.

For example, let's assume a user's VM was hit by a typical 10 Gbps DDoS attack generating 75 GB of incoming traffic. During the attack, the user downloaded to the VM 2 GB of legitimate files from the internet. When the attack ended, the user downloaded another 2 GB of legitimate files.

In this case, the user will be charged only for these 4 GB of legitimate traffic: 2 GB that passed through DDoS Protection to the cloud resources during the attack and 2 GB downloaded after the attack ended. Malicious traffic is filtered at no charge to the user.

### {{ adv-ddos-protection }} {#prices-ddos-advanced}

{{ adv-ddos-protection }} is activated upon request via the [form](https://forms.yandex.ru/surveys/13203262.d03e905cf02195bec1093aa2b032802fe13caac0/).

{% note info %}

Please note that the subscription fee for {{ adv-ddos-protection }} and Managed Web Application Firewall is charged for the whole month and is not calculated in proportion to the number of days. For example, if you activate or deactivate the services mid-month, you will still be charged the full subscription fee.

Usage beyond the subscription fee is billed in the next reporting month. For example, services consumed in July will be included into the August bill.

{% endnote %}

The prevailing traffic bandwidth for the billing period is calculated as a one-minute average of the highest traffic between the site's incoming and outgoing traffic filtered by the network. At the end of the billing period, 90 recorded maximum traffic values are discarded, and the maximum remaining value is rounded down to the nearest whole number of Mbps. This number is considered the prevailing traffic bandwidth for the purpose of calculating the traffic fee.

The excess is calculated by multiplying 1 Mbps of traffic by the prevailing traffic bandwidth.



All prices are net of VAT.

{% include [usd-advanced-ddos](../_pricing/vpc/usd-advanced-ddos.md) %}


{% cut "**Service plan parameters:**" %}

| Service plan | Professional<br/>(Pro) | Business<br/>(Bsns) | Corporate<br/>(Corp) | Enterprise<br/>(ENT) |
| --- | --- | --- | --- | --- |
| Included volumes to filter out malicious (unwanted) traffic, up to | 10 Gbps | 50 Gbps | 500 Gbps | No limit |
| Guaranteed uptime of IT resources/websites per month (SLA) | At least 97% | At least 99% | At least 99.5% | Over 99.5% |
| Billable traffic | Legitimate | Legitimate | Legitimate | Legitimate |
| HTTPS traffic filtering using customer's private keys | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Let's Encrypt® certificate | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| Active availability testing of customer's platforms | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| HTTPS filtering without private keys | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |
| API access | ![image](../_assets/common/no.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) | ![image](../_assets/common/yes.svg) |

{% endcut %}

With the {{ adv-ddos-protection }} service plan, you can additionally activate the following services:



All prices are net of VAT.

{% include [usd-advanced-ddos-services](../_pricing/vpc/usd-advanced-ddos-services.md) %}


### Managed Web Application Firewall {#prices-waf}



All prices are net of VAT.

{% include [usd-waf](../_pricing/vpc/usd-waf.md) %}


The Managed Web Application Firewall plan includes the following services:

{% include [waf-services](../_pricing/vpc/waf-services.md) %}

