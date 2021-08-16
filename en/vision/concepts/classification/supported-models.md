# Supported models

_Image classification is currently in the [Preview stage](/docs/overview/concepts/launch-stages)._

The service provides image classification based on a model that is trained on a specific set of images. The model is specified in the `classificationConfig` configuration of a request.

Only one of the two types of properties can be included in the model:

* Mutually exclusive: the sum of probabilities of all the model properties is equal to one.
* Independent: the probability of each property is equal to any value between 0 and 1.

Currently supported models:

* [quality](#quality) — Assesses the quality of an image.
* [moderation](#moderation) — Assesses whether an image meets moderation requirements.

## quality {#quality}

Assesses the quality of an image.

**With this model, you can:**

* Filter low-quality images, for example, to exclude them from search results.
* Moderate images for a photo contest and select only high-quality images.
* Compare similar images and choose the one with the best quality.

[Try this model](../../operations/classification/quality.md).

**Property type:** mutually exclusive.

**Properties:**

* `low`: a low-quality image with clearly visible artifacts.
* `medium`: a standard quality image with minor artifacts.
* `high`: a high-quality image without visible artifacts.

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

Evaluates how well the image matches the properties used during moderation.

**With this model, you can:**

* Filter adult content.
* Detect illegal content.
* Show a copyright violation warning for images with watermarks.
* Check whether there is text in an image to use the [text recognition feature](../ocr/index.md) afterwards.

[Try this model](../../operations/classification/moderation.md).

**Property type:** independent.

**Properties:**

* `adult`: the image shows adult-only content.
* `gruesome`: the image contains shocking content.
* `text`: the image contains text.
* `watermarks`: the image contains watermarks.

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

