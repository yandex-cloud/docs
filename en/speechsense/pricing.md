---
title: '{{ speechsense-full-name }} pricing policy'
description: This article provides the {{ speechsense-name }} pricing policy.
editable: false
---

# {{ speechsense-full-name }} pricing policy



{% note tip %}




To see the cost of analyzing an [audio conversation](https://yandex.cloud/en/prices?state=b22c4c9e4f90#calculator) or [text transcript](https://yandex.cloud/en/prices?state=5d33b1fb1362#calculator), use our calculator on the Yandex Cloud website or see the pricing in this section.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

## What goes into the cost of using {{ speechsense-name }} {#rules}

When analyzing audio recordings of dialogs, the cost of using {{ speechsense-name }} depends on the duration of two-channel audio files. The billing unit is a one-second segment of two-channel audio.

When analyzing text dialogs, the cost of using {{ speechsense-name }} depends on the number of characters in the dialog. Billing unit: 10 characters. The number of characters in each dialog is rounded up to the tens. The count includes all the dialog characters. 

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Audio dialog analysis {#speech}



{% include [usd.md](../_pricing/speechsense/usd-speechsense.md) %}


### Text dialog analysis {#text}

{% note warning %}

The price listed below will be effective starting September 10, 2024.

{% endnote %}



{% include [usd.md](../_pricing/speechsense/usd-text-dialogs.md) %}


### Example of calculating the cost of audio analysis {#price-example}



{% include [usd-speechsense](../_pricing_examples/speechsense/usd-speechsense.md) %}


