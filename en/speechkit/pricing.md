---
title: '{{ speechkit-full-name }} pricing policy'
description: This article covers the {{ speechkit-full-name }} pricing policy.
editable: false
---

# {{ speechkit-name }} pricing policy


{% note tip %}




To calculate the cost of speech [synthesis](https://yandex.cloud/en/prices?state=ba3807f79625#calculator) and [recognition](https://yandex.cloud/en/prices?state=82857f5d8751#calculator), use the calculator on the {{ yandex-cloud }} website or see the pricing data in this section.


{% endnote %}



{% include [link-to-price-list](../_includes/pricing/link-to-price-list.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ speechkit-short-name }} {#rules}

### Using speech synthesis {#rules-tts}

The cost of using {{ speechkit-name }} for speech synthesis depends on the version of the API you use.



#### API v1 {#api-v1}

For the [API v1](tts/request.md), the cost is calculated based on the total number of characters sent to generate speech from text in a calendar month ([Reporting period](../billing/concepts/glossary.md)).


#### API v3 {#api-v3}

The cost of using the [API v3](tts-v3/api-ref/grpc/index.md) depends on the number of synthesis requests sent. The cost is calculated for a calendar month ([Reporting period](../billing/concepts/glossary.md)).

By default, speech synthesis requests have these limitations: {{ tts-v3-count }} and {{ tts-v3-time }}. To synthesize longer phrases, you can use `unsafe_mode`. In this case, you will be charged per 250 characters, e.g.:

* A request that is shorter than 250 characters is charged for as a single billing unit.
* A request that is from 250 to 500 characters long is charged for as two billing units.
* A request that is from 500 to 750 characters long is charged for as three billing units.

#### Empty request {#tts-empty-request}


The number of characters in a request is determined considering spaces and special characters. The cost of an empty request depends on the API version:

* An empty request to the API v1 is charged for as a single character.
* An empty request to the API v3 is charged for as a single billing unit.



#### Internal server errors {#tts-error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}

### Using speech recognition {#rules-stt}

The cost of using {{ speechkit-name }} for speech recognition depends on the recognition type and duration of a recognized audio fragment. The cost is calculated for a calendar month ([Reporting period](../billing/concepts/glossary.md)).

#### Streaming speech recognition {#rules-stt-streaming}

The cost of using {{ speechkit-name }} streaming recognition is calculated based on the [pricing rules for synchronous recognition](#rules-stt-short).


#### Synchronous recognition {#rules-stt-short}

These rules apply to [synchronous recognition](stt/request.md) and [streaming mode](stt/streaming.md) recognition when using the API v2 and API v3.

The billing unit is a 15-second segment of a single-channel audio file. Shorter segments are rounded up (1 second becomes 15 seconds).

{% note warning %}

In [streaming mode](stt/streaming.md), billing begins as soon as you send a [message with recognition settings](stt/streaming.md#specification-msg). If you do not send any audio after this message, it will be treated as one consumed billing unit.

{% endnote %}

> **Examples**:
>
> * One audio fragment that is 37 seconds long is billed as 45 seconds.
>
>    **Explanation:** The audio is divided into two 15-second segments and one 7-second segment. The length of the last segment is rounded up to 15 seconds. Thus, we have three segments, 15 seconds each.
>
> * Two audio fragments that are 5 and 8 seconds long are billed as 30 seconds.
>
>    **Explanation:** The length of each audio is rounded up to 15 seconds. Thus, we have two segments, 15 seconds each.


#### Asynchronous recognition with {#rules-stt-long}

These rules apply when using [asynchronous recognition](stt/transcribation.md).

The billing unit is a one-second segment of two-channel audio. Shorter segments are rounded up. The number of channels is rounded up to an even number.

The minimum billable amount is 15 seconds for every pair of channels. Shorter audio fragments are billed as 15 seconds.

**Examples of rounding the length of audio**

Length | Number of channels | Seconds charged
--- | --- | ---
1 second | 1 | 15
1 second | 2 | 15
1 second | 3 | 30
15.5 seconds | 2 | 16
15.5 seconds | 4 | 32

#### Empty request {#stt-empty-request}

The cost of an empty request to any type of speech recognition is equal to that of a single billing unit.

#### Internal server errors {#stt-error-request}

{% include [error-request](../_includes/speechkit/error-request.md) %}


## Prices for the Russia region {#prices}

{% include [pricing-diff-regions](../_includes/pricing-diff-regions.md) %}

### Speech synthesis {#prices-tts}



{% include [usd.md](../_pricing/speechkit/usd-tts.md) %}


### {{ brand-voice-name }} {#brand-voice}

{% note info %}

Prices for hosting {{ brand-voice-lite-name }} models will come into effect on July 2, 2025.

{% endnote %}



{% include [usd.md](../_pricing/speechkit/usd-brand.md) %}


### Speech recognition {#prices-stt}



{% include [usd.md](../_pricing/speechkit/usd-stt.md) %}





## Examples of cost calculation {#price-example}


### Speech synthesis using API v1 {#price-example-tts-v1}

The cost of using {{ speechkit-short-name }} for speech synthesis using the API v1 with the following parameters:

* **Number of characters sent per month**: 2023.



The cost is calculated as follows:

{% include [usd-speechkit-tts-v1](../_pricing_examples/speechkit/usd-speechkit-tts-v1.md) %}



### Speech synthesis using API v3 {#price-example-tts-v3}

The cost of using {{ speechkit-short-name }} for speech synthesis using the API v3 with the following parameters:

* **Number of requests sent**: 3.
* **Number of characters in requests**: 150, 300, 600.




The cost is calculated as follows:

{% include [usd-speechkit-tts-v3](../_pricing_examples/speechkit/usd-speechkit-tts-v3.md) %}


### Streaming speech recognition {#price-example-stt-streaming}

The cost of using {{ speechkit-short-name }} for streaming speech recognition with the following parameters:

* **Number of audio fragments**: 2.
* **Duration of audio fragments**: 5 seconds, 37 seconds.




The cost is calculated as follows:

{% include [usd-speechkit-stt-streaming](../_pricing_examples/speechkit/usd-speechkit-stt-streaming.md) %}



### Synchronous speech recognition {#price-example-stt-short}

The cost of using {{ speechkit-short-name }} for synchronous speech recognition with the following parameters:

* **Number of audio fragments**: 2.
* **Duration of audio fragments**: 5 seconds, 37 seconds.



The cost is calculated as follows:

{% include [usd-speechkit-stt-short](../_pricing_examples/speechkit/usd-speechkit-stt-short.md) %}



### Asynchronous speech recognition {#price-example-stt-long}

The cost of using {{ speechkit-short-name }} for asynchronous speech recognition with the following parameters:

* **Number of audio fragments**: 4.
* **Duration of audio fragments**: 5 seconds, 5 seconds, 15.5 seconds, 15.5 seconds.
* **Number of channels in audio fragments**: 1, 3, 2, 4.




The cost is calculated as follows:

{% include [usd-speechkit-stt-long](../_pricing_examples/speechkit/usd-speechkit-stt-long.md) %}



### Asynchronous speech recognition in deferred mode {#price-example-stt-long-deferred}

The cost of using {{ speechkit-short-name }} for asynchronous speech recognition in deferred mode with the following parameters:

* **Number of audio fragments**: 3.
* **Duration of audio fragments**: 2 seconds, 14 seconds, 19.5 seconds.
* **Number of channels in audio fragments**: 2, 3, 4.



The cost is calculated as follows:

{% include [usd-speechkit-stt-long-deferred](../_pricing_examples/speechkit/usd-speechkit-stt-long-deferred.md) %}


