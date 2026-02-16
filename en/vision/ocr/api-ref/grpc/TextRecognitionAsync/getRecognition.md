---
editable: false
sourcePath: en/_api-ref-grpc/ai/ocr/v1/ocr/api-ref/grpc/TextRecognitionAsync/getRecognition.md
---

# Vision OCR API, gRPC: TextRecognitionAsyncService.GetRecognition

To get recognition results.

## gRPC request

**rpc GetRecognition ([GetRecognitionRequest](#yandex.cloud.ai.ocr.v1.GetRecognitionRequest)) returns (stream [RecognizeTextResponse](#yandex.cloud.ai.ocr.v1.RecognizeTextResponse))**

## GetRecognitionRequest {#yandex.cloud.ai.ocr.v1.GetRecognitionRequest}

```json
{
  "operation_id": "string"
}
```

#|
||Field | Description ||
|| operation_id | **string**

Required field. Operation ID of async recognition request. ||
|#

## RecognizeTextResponse {#yandex.cloud.ai.ocr.v1.RecognizeTextResponse}

```json
{
  "text_annotation": {
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
            "text": "string",
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
                "entity_index": "int64",
                "text_segments": [
                  {
                    "start_index": "int64",
                    "length": "int64"
                  }
                ]
              }
            ],
            "text_segments": [
              {
                "start_index": "int64",
                "length": "int64"
              }
            ],
            "orientation": "Angle"
          }
        ],
        "languages": [
          {
            "language_code": "string"
          }
        ],
        "text_segments": [
          {
            "start_index": "int64",
            "length": "int64"
          }
        ],
        "layout_type": "LayoutType"
      }
    ],
    "entities": [
      {
        "name": "string",
        "text": "string"
      }
    ],
    "tables": [
      {
        "bounding_box": {
          "vertices": [
            {
              "x": "int64",
              "y": "int64"
            }
          ]
        },
        "row_count": "int64",
        "column_count": "int64",
        "cells": [
          {
            "bounding_box": {
              "vertices": [
                {
                  "x": "int64",
                  "y": "int64"
                }
              ]
            },
            "row_index": "int64",
            "column_index": "int64",
            "column_span": "int64",
            "row_span": "int64",
            "text": "string",
            "text_segments": [
              {
                "start_index": "int64",
                "length": "int64"
              }
            ]
          }
        ]
      }
    ],
    "full_text": "string",
    "rotate": "Angle",
    "markdown": "string",
    "pictures": [
      {
        "bounding_box": {
          "vertices": [
            {
              "x": "int64",
              "y": "int64"
            }
          ]
        },
        "score": "double"
      }
    ]
  },
  "page": "int64"
}
```

#|
||Field | Description ||
|| text_annotation | **[TextAnnotation](#yandex.cloud.ai.ocr.v1.TextAnnotation)**

Recognized text blocks in page or text from entities. ||
|| page | **int64**

Page number in PDF file. ||
|#

## TextAnnotation {#yandex.cloud.ai.ocr.v1.TextAnnotation}

#|
||Field | Description ||
|| width | **int64**

Page width in pixels. ||
|| height | **int64**

Page height in pixels. ||
|| blocks[] | **[Block](#yandex.cloud.ai.ocr.v1.Block)**

Recognized text blocks in this page. ||
|| entities[] | **[Entity](#yandex.cloud.ai.ocr.v1.Entity)**

Recognized entities. ||
|| tables[] | **[Table](#yandex.cloud.ai.ocr.v1.Table)** ||
|| full_text | **string**

Full text recognized from image. ||
|| rotate | enum **Angle**

Angle of image rotation.

- `ANGLE_UNSPECIFIED`
- `ANGLE_0`
- `ANGLE_90`
- `ANGLE_180`
- `ANGLE_270` ||
|| markdown | **string**

Full markdown (without pictures inside) from image. Available only in markdown and math-markdown models. ||
|| pictures[] | **[Picture](#yandex.cloud.ai.ocr.v1.Picture)**

List of pictures locations from image. ||
|#

## Block {#yandex.cloud.ai.ocr.v1.Block}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the text block is located. ||
|| lines[] | **[Line](#yandex.cloud.ai.ocr.v1.Line)**

Recognized lines in this block. ||
|| languages[] | **[DetectedLanguage](#yandex.cloud.ai.ocr.v1.Block.DetectedLanguage)**

A list of detected languages ||
|| text_segments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Block position from full_text string. ||
|| layout_type | enum **LayoutType**

Block layout type.

- `LAYOUT_TYPE_UNSPECIFIED`
- `LAYOUT_TYPE_UNKNOWN`
- `LAYOUT_TYPE_TEXT`
- `LAYOUT_TYPE_HEADER`
- `LAYOUT_TYPE_SECTION_HEADER`
- `LAYOUT_TYPE_FOOTER`
- `LAYOUT_TYPE_FOOTNOTE`
- `LAYOUT_TYPE_PICTURE`
- `LAYOUT_TYPE_CAPTION`
- `LAYOUT_TYPE_TITLE`
- `LAYOUT_TYPE_LIST` ||
|#

## Polygon {#yandex.cloud.ai.ocr.v1.Polygon}

#|
||Field | Description ||
|| vertices[] | **[Vertex](#yandex.cloud.ai.ocr.v1.Vertex)**

The bounding polygon vertices. ||
|#

## Vertex {#yandex.cloud.ai.ocr.v1.Vertex}

#|
||Field | Description ||
|| x | **int64**

X coordinate in pixels. ||
|| y | **int64**

Y coordinate in pixels. ||
|#

## Line {#yandex.cloud.ai.ocr.v1.Line}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the line is located. ||
|| text | **string**

Recognized text. ||
|| words[] | **[Word](#yandex.cloud.ai.ocr.v1.Word)**

Recognized words. ||
|| text_segments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Line position from full_text string. ||
|| orientation | enum **Angle**

Angle of line rotation.

- `ANGLE_UNSPECIFIED`
- `ANGLE_0`
- `ANGLE_90`
- `ANGLE_180`
- `ANGLE_270` ||
|#

## Word {#yandex.cloud.ai.ocr.v1.Word}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the word is located. ||
|| text | **string**

Recognized word value. ||
|| entity_index | **int64**

ID of the recognized word in entities array. ||
|| text_segments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Word position from full_text string. ||
|#

## TextSegments {#yandex.cloud.ai.ocr.v1.TextSegments}

#|
||Field | Description ||
|| start_index | **int64**

Start character position from full_text string. ||
|| length | **int64**

Text segment length. ||
|#

## DetectedLanguage {#yandex.cloud.ai.ocr.v1.Block.DetectedLanguage}

#|
||Field | Description ||
|| language_code | **string**

Detected language code. ||
|#

## Entity {#yandex.cloud.ai.ocr.v1.Entity}

#|
||Field | Description ||
|| name | **string**

Entity name. ||
|| text | **string**

Recognized entity text. ||
|#

## Table {#yandex.cloud.ai.ocr.v1.Table}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the table is located. ||
|| row_count | **int64**

Number of rows in table. ||
|| column_count | **int64**

Number of columns in table. ||
|| cells[] | **[TableCell](#yandex.cloud.ai.ocr.v1.TableCell)**

Table cells. ||
|#

## TableCell {#yandex.cloud.ai.ocr.v1.TableCell}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the table cell is located. ||
|| row_index | **int64**

Row index. ||
|| column_index | **int64**

Column index. ||
|| column_span | **int64**

Column span. ||
|| row_span | **int64**

Row span. ||
|| text | **string**

Text in cell. ||
|| text_segments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Table cell position from full_text string. ||
|#

## Picture {#yandex.cloud.ai.ocr.v1.Picture}

#|
||Field | Description ||
|| bounding_box | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the picture is located. ||
|| score | **double**

Confidence score of picture location. ||
|#