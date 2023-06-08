---
description: "Image classification enables you to see whether an image matches a certain property (for instance, contains adult-only content). This can reduce the cost of manual moderation because you will be able to ban such images automatically."
keywords:
  - image classification
---

# Image classification

_Image classification is currently in the [Preview stage](../../../overview/concepts/launch-stages.md)._

This section describes how the _image classification_ feature works in the service.

Use this feature to find out how well an image matches a certain property (for instance, whether the image contains adult-only content). This can reduce the cost of manual moderation because you will be able to ban such images automatically.

The list of properties that the result is returned for depends on the selected model. For example, the `quality` model, which is used to assess the quality of an image, returns the probabilities for properties such as `low`, `medium`, and `high`. [More information about supported models](supported-models.md).

## Request format {#request-format}

To use this feature, specify `CLASSIFICATION` in the feature type and pass the name of the [model](supported-models.md):

```json
{
  "folderId": "b1gvmob95yysaplct532",
  "analyze_specs": [{
    "content": "iVBORw0KGgo...",
    "features": [{
      "type": "CLASSIFICATION",
      "classificationConfig": {
        "model": "quality"
      }
    }]
  }]
}
```

Only one model can be used within a single analysis feature. If you need to apply more models to your image, pass another object in `features`:

```json
{
  "folderId": "b1gvmob95yysaplct532",
  "analyze_specs": [{
    "content": "iVBORw0KGgo...",
    "features": [{
      "type": "CLASSIFICATION",
      "classificationConfig": {
        "model": "quality"
      }
    },
    {
      "type": "CLASSIFICATION",
      "classificationConfig": {
        "model": "moderation"
      }
    }]
  }]
}
```

## Service response {#service-response}

The service returns a list of properties in the following format:

```json
{
  "name": "low", // Property name.
  "probability": 0.71257284 // Probability of matching the property.
}
```

The service returns all properties for the selected model, even if the probability for a property is zero.

**Response example**:

{% include [classification-quality-response](../../../_includes/vision/classification-quality-response.md) %}

#### What's next {#what-is-next}

* [View the list of supported models](supported-models.md).
* [See how to handle errors](../../api-ref/errors-handling.md).