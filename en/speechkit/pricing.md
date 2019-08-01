---
editable: false
---
# Pricing for {{ speechkit-name }}

{% include [use-calculator](../_includes/pricing/use-calculator.md) %}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ speechkit-short-name }} {#rules}

### Speech synthesis use {#rules-tts}

The cost of using the SpeechKit API for speech synthesis is calculated based on the total number of characters sent to generate speech from text in a calendar month ([Reporting period](https://cloud.yandex.com/docs/billing/concepts/glossary)).

{% include [pricing-symbol-count](../_includes/pricing-symbol-count.md) %}

### Speech recognition use {#rules-stt}

The final cost depends on the duration of the recognized audio. Cost is calculated for a calendar month ([Reporting period](https://cloud.yandex.com/docs/billing/concepts/glossary)).

#### Short audio recognition {#rules-stt-short}

These rules apply to short audio recognition [by request](stt/request.md) and [in streaming mode](stt/streaming.md).

Billable unit — a 15-second segment of single-channel audio. Shorter segments are rounded up (1 second becomes 15 seconds).

**Examples:**

- 1 audio fragment that is 37 seconds is billed as 45 seconds.

    **Explanation:** the audio is divided into 2 15-second segments and one 7-second segment. The length of the last segment is rounded up to 15 seconds. Total: 3 segments, 15 seconds each.

- 2 audio fragments that are 5 and 8 seconds are billed as 30 seconds.

    **Explanation:** the length of each audio is rounded up to 15 seconds. Total: 2 segments, 15 seconds each.

#### Long audio recognition {#rules-stt-long}

These rules apply to [long audio recognition](stt/transcribation.md).

Billable unit — 1 second of two-channel audio. Shorter segments are rounded up. The number of channels is rounded up to an even number.

The minimum billable amount is 15 seconds for every pair of channels. Audio that is shorter is billed as 15 seconds.

**Examples of rounding audio length:**

| Length | Number of channels | Seconds charged |
| --- | --- | --- |
| 1 second | 1 | 15 |
| 1 second | 2 | 15 |
| 1 second | 3 | 30 |
| 15.5 seconds | 2 | 16 |
| 15.5 seconds | 4 | 32 |

## Prices {#prices}

### Speech synthesis {#prices-tts}

{% list tabs %}

- Prices in USD

  | Service | Rate for 1 million characters, without VAT |
  | ----- | ----- |
  | Speech synthesis | $2.346805 |

- Prices in roubles

  | Service | Rate per 1 million characters,<br/>with VAT |
  | ----- | ----- |
  | Speech synthesis | ₽183.0508 |

{% endlist %}

### Speech recognition {#prices-stt}

{% list tabs %}

- Prices in USD

  | Service | Rate for the billable unit, without VAT |
  | ----- | ----- |
  | [Short audio recognition](#rules-stt-short) | $0.001953 |
  | [Long audio recognition](#rules-stt-long) | $0.000128 |

- Prices in roubles

  | Service | Rate for the billable unit, with VAT |
  | ----- | ----- |
  | [Short audio recognition](#rules-stt-short) | ₽0.1524 |
  | [Long audio recognition](#rules-stt-long) | ₽0.01 |

{% endlist %}
