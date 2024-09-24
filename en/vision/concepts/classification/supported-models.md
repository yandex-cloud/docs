---
noIndex: true
---

# Supported models

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

{{ vision-full-name }} provides image classification based on a model that is trained on a specific set of images. The model is specified in the `classificationConfig` configuration in the request.

You can only include one of the two property types in the model:

* Mutually exclusive: The sum of probabilities of all model properties is equal to one.
* Independent: The probability of each property is equal to any value between zero and one.

Currently, the following models are supported:

* [quality](#quality): Assesses the quality of an image.
* [moderation](#moderation): Estimates whether an image meets moderation requirements.

## quality {#quality}

This model assesses the quality of an image.

**With this model, you can**:

* Filter low-quality images, for example, to exclude them from search results.
* Moderate images for a photo contest and select only high-quality ones.
* Compare similar images and choose the one with the best quality.

[Try this model](../../operations/classification/quality.md).

**Type of properties**: Mutually exclusive.

**Properties**:

* `low`: Low-quality image with clearly visible artifacts.
* `medium`: Regular quality image with minor artifacts.
* `high`: High-quality image without visible artifacts.

**Examples of classification results:**

{% list tabs %}

- high

  ![image](../../../_assets/vision/high.jpg)

  ```json
  "properties": [
      {
          "name": "low",
          "probability": 0.00039277845644392073
      },
      {
          "name": "high",
          "probability": 0.93234682083129883
      },
      {
          "name": "medium",
          "probability": 0.06726035475730896
      }
  ]
  ```

- medium

  ![image](../../../_assets/vision/medium.jpg)

  ```json
  "properties": [
      {
          "name": "low",
          "probability": 0.072797946631908417
      },
      {
          "name": "high",
          "probability": 0.19245840609073639
      },
      {
          "name": "medium",
          "probability": 0.73474365472793579
      }
  ]
  ```

- low

  ![image](../../../_assets/vision/low.jpg)

  ```json
  "properties": [
      {
          "name": "low",
          "probability": 0.7901121973991394
      },
      {
          "name": "high",
          "probability": 0.004683326929807663
      },
      {
          "name": "medium",
          "probability": 0.20520441234111786
      }
  ]
  ```

{% endlist %}

## moderation {#moderation}

This model evaluates how well the image matches the moderation properties.

**With this model, you can:**

* Filter adult content.
* Detect illegal content.
* Demonstrate a copyright violation warning for images with watermarks.
* Check the image for text content so you can make use of [text recognition](../ocr/index.md).

[Try this model](../../operations/classification/moderation.md).

**Type of properties**: Independent.

**Properties**:

* `adult`: Image contains adult content.
* `gruesome`: Image contains shocking content.
* `text`: Image contains text.
* `watermarks`: Image contains watermarks.

**Example of a classification result:**

```json
"properties": [
    {
        "name": "adult",
        "probability": 0.0017486262368038297
    },
    {
        "name": "gruesome",
        "probability": 0.0002884353743866086
    },
    {
        "name": "text",
        "probability": 0.13789896667003632
    },
    {
        "name": "watermarks",
        "probability": 0.99908816814422607
    }
]
```