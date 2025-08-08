---
editable: false
apiPlayground:
  - url: https://ocr.{{ api-host }}/ocr/v1/getRecognition
    method: get
    path: null
    query:
      type: object
      properties:
        operationId:
          description: |-
            **string**
            Required field. Operation ID of async recognition request.
          type: string
      required:
        - operationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ai/ocr/v1/ocr/api-ref/TextRecognitionAsync/getRecognition.md
---

# Vision OCR API, REST: TextRecognitionAsync.GetRecognition

To get recognition results.

## HTTP request

```
GET https://ocr.{{ api-host }}/ocr/v1/getRecognition
```

## Query parameters {#yandex.cloud.ai.ocr.v1.GetRecognitionRequest}

#|
||Field | Description ||
|| operationId | **string**

Required field. Operation ID of async recognition request. ||
|#

## Response {#yandex.cloud.ai.ocr.v1.RecognizeTextResponse}

**HTTP Code: 200 - OK**

```json
{
  "textAnnotation": {
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
            "text": "string",
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
                "entityIndex": "string",
                "textSegments": [
                  {
                    "startIndex": "string",
                    "length": "string"
                  }
                ]
              }
            ],
            "textSegments": [
              {
                "startIndex": "string",
                "length": "string"
              }
            ],
            "orientation": "string"
          }
        ],
        "languages": [
          {
            "languageCode": "string"
          }
        ],
        "textSegments": [
          {
            "startIndex": "string",
            "length": "string"
          }
        ],
        "layoutType": "string"
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
              "x": "string",
              "y": "string"
            }
          ]
        },
        "rowCount": "string",
        "columnCount": "string",
        "cells": [
          {
            "boundingBox": {
              "vertices": [
                {
                  "x": "string",
                  "y": "string"
                }
              ]
            },
            "rowIndex": "string",
            "columnIndex": "string",
            "columnSpan": "string",
            "rowSpan": "string",
            "text": "string",
            "textSegments": [
              {
                "startIndex": "string",
                "length": "string"
              }
            ]
          }
        ]
      }
    ],
    "fullText": "string",
    "rotate": "string",
    "markdown": "string",
    "pictures": [
      {
        "boundingBox": {
          "vertices": [
            {
              "x": "string",
              "y": "string"
            }
          ]
        },
        "score": "string"
      }
    ]
  },
  "page": "string"
}
```

#|
||Field | Description ||
|| textAnnotation | **[TextAnnotation](#yandex.cloud.ai.ocr.v1.TextAnnotation)**

Recognized text blocks in page or text from entities. ||
|| page | **string** (int64)

Page number in PDF file. ||
|#

## TextAnnotation {#yandex.cloud.ai.ocr.v1.TextAnnotation}

#|
||Field | Description ||
|| width | **string** (int64)

Page width in pixels. ||
|| height | **string** (int64)

Page height in pixels. ||
|| blocks[] | **[Block](#yandex.cloud.ai.ocr.v1.Block)**

Recognized text blocks in this page. ||
|| entities[] | **[Entity](#yandex.cloud.ai.ocr.v1.Entity)**

Recognized entities. ||
|| tables[] | **[Table](#yandex.cloud.ai.ocr.v1.Table)** ||
|| fullText | **string**

Full text recognized from image. ||
|| rotate | **enum** (Angle)

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
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the text block is located. ||
|| lines[] | **[Line](#yandex.cloud.ai.ocr.v1.Line)**

Recognized lines in this block. ||
|| languages[] | **[DetectedLanguage](#yandex.cloud.ai.ocr.v1.Block.DetectedLanguage)**

A list of detected languages ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Block position from full_text string. ||
|| layoutType | **enum** (LayoutType)

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
|| x | **string** (int64)

X coordinate in pixels. ||
|| y | **string** (int64)

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
|| orientation | **enum** (Angle)

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
|| entityIndex | **string** (int64)

ID of the recognized word in entities array. ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Word position from full_text string. ||
|#

## TextSegments {#yandex.cloud.ai.ocr.v1.TextSegments}

#|
||Field | Description ||
|| startIndex | **string** (int64)

Start character position from full_text string. ||
|| length | **string** (int64)

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
|| rowCount | **string** (int64)

Number of rows in table. ||
|| columnCount | **string** (int64)

Number of columns in table. ||
|| cells[] | **[TableCell](#yandex.cloud.ai.ocr.v1.TableCell)**

Table cells. ||
|#

## TableCell {#yandex.cloud.ai.ocr.v1.TableCell}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the table cell is located. ||
|| rowIndex | **string** (int64)

Row index. ||
|| columnIndex | **string** (int64)

Column index. ||
|| columnSpan | **string** (int64)

Column span. ||
|| rowSpan | **string** (int64)

Row span. ||
|| text | **string**

Text in cell. ||
|| textSegments[] | **[TextSegments](#yandex.cloud.ai.ocr.v1.TextSegments)**

Table cell position from full_text string. ||
|#

## Picture {#yandex.cloud.ai.ocr.v1.Picture}

#|
||Field | Description ||
|| boundingBox | **[Polygon](#yandex.cloud.ai.ocr.v1.Polygon)**

Area on the page where the picture is located. ||
|| score | **string**

Confidence score of picture location. ||
|#