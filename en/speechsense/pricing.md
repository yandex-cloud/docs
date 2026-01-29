---
title: '{{ speechsense-full-name }} pricing policy'
description: This article covers the {{ speechsense-name }} pricing policy.
editable: false
---

# {{ speechsense-full-name }} pricing policy



{% note tip %}




To calculate the cost of analytics for [chat transcripts](https://yandex.cloud/en/prices?state=5d33b1fb1362#calculator) and [conversation recordings](https://yandex.cloud/en/prices?state=b22c4c9e4f90#calculator), use the calculator on the {{ yandex-cloud }} website or check out the pricing below.


{% endnote %}

{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}


{% include [currency-choice](../_includes/pricing/currency-choice.md) %}


{% include [vat](../_includes/vat.md) %}

## What goes into the cost of using {{ speechsense-name }} {#rules}

When analyzing conversation recordings, the cost of using {{ speechsense-name }} depends on the duration of two-channel audio files. Single-channel audio is converted and charged as two-channel. The billing unit is a one-second segment of two-channel audio.

When analyzing chat transcripts, the cost of using {{ speechsense-name }} depends on the number of characters in such a chat. The billing unit is 10 characters. The number of characters in each chat is rounded up to the tens. The count includes all characters in the chat.

Automatic recalculation of modified and newly created dictionary and semantic [tags](../speechsense/concepts/tags.md) is not charged.

## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Conversation recording analysis {#speech}



{% include [usd.md](../_pricing/speechsense/usd-speechsense.md) %}


### Chat transcript analysis {#text}



{% include [usd.md](../_pricing/speechsense/usd-text-dialogs.md) %}


### Cost of using models in the assistant {#price-model-assistant}



{% include [usd-model.md](../_pricing/speechsense/usd-model-assistant.md) %}


### Cost calculation example for audio analysis {#price-example-speech}



{% include [usd-speechsense](../_pricing_examples/speechsense/usd-speechsense.md) %}


### Example of calculating the cost of chat transcript analysis {#price-example-text}

#### Example 1 {#example-1}

Let's assume you analyzed 90,000,015 characters over a month of using {{ speechsense-name }}. The number of characters in each chat is rounded up to the tens. This means, the billable amount is 90,000,020 characters, or 90,000.02 thousand characters.



{% include [usd-speechsense-text-100k](../_pricing_examples/speechsense/usd-speechsense-text-100k.md) %}


#### Example 2 {#example-2}

Let's assume you analyzed 150,000,023 characters over a month of using {{ speechsense-name }}. The number of characters in each chat is rounded up to the tens. This means, the billable amount is 150,000,030 characters, or 150,000.03 thousand characters.



{% include [usd-speechsense-text-500k](../_pricing_examples/speechsense/usd-speechsense-text-500k.md) %}


#### Example 3 {#example-3}

Let's assume you analyzed 685,000,000 characters, or 685,000 thousand characters, over a month of using {{ speechsense-name }}.



{% include [usd-speechsense-text-1M](../_pricing_examples/speechsense/usd-speechsense-text-1M.md) %}


### Cost calculation example for audio analysis using the assistant {#price-example}

The filter captured audio recordings totaling 115,000 minutes. The assistant supports 3,000 characters, counted across the **Instruction** and **Result** sections.

{{ speechsense-name }} recognized and analyzed audio recordings totaling 115,000 minutes. The instruction, result fields, and audio recordings were fed into YandexGPT Pro. One minute of audio equals roughly 1,000 characters (this value may vary depending on the speech rate).



{% include [usd-assistant](../_pricing_examples/speechsense/usd-assistant.md) %}


