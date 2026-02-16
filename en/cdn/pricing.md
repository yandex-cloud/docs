---
title: '{{ cdn-full-name }} pricing policy'
description: This article covers the {{ cdn-full-name }} pricing policy.
editable: false
---

# {{ cdn-full-name }} pricing policy



{% include [without-use-calculator](../_includes/pricing/without-use-calculator.md) %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

{% include [vat](../_includes/vat.md) %}

The cost of using {{ cdn-name }} is based on:
* Amount of outbound traffic from CDN servers, including traffic requested from user resources on {{ yandex-cloud }}, e.g., {{ compute-full-name }} [virtual machines](../compute/concepts/vm.md). Inbound traffic to the CDN servers from {{ yandex-cloud }} services and resources or from the internet is free of charge.
* Paid features enabled for your resources, such as [origin shielding](concepts/origins-shielding.md) and [log export](concepts/logs.md).

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

If the origin shielding or log export function is activated or deactivated on any day within the month, its full monthly price will be debited on the last day of the month.



<MDX>
  <PriceList
    serviceIds={['{{ pcs|cdn }}']}
    installationCode="ru"
    currency="USD"
  />
</MDX>



