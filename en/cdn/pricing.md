---
title: '{{ cdn-full-name }} pricing policy'
description: This article covers the {{ cdn-full-name }} pricing policy.
editable: false
---

# {{ cdn-full-name }} pricing policy

{% note warning %}

Starting July 1, 2026, a new pricing model for {{ cdn-name }} is in effect.

{% endnote %}

::: page-constructor
blocks:
  - type: card-layout-block
    animated: false
    colSizes:
      all: 12
      sm: 4
    children:
      - type: basic-card
        title: Price list
        text: Current prices of all our services
        icon: _assets/icons/circle-ruble.svg
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
* The number of [CDN resources](./concepts/resource.md).
* The volume of outgoing traffic exceeding the 150 GB of free traffic per month for each resource, charged per 1 GB.

    When a resource is deleted, the remaining free traffic is reset to zero. Transferring traffic between resources is not possible.

    Outgoing traffic from CDN servers is taken into account, including traffic requested from user resources of {{ yandex-cloud }} services, for example, from {{ compute-full-name }} [virtual machines](../compute/concepts/vm.md). Incoming traffic to CDN servers from {{ yandex-cloud }} services and resources and from the internet is not charged.

* The number of requests to CDN resources exceeding the free threshold of 100,000,000 requests per month, charged per 100,000 requests.
* Paid features enabled for resources: [origin shielding](concepts/origins-shielding.md), [log export](./concepts/logs.md), and [dedicated IP addressing](./concepts/dedicated-ip-addressing.md).


## Prices for the Russia region {#prices}



{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

You will be charged for a full month on the day you enable [origin shielding](concepts/origins-shielding.md) or [log export](concepts/logs.md). Thereafter, you will be charged on the first day of every next month.

You can choose one of the following billing models when [activating dedicated IP addressing](operations/resources/dedicated-ip-addressing.md):

* Per individual [CDN resource](concepts/resource.md). This option is cost-effective if you have few CDN resources or need dedicated IP addresses only for some of them.
* For all CDN resources of your [billing account](../billing/concepts/billing-account.md). This is optimal if you need dedicated IP addresses for multiple CDN resources.




<MDX>
  <PriceList
    serviceIds={['{{ pcs|cdn }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>

