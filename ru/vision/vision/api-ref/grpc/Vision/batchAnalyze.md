---
editable: false
sourcePath: en/_api-ref-grpc/ai/vision/v1/vision/api-ref/grpc/Vision/batchAnalyze.md
---

# Vision API, gRPC: VisionService.BatchAnalyze

Analyzes a batch of images and returns results with annotations.

## gRPC request

**rpc BatchAnalyze ([BatchAnalyzeRequest](#yandex.cloud.ai.vision.v1.BatchAnalyzeRequest)) returns ([BatchAnalyzeResponse](#yandex.cloud.ai.vision.v1.BatchAnalyzeResponse))**

## BatchAnalyzeRequest {#yandex.cloud.ai.vision.v1.BatchAnalyzeRequest}

```json
{
  "analyze_specs": [
    {
      // Includes only one of the fields `content`, `signature`
      "content": "bytes",
      "signature": "string",
      // end of the list of possible fields
      "features": [
        {
          "type": "Type",
          // Includes only one of the fields `classification_config`, `text_detection_config`
          "classification_config": {
            "model": "string"
          },
          "text_detection_config": {
            "language_codes": [
              "string"
            ],
            "model": "string"
          }
          // end of the list of possible fields
        }
      ],
      "mime_type": "string"
    }
  ],
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| analyze_specs[] | **[AnalyzeSpec](#yandex.cloud.ai.vision.v1.AnalyzeSpec)**

A list of specifications. Each specification contains the file to analyze and features to use for analysis.

Restrictions:
* Supported file formats: `JPEG`, `PNG`.
* Maximum file size: 1 MB.
* Image size should not exceed 20M pixels (length x width). ||
|| folder_id | **string**

ID of the folder to which you have access.
Required for authorization with a user account (see [yandex.cloud.iam.v1.UserAccount](/docs/iam/api-ref/grpc/Federation/listUserAccounts#yandex.cloud.iam.v1.UserAccount) resource).
Don't specify this field if you make the request on behalf of a service account. ||
|#

## AnalyzeSpec {#yandex.cloud.ai.vision.v1.AnalyzeSpec}

#|
||Field | Description ||
|| content | **bytes**

Image content, represented as a stream of bytes.
Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64.

Includes only one of the fields `content`, `signature`. ||
|| signature | **string**

Includes only one of the fields `content`, `signature`. ||
|| features[] | **[Feature](#yandex.cloud.ai.vision.v1.Feature)**

Requested features to use for analysis.

Max count of requested features for one file is 8. ||
|| mime_type | **string**

[MIME type](https://en.wikipedia.org/wiki/Media_type) of content (for example, `` application/pdf ``). ||
|#

## Feature {#yandex.cloud.ai.vision.v1.Feature}

#|
||Field | Description ||
|| type | enum **Type**

Type of requested feature.

- `TYPE_UNSPECIFIED`
- `TEXT_DETECTION`: Text detection (OCR) feature.
- `CLASSIFICATION`: Classification feature.
- `FACE_DETECTION`: Face detection feature.
- `IMAGE_COPY_SEARCH`: Image copy search. ||
|| classification_config | **[FeatureClassificationConfig](#yandex.cloud.ai.vision.v1.FeatureClassificationConfig)**

Required for the `CLASSIFICATION` type. Specifies configuration for the classification feature.

Includes only one of the fields `classification_config`, `text_detection_config`. ||
|| text_detection_config | **[FeatureTextDetectionConfig](#yandex.cloud.ai.vision.v1.FeatureTextDetectionConfig)**

Required for the `TEXT_DETECTION` type. Specifies configuration for the text detection (OCR) feature.

Includes only one of the fields `classification_config`, `text_detection_config`. ||
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
|| language_codes[] | **string**

List of the languages to recognize text.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `ru`). ||
|| model | **string**

Model to use for text detection.
Possible values:
* `page` (default): this model is suitable for detecting multiple text entries in an image.
* `line`: this model is suitable for cropped images with one line of text. ||
|#

## BatchAnalyzeResponse {#yandex.cloud.ai.vision.v1.BatchAnalyzeResponse}

```json
{
  "results": [
    {
      "results": [
        {
          // Includes only one of the fields `text_detection`, `classification`, `face_detection`, `image_copy_search`
          "text_detection": {
            "pages": [
              {
                "width": "int64",
                "height": "int64",
                "blocks": [
                  {
                    "bounding_box": {
                      "vertices": [
                        {
                          "x": "int64",
                          "y": "int64"
                        }
                      ]
                    },
                    "lines": [
                      {
                        "bounding_box": {
                          "vertices": [
                            {
                              "x": "int64",
                              "y": "int64"
                            }
                          ]
                        },
                        "words": [
                          {
                            "bounding_box": {
                              "vertices": [
                                {
                                  "x": "int64",
                                  "y": "int64"
                                }
                              ]
                            },
                            "text": "string",
                            "confidence": "double",
                            "languages": [
                              {
                                "language_code": "string",
                                "confidence": "double"
                              }
                            ],
                            "entity_index": "int64"
                          }
                        ],
                        "confidence": "double"
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
                "probability": "double"
              }
            ]
          },
          "face_detection": {
            "faces": [
              {
                "bounding_box": {
                  "vertices": [
                    {
                      "x": "int64",
                      "y": "int64"
                    }
                  ]
                }
              }
            ]
          },
          "image_copy_search": {
            "copy_count": "int64",
            "top_results": [
              {
                "image_url": "string",
                "page_url": "string",
                "title": "string",
                "description": "string"
              }
            ]
          },
          // end of the list of possible fields
          "error": "google.rpc.Status"
        }
      ],
      "error": "google.rpc.Status"
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
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation. ||
|#

## FeatureResult {#yandex.cloud.ai.vision.v1.FeatureResult}

#|
||Field | Description ||
|| text_detection | **[TextAnnotation](#yandex.cloud.ai.vision.v1.TextAnnotation)**

Text detection (OCR) result.

Includes only one of the fields `text_detection`, `classification`, `face_detection`, `image_copy_search`. ||
|| classification | **[ClassAnnotation](#yandex.cloud.ai.vision.v1.ClassAnnotation)**

Classification result.

Includes only one of the fields `text_detection`, `classification`, `face_detection`, `image_copy_search`. ||
|| face_detection | **[FaceAnnotation](#yandex.cloud.ai.vision.v1.FaceAnnotation)**

Face detection result.

Includes only one of the fields `text_detection`, `classification`, `face_detection`, `image_copy_search`. ||
|| image_copy_search | **[ImageCopySearchAnnotation](#yandex.cloud.ai.vision.v1.ImageCopySearchAnnotation)**

Image Copy Search result.

Includes only one of the fields `text_detection`, `classification`, `face_detection`, `image_copy_search`. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| width | **int64**

Page width in pixels. ||
|| height | **int64**

Page height in pixels. ||
|| blocks[] | **[Block](#yandex.cloud.ai.vision.v1.Block)**

Recognized text blocks in this page. ||
|| entities[] | **[Entity](#yandex.cloud.ai.vision.v1.Entity)**

Recognized entities ||
|#

## Block {#yandex.cloud.ai.vision.v1.Block}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

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
|| x | **int64**

X coordinate in pixels. ||
|| y | **int64**

Y coordinate in pixels. ||
|#

## Line {#yandex.cloud.ai.vision.v1.Line}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the page where the line is located. ||
|| words[] | **[Word](#yandex.cloud.ai.vision.v1.Word)**

Recognized words in this line. ||
|| confidence | **double**

Confidence of the OCR results for the line. Range [0, 1]. ||
|#

## Word {#yandex.cloud.ai.vision.v1.Word}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the page where the word is located. ||
|| text | **string**

Recognized word value. ||
|| confidence | **double**

Confidence of the OCR results for the word. Range [0, 1]. ||
|| languages[] | **[DetectedLanguage](#yandex.cloud.ai.vision.v1.Word.DetectedLanguage)**

A list of detected languages together with confidence. ||
|| entity_index | **int64**

Id of recognized word in entities array ||
|#

## DetectedLanguage {#yandex.cloud.ai.vision.v1.Word.DetectedLanguage}

#|
||Field | Description ||
|| language_code | **string**

Detected language code. ||
|| confidence | **double**

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
|| probability | **double**

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
|| bounding_box | **[Polygon](#yandex.cloud.ai.vision.v1.Polygon)**

Area on the image where the face is located. ||
|#

## ImageCopySearchAnnotation {#yandex.cloud.ai.vision.v1.ImageCopySearchAnnotation}

#|
||Field | Description ||
|| copy_count | **int64**

Number of image copies ||
|| top_results[] | **[CopyMatch](#yandex.cloud.ai.vision.v1.CopyMatch)**

Top relevance result of image copy search ||
|#

## CopyMatch {#yandex.cloud.ai.vision.v1.CopyMatch}

#|
||Field | Description ||
|| image_url | **string**

url of image ||
|| page_url | **string**

url of page that contains image ||
|| title | **string**

page title that contains image ||
|| description | **string**

image description ||
|#