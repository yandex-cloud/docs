---
editable: false
sourcePath: en/_api-ref/ai/vision_old/api-ref/Vision/batchAnalyze.md
---


# Method batchAnalyze
Analyzes a batch of images and returns results with annotations.
 

 
## HTTP request {#https-request}
```
POST https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze
```
 
## Body parameters {#body_params}
 
```json 
 {
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "string",
          "textDetectionConfig": {
            "languageCodes": [
              "string"
            ]
          }
        }
      ],
      "content": "string"
    }
  ],
  "folderId": "string"
}
```

 
Field | Description
--- | ---
analyzeSpecs[] | **object**<br><p>Required. A list of specifications. Each specification contains the file to analyze and features to use for analysis.</p> <p>Restrictions:</p> <ul> <li>Supported file formats: JPEG, PNG.</li> <li>Maximum file size: 1 MB.</li> <li>Image size should not exceed 20M pixels (length x width).</li> </ul> <p>The number of elements must be in the range 1-8.</p> 
analyzeSpecs[].<br>features[] | **object**<br><p>Required. Requested features to use for analysis. Currently only text detection (OCR) is supported.</p> <p>Max count of requested features for one file is 8.</p> <p>The number of elements must be in the range 1-8.</p> 
analyzeSpecs[].<br>features[].<br>type | **string**<br><ul> <li>TEXT_DETECTION: Text detection (OCR) feature.</li> </ul> 
analyzeSpecs[].<br>features[].<br>textDetectionConfig | **object**<br>
analyzeSpecs[].<br>features[].<br>textDetectionConfig.<br>languageCodes[] | **string**<br><p>Required. List of the languages to recognize text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, <code>ru</code>).</p> <p>The number of elements must be in the range 1-8. The maximum string length in characters for each value is 3.</p> 
analyzeSpecs[].<br>content | **string** (byte)<br><p>Image content, represented as a stream of bytes. Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64.</p> <p>The maximum string length in characters is 1048576.</p> 
folderId | **string**<br><p>ID of the folder to which you have access. Required for authorization with a user account (see <a href="/docs/iam/api-ref/UserAccount#representation">UserAccount</a> resource). Don't specify this field if you make the request on behalf of a service account.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
 {
  "results": [
    {
      "results": [
        {
          "error": {
            "code": "integer",
            "message": "string",
            "details": [
              "object"
            ]
          },
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
                            "confidence": "number",
                            "languages": [
                              {
                                "languageCode": "string",
                                "confidence": "number"
                              }
                            ]
                          }
                        ],
                        "confidence": "number"
                      }
                    ]
                  }
                ]
              }
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

 
Field | Description
--- | ---
results[] | **object**<br><p>Request results. Results have the same order as specifications in the request.</p> 
results[].<br>results[] | **object**<br><p>Results for each requested feature. Feature results have the same order as in the request.</p> 
results[].<br>results[].<br>error | **object**<br><p>The error result of the operation in case of failure or cancellation.</p> 
results[].<br>results[].<br>error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>results[].<br>error.<br>message | **string**<br><p>An error message.</p> 
results[].<br>results[].<br>error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
results[].<br>results[].<br>textDetection | **object**<br>
results[].<br>results[].<br>textDetection.<br>pages[] | **object**<br><p>Pages of the recognized file.</p> <p>For JPEG and PNG files contains only 1 page.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>width | **string** (int64)<br><p>Page width in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>height | **string** (int64)<br><p>Page height in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[] | **object**<br><p>Recognized text blocks in this page.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox | **object**<br><p>Area on the page where the text block is located.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[] | **object**<br><p>Recognized lines in this block.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox | **object**<br><p>Area on the page where the line is located.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[] | **object**<br><p>Recognized words in this line.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox | **object**<br><p>Area on the page where the word is located.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>text | **string**<br><p>Recognized word value.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>confidence | **number** (double)<br><p>Confidence of the OCR results for the word. Range [0, 1].</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[] | **object**<br><p>A list of detected languages together with confidence.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[].<br>languageCode | **string**<br><p>Detected language code.</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>languages[].<br>confidence | **number** (double)<br><p>Confidence of detected language. Range [0, 1].</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>confidence | **number** (double)<br><p>Confidence of the OCR results for the line. Range [0, 1].</p> 
results[].<br>error | **object**<br><p>Return error in case of error with file processing.</p> <p>The error result of the operation in case of failure or cancellation.</p> 
results[].<br>error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>error.<br>message | **string**<br><p>An error message.</p> 
results[].<br>error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 