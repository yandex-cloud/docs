---
description: "Face detection is a tool that lets you find human faces in an image. For example, you can use it to mark people in a photo or find all photos with portraits. The service searches for human faces in the image and marks them with rectangles. Supported file formats: JPEG, PNG, and PDF."
keywords:
  - face detection
---

# Face detection

_Image classification is currently in the [Preview stage](../../../overview/concepts/launch-stages.md)._

This section describes how the _face detection_ feature works in the service.

This feature lets you find human faces in an image. For example, you can use it to mark people in a photo or find all photos with portraits.

{% note info %}

This feature doesn't recognize faces. You will not be able to use it to find similar faces or identify a person.

{% endnote %}

## Request format {#request-format}

In the feature type, specify `FACE_DETECTION`:

```json
{
  "folderId": "b1gvmob95yysaplct532",
  "analyze_specs": [{
    "content": "iVBORw0KGgo...",
    "features": [{
      "type": "FACE_DETECTION"
    }]
  }]
}
```

## Service response {#service-response}

The service searches for human faces in the image and marks them with rectangles. In the response, the service returns the coordinates of the rectangles for all detected faces:

![image](../../../_assets/vision/face-detection.jpg)

If two faces are adjacent, the rectangles may intersect.

{% include [coordinates](../../../_includes/vision/coordinates.md) %}

Sample response with the coordinates of the detected face:

```json
{
  "results": [{
    "results": [{
      "faceDetection": {
        "faces": [{
          "boundingBox": {
            "vertices": [{
              "x": "410",
              "y": "404"
            },
            {
              "x": "410",
              "y": "467"
            },
            {
              "x": "559",
              "y": "467"
            },
            {
              "x": "559",
              "y": "404"
            }]
          }
        }]
      }
    }]
  }]
}
```

## Image requirements {#image-requirements}

An image in a request must meet the following requirements:

{% include [file-restrictions](../../../_includes/vision/file-restrictions.md) %}

#### What's next {#what-is-next}

* [Try detecting faces in an image](../../operations/face-detection/index.md).
* [See how to handle errors](../../api-ref/errors-handling.md).