---
title: '{{ cdn-full-name }} pricing policy'
description: This article covers the {{ cdn-full-name }} pricing policy.
editable: false
---

# {{ cdn-full-name }} pricing policy

{% note warning %}


Starting July 1, 2026, a new {{ cdn-name }} pricing model has come into effect.



{% endnote %}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      md: 4
    indent:
      top: '0'
      bottom: '0'
    children:
      - type: basic-card
        title: Price calculator
        text: Calculate the cost of the service based on your needs
        gravityIcon: Calculator
        iconPosition: left
        urlTitle: Price calculator
        url: https://yandex.cloud/en/prices?state=92a45574d7a3#calculator
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        gravityIcon: CircleRuble
        iconPosition: left
        urlTitle: Price list
        url: https://yandex.cloud/en/price-list?services=dn2rse5n40m8h0bu8jqa
        size: s
        border: shadow
        centered: true
        indent:
          top: '0'
          bottom: '0'
:::



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

The cost of using {{ cdn-name }} is based on:
* Total [CDN resources](./concepts/resource.md).
* Outgoing traffic over the 150 GB free monthly quota per resource, charged per 1 GB. 

    Deleting a resource forfeits any remaining free traffic. You cannot transfer traffic from one resource to another.

    You pay for outgoing traffic from CDN servers, including traffic requested from user resources of {{ yandex-cloud }} services, e.g., {{ compute-full-name }} [VM instances](../compute/concepts/vm.md). Inbound traffic to the CDN servers from {{ yandex-cloud }} services and resources or from the internet is free of charge.

* Number of requests to CDN resources in excess of the 100,000,000 free monthly threshold, charged per 100,000 requests.
* Paid features enabled for your resources, such as [origin shielding](concepts/origins-shielding.md), [log export](./concepts/logs.md), and [dedicated IP addressing](./concepts/dedicated-ip-addressing.md).

## Traffic between the origin and CDN servers {#origin-cdn-traffic}

{% include [origin-cdn-traffic](../_includes/cdn/origin-cdn-traffic.md) %}


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

You will be charged for a full month on the day you enable [origin shielding](concepts/origins-shielding.md), [dedicated IP addressing](concepts/dedicated-ip-addressing.md), or [log export](concepts/logs.md). Also, a fee is charged for the included outgoing traffic package on the day the CDN resource is created. Thereafter, you will be charged on the first day of every next month.

You can choose one of the following billing models when [activating dedicated IP addressing](operations/resources/dedicated-ip-addressing.md):

* Per individual [CDN resource](concepts/resource.md). This option is cost-effective if you have few CDN resources or need dedicated IP addresses only for some of them.
* For all CDN resources of your [billing account](../billing/concepts/billing-account.md). This is optimal if you need dedicated IP addresses for multiple CDN resources.

{% include [pricing-for-dedicated-ip.md](../_includes/cdn/pricing-for-dedicated-ip.md) %}




<MDX>
  <PriceList
    serviceIds={['{{ pcs|cdn }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>

