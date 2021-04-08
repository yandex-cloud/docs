---
editable: false
---
# Pricing for {{ speechkit-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ speechkit-short-name }} {#rules}

### Using speech synthesis {#rules-tts}

The cost of using the SpeechKit API for speech synthesis is calculated based on the voice used and the total number of characters sent to generate speech from text in a calendar month ([Reporting period](../billing/concepts/glossary#period)).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

### Using speech recognition {#rules-stt}

The final cost depends on the duration of the recognized audio. Cost is calculated for a calendar month ([Reporting period](https://cloud.yandex.com/docs/billing/concepts/glossary)).

#### Short audio recognition {#rules-stt-short}

These rules apply to short audio recognition [by request](stt/request.md) and [in streaming mode](stt/streaming.md).

Billable unit — a 15-second segment of single-channel audio. Shorter segments are rounded up (1 second becomes 15 seconds).

{% note warning %}

In [streaming mode](stt/streaming.md), billing begins when a [message with recognition settings](stt/streaming.md#specification-msg) is sent. Even if you don't send any audio after this message, it's treated as 1 consumed billable unit.

{% endnote %}

**Examples:**

- 1 audio fragment that is 37 seconds is billed as 45 seconds.

    **Explanation:** the audio is divided into 2 15-second segments and one 7-second segment. The length of the last segment is rounded up to 15 seconds. Total: 3 segments, 15 seconds each.

- 2 audio fragments that are 5 and 8 seconds are billed as 30 seconds.

    **Explanation:** the length of each audio is rounded up to 15 seconds. Total: 2 segments, 15 seconds each.

#### Recognition of long audio fragments {#rules-stt-long}

These rules apply to [long audio recognition](stt/transcribation.md).

Billable unit — 1 second of two-channel audio. Shorter segments are rounded up. The number of channels is rounded up to an even number.

The minimum billable amount is 15 seconds for every pair of channels. Audio with a shorter duration is billed as 15 seconds.

**Examples of rounding audio length:**

| Length | Number of channels | Seconds charged |
| --- | --- | --- |
| 1 second | 1 | 15 |
| 1 second | 2 | 15 |
| 1 second | 3 | 30 |
| 15.5 seconds | 2 | 16 |
| 15.5 seconds | 4 | 32 |

## Pricing {#prices}

### Speech synthesis {#prices-tts}




{% include [usd.md](../_pricing/speechkit/usd-tts.md) %}

### Speech recognition {#prices-stt}




{% include [usd.md](../_pricing/speechkit/usd-stt.md) %}
