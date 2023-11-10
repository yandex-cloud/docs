# Supported models

_Image classification is currently at the [Preview stage](../../../overview/concepts/launch-stages.md)._

{{ vision-full-name }} provides image classification based on a model that is trained on a specific set of images. The model is specified in the `classificationConfig` configuration of a request.

You can only include one of the two property types in the model:

* Mutually exclusive: The sum of probabilities of all model properties is equal to one.
* Independent: The probability of each property is equal to any value between zero and one.

Currently, the following models are supported:

* [quality](#quality): Assesses the quality of an image.
* [moderation](#moderation): Estimates whether an image meets moderation requirements.

## quality {#quality}

This model assesses the quality of an image.

**With it, you can:**

* Filter low-quality images, for example, to exclude them from search results.
* Moderate images for a photo contest and select only high-quality ones.
* Compare similar images and choose the one with the best quality.

You can [try this model](../../operations/classification/quality.md) now.

The **property type** for this model is mutually exclusive.

The **properties** are as follows:

* `low`: Low-quality image with clearly visible artifacts.
* `medium`: Regular quality image with minor artifacts.
* `high`: High-quality image without visible artifacts.

**Examples of classification results:**

{% list tabs %}

- High

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

- Medium

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

- Low

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

**With it, you can:**

* Filter adult content.
* Detect illegal content.
* Show a copyright violation warning for images with watermarks.
* Check whether there is text in an image to use the [text recognition feature](../ocr/index.md) afterwards.

You can [try this model](../../operations/classification/moderation.md) now.

The **property type** for this model is independent.

The **properties** are as follows:

* `adult`: The image has adult content.
* `gruesome`: The image has shocking content.
* `text`: The image has text.
* `watermarks`: The image has watermarks.

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
