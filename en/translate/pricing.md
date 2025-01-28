---
title: '{{ translate-full-name }} pricing policy'
description: This article provides the {{ translate-name }} pricing policy.
editable: false
---

# {{ translate-name }} pricing policy



{% note tip %}




To calculate the cost of using the service, use the [calculator](https://yandex.cloud/en/prices?state=431d2333ac46#calculator) on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ translate-short-name }} {#rules}


### Translation and language detection {#rules-translate-detect}

The cost of using {{ translate-full-name }} is calculated based on the total number of characters submitted in translation and language detection requests within a calendar month ([Reporting period](../billing/concepts/reporting-period.md)). [Translation requests](operations/translate.md) are charged only for text translation. Unless explicitly specified in the translation request, source language detection is included in the translation charge. Language detection will be chargeable if you submit a separate [language detection request](operations/detect.md).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Translation and language detection {#prices-translate-detect}



{% include [usd.md](../_pricing/translate/usd.md) %}


