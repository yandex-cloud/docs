---
editable: false
sourcePath: en/_api-ref-grpc/ai/ocr/v1/ocr/api-ref/grpc/TextRecognitionAsync/getRecognition.md
---

# Vision OCR API, gRPC: TextRecognitionAsyncService.GetRecognition {#GetRecognition}

To get recognition results.

## gRPC request

**rpc GetRecognition ([GetRecognitionRequest](#yandex.cloud.ai.ocr.v1.GetRecognitionRequest)) returns (stream [RecognizeTextResponse](#yandex.cloud.ai.ocr.v1.RecognizeTextResponse))**

## GetRecognitionRequest {#yandex.cloud.ai.ocr.v1.GetRecognitionRequest}

```json
{
  "operationId": "string"
}
```

#|
||Field | Description ||
|| operationId | **string**

Required field. Operation ID of async recognition request. ||
|#

## RecognizeTextResponse {#yandex.cloud.ai.ocr.v1.RecognizeTextResponse}

```json
{
  "textAnnotation": {
    "width": "int64",
    "height": "int64",
    "blocks": [
      {
        "boundingBox": {
          "vertices": [
            {
              "x": "int64",
              "y": "int64"
            }
          ]
        },
        "lines": [
          {
            "boundingBox": {
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
                "boundingBox": {
                  "vertices": [
                    {
                      "x": "int64",
                      "y": "int64"
                    }
                  ]
                },
                "text": "string",
                "entityIndex": "int64",
                "textSegments": [
                  {
                    "startIndex": "int64",
                    "length": "int64"
                  }
                ]
              }
            ],
            "textSegments": [
              {
                "startIndex": "int64",
                "length": "int64"
              }
            ],
            "orientation": "Angle"
          }
        ],
        "languages": [
          {
            "languageCode": "string"
          }
        ],
        "textSegments": [
          {
            "startIndex": "int64",
            "length": "int64"
          }
        ]
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
        "boundingBox": {
          "vertices": [
            {
              "x": "int64",
              "y": "int64"
            }
          ]
        },
        "rowCount": "int64",
        "columnCount": "int64",
        "cells": [
          {
            "boundingBox": {
              "vertices": [
                {
                  "x": "int64",
                  "y": "int64"
                }
              ]
            },
            "rowIndex": "int64",
            "columnIndex": "int64",
            "columnSpan": "int64",
            "rowSpan": "int64",
            "text": "string",
            "textSegments": [
              {
                "startIndex": "int64",
                "length": "int64"
              }
            ]
          }
        ]
      }
    ],
    "fullText": "string",
    "rotate": "Angle"
  },
  "page": "int64"
}
```

#|
||Field | Description ||
|| textAnnotation | **[TextAnnotation](#yandex.cloud.ai.ocr.v1.TextAnnotation)**

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
|| fullText | **string**

Full text recognized from image. ||
|| rotate | enum **Angle**

Angle of image rotation.

- `ANGLE_UNSPECIFIED`
- `ANGLE_0`
- `ANGLE_90`
- `ANGLE_180`
- `ANGLE_270` ||
|#

## Block {#yandex.cloud.ai.ocr.v1.Block}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the text block is located. ||
|| lines[] | **[Line](#yandex.cloud.ai.ocr.v1.Line)**

Recognized lines in this block. ||
|| languages[] | **[DetectedLanguage](#yandex.cloud.ai.ocr.v1.Block.DetectedLanguage)**

A list of detected languages ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Block position from full_text string. ||
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
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the line is located. ||
|| text | **string**

Recognized text. ||
|| words[] | **[Word](#yandex.cloud.ai.ocr.v1.Word)**

Recognized words. ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

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
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the word is located. ||
|| text | **string**

Recognized word value. ||
|| entityIndex | **int64**

ID of the recognized word in entities array. ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Word position from full_text string. ||
|#

## TextSegments {#yandex.cloud.ai.ocr.v1.TextSegments}

#|
||Field | Description ||
|| startIndex | **int64**

Start character position from full_text string. ||
|| length | **int64**

Text segment length. ||
|#

## DetectedLanguage {#yandex.cloud.ai.ocr.v1.Block.DetectedLanguage}

#|
||Field | Description ||
|| languageCode | **string**

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
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the table is located. ||
|| rowCount | **int64**

Number of rows in table. ||
|| columnCount | **int64**

Number of columns in table. ||
|| cells[] | **[TableCell](#yandex.cloud.ai.ocr.v1.TableCell)**

Table cells. ||
|#

## TableCell {#yandex.cloud.ai.ocr.v1.TableCell}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the table cell is located. ||
|| rowIndex | **int64**

Row index. ||
|| columnIndex | **int64**

Column index. ||
|| columnSpan | **int64**

Column span. ||
|| rowSpan | **int64**

Row span. ||
|| text | **string**

Text in cell. ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Table cell position from full_text string. ||
|#