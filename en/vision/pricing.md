---
editable: false
---
# Pricing for {{ vision-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

## What goes into the cost of using {{ vision-short-name }} {#rules}

The {{ vision-short-name }} service provides [a set of features for image analysis](concepts/index.md#features).

Each successful image analysis performed using any feature is charged as a single _unit_:

* If your request contains multiple images, each analyzed image is charged separately.
* If you send two requests to recognize text on the same image, you will be charged for two units. This makes sense when a text  [is written in languages from different language models](operations/ocr/text-detection.md#multiple-languages) (for example, Arabic and Hebrew).
* Only successful analysis attempts are chargeable. You will not be charged if the server returned an error or the request configuration was incorrect.

[Face detection](concepts/face-detection/index.md) and [image classification](concepts/classification/index.md) are free of charge during the [Preview stage](../overview/concepts/launch-stages).

## Pricing {#prices}


{% list tabs %}

- Prices in USD

  | Feature | Rate for the billable unit, without VAT |
  | ----- | ----- |
  | [Text recognition](concepts/ocr/index.md) | $0.00153846 |

- Prices in roubles

  | Feature | Rate for the billable unit, with VAT |
  | ----- | ----- |
  | [Text recognition](concepts/ocr/index.md) | ₽0.1200 |

{% endlist %}
