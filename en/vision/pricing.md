---
editable: false
---
# Pricing for [!KEYREF vision-name]

## What goes into the cost of using [!KEYREF vision-short-name] {#rules}

The [!KEYREF vision-short-name] service provides _a set of features_ for analyzing images. In the current version, only text recognition is available.

Each image analysis using any feature is equal to one chargeable _unit_:

* If your request contains multiple images, each analyzed image is charged separately.
* If you send two requests to recognize text on the same image, you will be charged for two units. This makes sense when a text  [is written in languages from different language models](operations/ocr/text-detection.md#multiple-languages) (for example, it includes Arabic and Hebrew).
* Only successful analysis attempts are chargeable. You will not be charged if the server returned an error or the request configuration was incorrect.

## Pricing {#prices}

| Feature | For 1000 units<br>/month, without VAT | For 1000 units<br>/month, with VAT |
| ----- | ----- | ----- |
| Text recognition | 100 ₽ | 120 ₽ |

