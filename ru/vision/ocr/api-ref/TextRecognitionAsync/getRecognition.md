---
editable: false
sourcePath: en/_api-ref/ai/ocr/v1/ocr/api-ref/TextRecognitionAsync/getRecognition.md
---

# Vision OCR API, REST: TextRecognitionAsync.getRecognition
To get recognition results.
 

 
## HTTP request {#https-request}
```
GET https://ocr.{{ api-host }}/ocr/v1/getRecognition
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
operationId | <p>Required. Operation ID of async recognition request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
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
            ]
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
    "fullText": "string"
  },
  "page": "string"
}
```

 
Field | Description
--- | ---
textAnnotation | **object**<br><p>Recognized text blocks in this page or text from entities.</p> 
textAnnotation.<br>width | **string** (int64)<br><p>Page width in pixels.</p> 
textAnnotation.<br>height | **string** (int64)<br><p>Page height in pixels.</p> 
textAnnotation.<br>blocks[] | **object**<br><p>Recognized text blocks in this page.</p> 
textAnnotation.<br>blocks[].<br>boundingBox | **object**<br><p>Area on the page where the text block is located.</p> 
textAnnotation.<br>blocks[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
textAnnotation.<br>blocks[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>lines[] | **object**<br><p>Recognized lines in this block.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>boundingBox | **object**<br><p>Area on the page where the line is located.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>text | **string**<br><p>Recognized text.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[] | **object**<br><p>Recognized words.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>boundingBox | **object**<br><p>Area on the page where the word is located.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>text | **string**<br><p>Recognized word value.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>entityIndex | **string** (int64)<br><p>ID of the recognized word in entities array.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>textSegments[] | **object**<br><p>Word position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>textSegments[].<br>startIndex | **string** (int64)<br><p>Start character position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>words[].<br>textSegments[].<br>length | **string** (int64)<br><p>Text segment length.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>textSegments[] | **object**<br><p>Line position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>textSegments[].<br>startIndex | **string** (int64)<br><p>Start character position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>lines[].<br>textSegments[].<br>length | **string** (int64)<br><p>Text segment length.</p> 
textAnnotation.<br>blocks[].<br>languages[] | **object**<br><p>A list of detected languages</p> 
textAnnotation.<br>blocks[].<br>languages[].<br>languageCode | **string**<br><p>Detected language code.</p> 
textAnnotation.<br>blocks[].<br>textSegments[] | **object**<br><p>Block position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>textSegments[].<br>startIndex | **string** (int64)<br><p>Start character position from full_text string.</p> 
textAnnotation.<br>blocks[].<br>textSegments[].<br>length | **string** (int64)<br><p>Text segment length.</p> 
textAnnotation.<br>entities[] | **object**<br><p>Recognized entities.</p> 
textAnnotation.<br>entities[].<br>name | **string**<br><p>Entity name.</p> 
textAnnotation.<br>entities[].<br>text | **string**<br><p>Recognized entity text.</p> 
textAnnotation.<br>tables[] | **object**
textAnnotation.<br>tables[].<br>boundingBox | **object**<br><p>Area on the page where the table is located.</p> 
textAnnotation.<br>tables[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
textAnnotation.<br>tables[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
textAnnotation.<br>tables[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
textAnnotation.<br>tables[].<br>rowCount | **string** (int64)<br><p>Number of rows in table.</p> 
textAnnotation.<br>tables[].<br>columnCount | **string** (int64)<br><p>Number of columns in table.</p> 
textAnnotation.<br>tables[].<br>cells[] | **object**<br><p>Table cells.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>boundingBox | **object**<br><p>Area on the page where the table cell is located.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>rowIndex | **string** (int64)<br><p>Row index.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>columnIndex | **string** (int64)<br><p>Column index.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>columnSpan | **string** (int64)<br><p>Column span.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>rowSpan | **string** (int64)<br><p>Row span.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>text | **string**<br><p>Text in cell.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>textSegments[] | **object**<br><p>Table cell position from full_text string.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>textSegments[].<br>startIndex | **string** (int64)<br><p>Start character position from full_text string.</p> 
textAnnotation.<br>tables[].<br>cells[].<br>textSegments[].<br>length | **string** (int64)<br><p>Text segment length.</p> 
textAnnotation.<br>fullText | **string**<br><p>Full text recognized from image.</p> 
page | **string** (int64)<br><p>Page number in PDF file.</p> 