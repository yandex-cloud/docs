---
editable: false
---

# {{ speechkit-name }} pricing

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

## What goes into the cost of using {{ speechkit-short-name }} {#rules}

### Using speech synthesis {#rules-tts}


The cost of using {{ speechkit-name }} for speech synthesis depends on the version of the API you use.

#### API v1 {#api-v1}

For the [API v1](tts/request.md), the cost is calculated based on the total number of characters sent to generate speech from text in a calendar month ([Reporting period](../billing/concepts/glossary#period)).

#### API v3 {#api-v3}

The cost of using the [API v3](tts-v3/api-ref/grpc/index.md) depends on the number of synthesis requests sent.

By default, speech synthesis requests have such limitations as {{ tts-v3-count }} and {{ tts-v3-time }}. For synthesis of longer phrases, you can use `unsafe_mode`. In this case, you will be charged per 250 characters, e.g.:

* A request that is shorter than 250 characters is charged for as a single billing unit.
* A request that is from 250 to 500 characters long is charged for as two billing units.
* A request that is from 500 to 750 characters long is charged for as three billing units.

#### Empty request {#empty-request}

The number of characters in a request is determined considering spaces and special characters. The cost of an empty request depends on the API version:

* An empty request to the API v1 is charged for as a single character.
* An empty request to the API v3 is charged for as a single billing unit.

#### Internal server errors {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}




### Using speech recognition {#rules-stt}



The cost of using {{ speechkit-name }} for speech recognition depends on the recognition type and duration of a recognized audio fragment. The cost is calculated for a calendar month ([Reporting period](../billing/concepts/glossary.md)).

#### Streaming speech recognition {#rules-stt-streaming}

The cost of using {{ speechkit-name }} streaming recognition is calculated based on the [pricing rules for synchronous recognition](#rules-stt-short).

#### Synchronous recognition {#rules-stt-short}

These rules apply to [synchronous recognition](stt/request.md) and [streaming mode](stt/streaming.md) recognition when using the API v2 and API v3.

The billing unit is a 15-second segment of a single-channel audio file. Shorter segments are rounded up (1 second becomes 15 seconds).

{% note warning %}

In [streaming mode](stt/streaming.md), billing begins when a [message with recognition settings](stt/streaming.md#specification-msg) is sent. Even if you do not send any audio after this message, it will be treated as one consumed billing unit.

{% endnote %}

> **Examples:**
>
> * One audio fragment that is 37 seconds long is billed as 45 seconds.
>
>    **Explanation:** The audio is divided into two 15-second segments and one 7-second segment. The length of the last segment is rounded up to 15 seconds. Thus, we have three segments, 15 seconds each.
>
> * Two audio fragments that are 5 and 8 seconds long are billed as 30 seconds.
>
>    **Explanation:** The length of each audio is rounded up to 15 seconds. Thus, we have two segments, 15 seconds each.

#### Asynchronous recognition {#rules-stt-long}

These rules apply when using [asynchronous recognition](stt/transcribation.md).

The billing unit is a one-second segment of a two-channel audio file. Shorter segments are rounded up. The number of channels is rounded up to an even number.

The minimum billable amount is 15 seconds for every pair of channels. Shorter audio fragments are billed as 15 seconds.

**Examples of rounding audio length:**

| Length | Number of channels | Seconds charged |
--- | --- | ---
| 1 second | 1 | 15 |
| 1 second | 2 | 15 |
| 1 second | 3 | 30 |
| 15.5 seconds | 2 | 16 |
| 15.5 seconds | 4 | 32 |

#### Empty request {#empty-request}

The cost of an empty request to any type of speech recognition is equal to that of a single billing unit.

#### Incorrect request {#error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}


## Pricing {#prices}

### Speech synthesis {#prices-tts}





{% include [usd.md](../_pricing/speechkit/usd-tts.md) %}






### {{ brand-voice-name }} {#brand-voice}




{% include [usd.md](../_pricing/speechkit/usd-brand.md) %}




### Speech recognition {#prices-stt}





{% include [usd.md](../_pricing/speechkit/usd-stt.md) %}



