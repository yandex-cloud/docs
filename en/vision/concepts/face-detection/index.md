---
description: "Face detection is a tool that allows you to find human faces in an image. For example, you can use it to tag people in a photo or find all photos with portraits. {{ vision-full-name }} searches for human faces in the image and marks them with rectangles. The supported file formats are JPEG, PNG, and PDF."
noIndex: true
keywords:
  - face detection
  - detect face
---

# Face detection

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

This section describes how the {{ vision-full-name }} _face detection_ feature works.

This feature allows you to detect human faces in an image. For example, you can use it to tag people in a photo or find all photos with portraits.

{% note info %}

This feature cannot recognize faces. You will not be able to use it to find similar faces or identify a person.

{% endnote %}

## Request format {#request-format}

In the feature type, specify `FACE_DETECTION`:

```json
{
  "folderId": "b1gvmob95yys********",
  "analyze_specs": [{
    "content": "iVBORw0KGgo...",
    "features": [{
      "type": "FACE_DETECTION"
    }]
  }]
}
```

## Service response {#service-response}

{{ vision-full-name }} searches for human faces in the image and marks them with rectangles. In the response, it returns the coordinates of the rectangles for all detected faces:

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

* [Try detecting faces in an image](../../operations/face-detection/index.md)
* [Learn how to handle errors](../../api-ref/errors-handling.md)