---
editable: false
---

# Pricing for {{ speechkit-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What goes into the cost of using {{ speechkit-short-name }} {#rules}

### Using speech synthesis {#rules-tts}


The cost of using {{ speechkit-name }} for speech synthesis depends on the version of the API you use. For [API v1](tts/request.md), the cost is calculated based on the total number of characters sent to generate speech from text in a calendar month ([Reporting period](../billing/concepts/glossary#period)).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

The cost of using [API v3](tts-v3/api-ref/grpc/index.md) depends on the number of synthesis requests sent. Speech synthesis requests have such limitations as {{ tts-v3-count }} and {{ tts-v3-time }}.




### Using speech recognition {#rules-stt}



The cost of using {{ speechkit-name }} for speech recognition depends on the recognition type and duration of a recognized audio fragment. The cost is calculated for a calendar month ([Reporting period](https://cloud.yandex.com/docs/billing/concepts/glossary)).

#### Streaming speech recognition {#rules-stt-streaming}

The cost of using {{ speechkit-name }} streaming recognition is calculated based on the [pricing rules for synchronous recognition](#rules-stt-short).

#### Synchronous recognition {#rules-stt-short}

These rules apply to [synchronous recognition](stt/request.md) and [streaming mode](stt/streaming.md) recognition when using API v2 and API v3.

The billing unit is a 15-second segment of single-channel audio. Shorter segments are rounded up (1 second becomes 15 seconds).

{% note warning %}

In [streaming mode](stt/streaming.md), billing begins when a [message with recognition settings](stt/streaming.md#specification-msg) is sent. Even if you don't send any audio after this message, it's treated as 1 consumed billable unit.

{% endnote %}

> **Examples:**
>
> * 1 audio fragment that is 37 seconds is billed as 45 seconds.
>
>    **Explanation:** the audio is divided into 2 15-second segments and one 7-second segment. The length of the last segment is rounded up to 15 seconds. Total: 3 segments, 15 seconds each.
>
> * 2 audio fragments that are 5 and 8 seconds are billed as 30 seconds.
>
>    **Explanation:** the length of each audio is rounded up to 15 seconds. Total: 2 segments, 15 seconds each.

#### Asynchronous recognition {#rules-stt-long}

These rules apply when using [asynchronous recognition](stt/transcribation.md).

The billing unit is a one-second segment of two-channel audio. Shorter segments are rounded up. The number of channels is rounded up to an even number.

The minimum billable amount is 15 seconds for every pair of channels. Shorter audio is billed as 15 seconds.

**Examples of rounding audio length:**

| Length | Number of channels | Seconds charged |
--- | --- | ---
| 1 second | 1 | 15 |
| 1 second | 2 | 15 |
| 1 second | 3 | 30 |
| 15.5 seconds | 2 | 16 |
| 15.5 seconds | 4 | 32 |


## Pricing {#prices}

### Speech synthesis {#prices-tts}





{% include [usd.md](../_pricing/speechkit/usd-tts.md) %}






### {{ brand-voice-name }} {#brand-voice}




{% include [usd.md](../_pricing/speechkit/usd-brand.md) %}




### Speech recognition {#prices-stt}





{% include [usd.md](../_pricing/speechkit/usd-stt.md) %}



