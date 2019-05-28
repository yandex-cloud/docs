# Face detection

_Face detection is currently at the [Preview stage](/docs/overview/concepts/launch-stages)._

This section describes how the _face detection_ feature works in the service.

This feature lets you find human faces in an image. For example, you can use it to mark people in a photo or find all photos with portraits.

> [!NOTE]
>
> This feature doesn't recognize faces. You will not be able to use it to find similar faces or identify a person.

## Request format

In the feature type, specify `FACE_DETECTION`:

```json
{
    "folderId": "ajk55f3mblj12eghq2oe",
    "analyze_specs": [{
        "content": "iVBORw0KGgo...",
        "features": [{
            "type": "FACE_DETECTION"
        }]
    }]
}
```

## Service response

The service searches for human faces in the image and marks them with rectangles. In the response, the service returns the coordinates of the rectangles for all detected faces:

![image](../../../_assets/vision/face-detection.jpg)

If two faces are adjacent, the rectangles may intersect.

[!INCLUDE [coordinates](../../../_includes/vision/coordinates.md)]

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
              }
            ]
          }
        }]
      }
    }]
  }]
}
```

## Image requirements

An image in a request must meet the following requirements:

[!INCLUDE [file-restrictions](../../../_includes/vision/file-restrictions.md)]

#### What's next

* [Try detecting faces in an image](../../operations/face-detection/index.md)
* [See how to handle errors](../../api-ref/errors-handling.md)

