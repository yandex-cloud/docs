---
title: '{{ cdn-full-name }} pricing policy'
description: This article covers the {{ cdn-full-name }} pricing policy.
editable: false
---

# {{ cdn-full-name }} pricing policy

{% include [pricing-change-warning](../_includes/cdn/pricing-change-warning.md) %}



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

The cost of using {{ cdn-name }} is based on:
* Amount of outbound traffic from CDN servers, including traffic requested from user resources on {{ yandex-cloud }}, e.g., {{ compute-full-name }} [virtual machines](../compute/concepts/vm.md). Inbound traffic to the CDN servers from {{ yandex-cloud }} services and resources or from the internet is free of charge.
* Paid features enabled for your resources: [origin shielding](concepts/origins-shielding.md), [log export](concepts/logs.md), and [dedicated IP addressing](concepts/dedicated-ip-addressing.md).

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



