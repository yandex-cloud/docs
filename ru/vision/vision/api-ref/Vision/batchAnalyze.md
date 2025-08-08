---
editable: false
apiPlayground:
  - url: https://vision.{{ api-host }}/vision/v1/batchAnalyze
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        analyzeSpecs:
          description: |-
            **[AnalyzeSpec](/docs/vision/vision/api-ref/Vision/batchAnalyze#yandex.cloud.ai.vision.v1.AnalyzeSpec)**
            A list of specifications. Each specification contains the file to analyze and features to use for analysis.
            Restrictions:
            * Supported file formats: `JPEG`, `PNG`.
            * Maximum file size: 1 MB.
            * Image size should not exceed 20M pixels (length x width).
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  content:
                    description: |-
                      **string** (bytes)
                      Image content, represented as a stream of bytes.
                      Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64.
                      Includes only one of the fields `content`, `signature`.
                    type: string
                    format: bytes
                  signature:
                    description: |-
                      **string**
                      Includes only one of the fields `content`, `signature`.
                    type: string
        folderId:
          description: |-
            **string**
            ID of the folder to which you have access.
            Required for authorization with a user account.
            Don't specify this field if you make the request on behalf of a service account.
          type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/ai/vision/v1/vision/api-ref/Vision/batchAnalyze.md
---

# Vision API, REST: Vision.BatchAnalyze

Analyzes a batch of images and returns results with annotations.

## HTTP request

```
POST https://vision.{{ api-host }}/vision/v1/batchAnalyze
```

## Body parameters {#yandex.cloud.ai.vision.v1.BatchAnalyzeRequest}

```json
{
  "analyzeSpecs": [
    {
      // Includes only one of the fields `content`, `signature`
      "content": "string",
      "signature": "string",
      // end of the list of possible fields
      "features": [
        {
          "type": "string",
          // Includes only one of the fields `classificationConfig`, `textDetectionConfig`
          "classificationConfig": {
            "model": "string"
          },
          "textDetectionConfig": {
            "languageCodes": [
              "string"
            ],
            "model": "string"
          }
          // end of the list of possible fields
        }
      ],
      "mimeType": "string"
    }
  ],
  "folderId": "string"
}
```

#|
||Field | Description ||
|| analyzeSpecs[] | **[AnalyzeSpec](#yandex.cloud.ai.vision.v1.AnalyzeSpec)**

A list of specifications. Each specification contains the file to analyze and features to use for analysis.

Restrictions:
* Supported file formats: `JPEG`, `PNG`.
* Maximum file size: 1 MB.
* Image size should not exceed 20M pixels (length x width). ||
|| folderId | **string**

ID of the folder to which you have access.
Required for authorization with a user account.
Don't specify this field if you make the request on behalf of a service account. ||
|#

## AnalyzeSpec {#yandex.cloud.ai.vision.v1.AnalyzeSpec}

#|
||Field | Description ||
|| content | **string** (bytes)

Image content, represented as a stream of bytes.
Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64.

Includes only one of the fields `content`, `signature`. ||
|| signature | **string**

Includes only one of the fields `content`, `signature`. ||
|| features[] | **[Feature](#yandex.cloud.ai.vision.v1.Feature)**

Requested features to use for analysis.

Max count of requested features for one file is 8. ||
|| mimeType | **string**

[MIME type](https://en.wikipedia.org/wiki/Media_type) of content (for example, `` application/pdf ``). ||
|#

## Feature {#yandex.cloud.ai.vision.v1.Feature}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of requested feature.

- `TYPE_UNSPECIFIED`
- `TEXT_DETECTION`: Text detection (OCR) feature.
- `CLASSIFICATION`: Classification feature.
- `FACE_DETECTION`: Face detection feature.
- `IMAGE_COPY_SEARCH`: Image copy search. ||
|| classificationConfig | **[FeatureClassificationConfig](#yandex.cloud.ai.vision.v1.FeatureClassificationConfig)**

Required for the `CLASSIFICATION` type. Specifies configuration for the classification feature.

Includes only one of the fields `classificationConfig`, `textDetectionConfig`. ||
|| textDetectionConfig | **[FeatureTextDetectionConfig](#yandex.cloud.ai.vision.v1.FeatureTextDetectionConfig)**

Required for the `TEXT_DETECTION` type. Specifies configuration for the text detection (OCR) feature.

Includes only one of the fields `classificationConfig`, `textDetectionConfig`. ||
|#

## FeatureClassificationConfig {#yandex.cloud.ai.vision.v1.FeatureClassificationConfig}

#|
||Field | Description ||
|| model | **string**

Model to use for image classification. ||
|#

## FeatureTextDetectionConfig {#yandex.cloud.ai.vision.v1.FeatureTextDetectionConfig}

#|
||Field | Description ||
|| languageCodes[] | **string**

List of the languages to recognize text.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `ru`). ||
|| model | **string**

Model to use for text detection.
Possible values:
* `page` (default): this model is suitable for detecting multiple text entries in an image.
* `line`: this model is suitable for cropped images with one line of text. ||
|#

## Response {#yandex.cloud.ai.vision.v1.BatchAnalyzeResponse}

**HTTP Code: 200 - OK**

```json
{
  "results": [
    {
      "results": [
        {
          // Includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`
          "textDetection": {
            "pages": [
              {
                "width": "string",
                "height": "string",
                "blocks": [
                  {
                    "boundingBox": {
                      "vertices": [
                        {
                          "x": "string",
                          "y": "string"
                        }
                      ]
                    },
                    "lines": [
                      {
                        "boundingBox": {
                          "vertices": [
                            {
                              "x": "string",
                              "y": "string"
                            }
                          ]
                        },
                        "words": [
                          {
                            "boundingBox": {
                              "vertices": [
                                {
                                  "x": "string",
                                  "y": "string"
                                }
                              ]
                            },
                            "text": "string",
                            "confidence": "string",
                            "languages": [
                              {
                                "languageCode": "string",
                                "confidence": "string"
                              }
                            ],
                            "entityIndex": "string"
                          }
                        ],
                        "confidence": "string"
                      }
                    ]
                  }
                ],
                "entities": [
                  {
                    "name": "string",
                    "text": "string"
                  }
                ]
              }
            ]
          },
          "classification": {
            "properties": [
              {
                "name": "string",
                "probability": "string"
              }
            ]
          },
          "faceDetection": {
            "faces": [
              {
                "boundingBox": {
                  "vertices": [
                    {
                      "x": "string",
                      "y": "string"
                    }
                  ]
                }
              }
            ]
          },
          "imageCopySearch": {
            "copyCount": "string",
            "topResults": [
              {
                "imageUrl": "string",
                "pageUrl": "string",
                "title": "string",
                "description": "string"
              }
            ]
          },
          // end of the list of possible fields
          "error": {
            "code": "integer",
            "message": "string",
            "details": [
              "object"
            ]
          }
        }
      ],
      "error": {
        "code": "integer",
        "message": "string",
        "details": [
          "object"
        ]
      }
    }
  ]
}
```

#|
||Field | Description ||
|| results[] | **[AnalyzeResult](#yandex.cloud.ai.vision.v1.AnalyzeResult)**

Request results.
Results have the same order as specifications in the request. ||
|#

## AnalyzeResult {#yandex.cloud.ai.vision.v1.AnalyzeResult}

#|
||Field | Description ||
|| results[] | **[FeatureResult](#yandex.cloud.ai.vision.v1.FeatureResult)**

Results for each requested feature.
Feature results have the same order as in the request. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|#

## FeatureResult {#yandex.cloud.ai.vision.v1.FeatureResult}

#|
||Field | Description ||
|| textDetection | **[TextAnnotation](#yandex.cloud.ai.vision.v1.TextAnnotation)**

Text detection (OCR) result.

Includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`. ||
|| classification | **[ClassAnnotation](#yandex.cloud.ai.vision.v1.ClassAnnotation)**

Classification result.

Includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`. ||
|| faceDetection | **[FaceAnnotation](#yandex.cloud.ai.vision.v1.FaceAnnotation)**

Face detection result.

Includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`. ||
|| imageCopySearch | **[ImageCopySearchAnnotation](#yandex.cloud.ai.vision.v1.ImageCopySearchAnnotation)**

Image Copy Search result.

Includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|#

## TextAnnotation {#yandex.cloud.ai.vision.v1.TextAnnotation}

#|
||Field | Description ||
|| pages[] | **[Page](#yandex.cloud.ai.vision.v1.Page)**

Pages of the recognized file.

For JPEG and PNG files contains only 1 page. ||
|#

## Page {#yandex.cloud.ai.vision.v1.Page}

#|
||Field | Description ||
|| width | **string** (int64)

Page width in pixels. ||
|| height | **string** (int64)

Page height in pixels. ||
|| blocks[] | **[Block](#yandex.cloud.ai.vision.v1.Block)**

Recognized text blocks in this page. ||
|| entities[] | **[Entity](#yandex.cloud.ai.vision.v1.Entity)**

Recognized entities ||
|#

## Block {#yandex.cloud.ai.vision.v1.Block}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the page where the text block is located. ||
|| lines[] | **[Line](#yandex.cloud.ai.vision.v1.Line)**

Recognized lines in this block. ||
|#

## Polygon {#yandex.cloud.ai.vision.v1.Polygon}

#|
||Field | Description ||
|| vertices[] | **[Vertex](#yandex.cloud.ai.vision.v1.Vertex)**

The bounding polygon vertices. ||
|#

## Vertex {#yandex.cloud.ai.vision.v1.Vertex}

#|
||Field | Description ||
|| x | **string** (int64)

X coordinate in pixels. ||
|| y | **string** (int64)

Y coordinate in pixels. ||
|#

## Line {#yandex.cloud.ai.vision.v1.Line}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the page where the line is located. ||
|| words[] | **[Word](#yandex.cloud.ai.vision.v1.Word)**

Recognized words in this line. ||
|| confidence | **string**

Confidence of the OCR results for the line. Range [0, 1]. ||
|#

## Word {#yandex.cloud.ai.vision.v1.Word}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the page where the word is located. ||
|| text | **string**

Recognized word value. ||
|| confidence | **string**

Confidence of the OCR results for the word. Range [0, 1]. ||
|| languages[] | **[DetectedLanguage](#yandex.cloud.ai.vision.v1.Word.DetectedLanguage)**

A list of detected languages together with confidence. ||
|| entityIndex | **string** (int64)

Id of recognized word in entities array ||
|#

## DetectedLanguage {#yandex.cloud.ai.vision.v1.Word.DetectedLanguage}

#|
||Field | Description ||
|| languageCode | **string**

Detected language code. ||
|| confidence | **string**

Confidence of detected language. Range [0, 1]. ||
|#

## Entity {#yandex.cloud.ai.vision.v1.Entity}

#|
||Field | Description ||
|| name | **string**

Entity name ||
|| text | **string**

Recognized entity text ||
|#

## ClassAnnotation {#yandex.cloud.ai.vision.v1.ClassAnnotation}

#|
||Field | Description ||
|| properties[] | **[Property](#yandex.cloud.ai.vision.v1.Property)**

Properties extracted by a specified model.

For example, if you ask to evaluate the image quality,
the service could return such properties as `good` and `bad`. ||
|#

## Property {#yandex.cloud.ai.vision.v1.Property}

#|
||Field | Description ||
|| name | **string**

Property name. ||
|| probability | **string**

Probability of the property, from 0 to 1. ||
|#

## FaceAnnotation {#yandex.cloud.ai.vision.v1.FaceAnnotation}

#|
||Field | Description ||
|| faces[] | **[Face](#yandex.cloud.ai.vision.v1.Face)**

An array of detected faces for the specified image. ||
|#

## Face {#yandex.cloud.ai.vision.v1.Face}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the image where the face is located. ||
|#

## ImageCopySearchAnnotation {#yandex.cloud.ai.vision.v1.ImageCopySearchAnnotation}

#|
||Field | Description ||
|| copyCount | **string** (int64)

Number of image copies ||
|| topResults[] | **[CopyMatch](#yandex.cloud.ai.vision.v1.CopyMatch)**

Top relevance result of image copy search ||
|#

## CopyMatch {#yandex.cloud.ai.vision.v1.CopyMatch}

#|
||Field | Description ||
|| imageUrl | **string**

url of image ||
|| pageUrl | **string**

url of page that contains image ||
|| title | **string**

page title that contains image ||
|| description | **string**

image description ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#