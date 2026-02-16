---
editable: false
sourcePath: en/_api-ref-grpc/ai/vision/v2/classifier/api-ref/grpc/ImageClassifier/annotate.md
---

# Vision Classifier API, gRPC: ImageClassifierService.Annotate

## gRPC request

**rpc Annotate ([AnnotationRequest](#yandex.cloud.ai.vision.v2.AnnotationRequest)) returns ([AnnotationResponse](#yandex.cloud.ai.vision.v2.AnnotationResponse))**

## AnnotationRequest {#yandex.cloud.ai.vision.v2.AnnotationRequest}

```json
{
  "image": {
    // Includes only one of the fields `content`
    "content": "bytes",
    // end of the list of possible fields
    "image_type": "ImageType"
  }
}
```

request for annotation

#|
||Field | Description ||
|| image | **[Image](#yandex.cloud.ai.vision.v2.Image)**

image to annotate ||
|#

## Image {#yandex.cloud.ai.vision.v2.Image}

#|
||Field | Description ||
|| content | **bytes**

bytes with data

Includes only one of the fields `content`. ||
|| image_type | enum **ImageType**

type of data

- `IMAGE_TYPE_UNSPECIFIED`
- `JPEG`
- `PNG` ||
|#

## AnnotationResponse {#yandex.cloud.ai.vision.v2.AnnotationResponse}

```json
{
  "request_id": "string",
  "classifier_specification": {
    "labels": [
      {
        "name": "string",
        "description": "string"
      }
    ],
    "classification_type": "ClassificationType"
  },
  "annotations": [
    {
      "label": {
        "name": "string",
        "description": "string"
      },
      "confidence": "double"
    }
  ]
}
```

#|
||Field | Description ||
|| request_id | **string**

internal service requestId ||
|| classifier_specification | **[ClassifierSpecification](#yandex.cloud.ai.vision.v2.ClassifierSpecification)**

class specification ||
|| annotations[] | **[ClassAnnotation](#yandex.cloud.ai.vision.v2.ClassAnnotation)**

annotations for each class ||
|#

## ClassifierSpecification {#yandex.cloud.ai.vision.v2.ClassifierSpecification}

Specification of model used for annotation

#|
||Field | Description ||
|| labels[] | **[Label](#yandex.cloud.ai.vision.v2.Label)**

List of labels, annotated by service ||
|| classification_type | enum **ClassificationType**

type of annotation: exclusive (multi-class) or non-exclusive (multi-label)

- `CLASSIFICATION_TYPE_UNSPECIFIED`
- `MULTI_LABEL`
- `MULTI_CLASS` ||
|#

## Label {#yandex.cloud.ai.vision.v2.Label}

Description of single label

#|
||Field | Description ||
|| name | **string**

Label name ||
|| description | **string**

human readable description of label ||
|#

## ClassAnnotation {#yandex.cloud.ai.vision.v2.ClassAnnotation}

Image annotation for specific label

#|
||Field | Description ||
|| label | **[Label](#yandex.cloud.ai.vision.v2.Label)**

list of annotated labels ||
|| confidence | **double**

confidence for each label ||
|#