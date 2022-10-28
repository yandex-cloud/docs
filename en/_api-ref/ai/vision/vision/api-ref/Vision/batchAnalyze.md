---
editable: false
---

# Method batchAnalyze
Analyzes a batch of images and returns results with annotations.
 

 
## HTTP request {#https-request}
```
POST https://vision.{{ api-host }}/vision/v1/batchAnalyze
```
 
## Body parameters {#body_params}
 
```json 
{
  "analyzeSpecs": [
    {
      "features": [
        {
          "type": "string",

          // `analyzeSpecs[].features[]` includes only one of the fields `classificationConfig`, `textDetectionConfig`
          "classificationConfig": {
            "model": "string"
          },
          "textDetectionConfig": {
            "languageCodes": [
              "string"
            ],
            "model": "string"
          },
          // end of the list of possible fields`analyzeSpecs[].features[]`

        }
      ],
      "mimeType": "string",

      // `analyzeSpecs[]` includes only one of the fields `content`, `signature`
      "content": "string",
      "signature": "string",
      // end of the list of possible fields`analyzeSpecs[]`

    }
  ],
  "folderId": "string"
}
```

 
Field | Description
--- | ---
analyzeSpecs[] | **object**<br><p>Required. A list of specifications. Each specification contains the file to analyze and features to use for analysis.</p> <p>Restrictions:</p> <ul> <li>Supported file formats: JPEG, PNG.</li> <li>Maximum file size: 1 MB.</li> <li>Image size should not exceed 20M pixels (length x width).</li> </ul> <p>The number of elements must be in the range 1-8.</p> 
analyzeSpecs[].<br>features[] | **object**<br><p>Required. Requested features to use for analysis.</p> <p>Max count of requested features for one file is 8.</p> <p>The number of elements must be in the range 1-8.</p> 
analyzeSpecs[].<br>features[].<br>type | **string**<br>Type of requested feature.<br><ul> <li>TEXT_DETECTION: Text detection (OCR) feature.</li> <li>CLASSIFICATION: Classification feature.</li> <li>FACE_DETECTION: Face detection feature.</li> <li>IMAGE_COPY_SEARCH: Image copy search.</li> </ul> 
analyzeSpecs[].<br>features[].<br>classificationConfig | **object**<br>Required for the `CLASSIFICATION` type. Specifies configuration for the classification feature. <br>`analyzeSpecs[].features[]` includes only one of the fields `classificationConfig`, `textDetectionConfig`<br>
analyzeSpecs[].<br>features[].<br>classificationConfig.<br>model | **string**<br><p>Model to use for image classification.</p> <p>The maximum string length in characters is 256.</p> 
analyzeSpecs[].<br>features[].<br>textDetectionConfig | **object**<br>Required for the `TEXT_DETECTION` type. Specifies configuration for the text detection (OCR) feature. <br>`analyzeSpecs[].features[]` includes only one of the fields `classificationConfig`, `textDetectionConfig`<br>
analyzeSpecs[].<br>features[].<br>textDetectionConfig.<br>languageCodes[] | **string**<br><p>Required. List of the languages to recognize text. Specified in <a href="https://en.wikipedia.org/wiki/ISO_639-1">ISO 639-1</a> format (for example, ``ru``).</p> <p>The number of elements must be in the range 1-8. The maximum string length in characters for each value is 3.</p> 
analyzeSpecs[].<br>features[].<br>textDetectionConfig.<br>model | **string**<br><p>Model to use for text detection. Possible values:</p> <ul> <li>page (default) - this model is suitable for detecting multiple text entries in an image.</li> <li>line - this model is suitable for cropped images with one line of text.</li> </ul> <p>The maximum string length in characters is 50.</p> 
analyzeSpecs[].<br>mimeType | **string**<br><p><a href="https://en.wikipedia.org/wiki/Media_type">MIME type</a> of content (for example, ``application/pdf``).</p> <p>The maximum string length in characters is 255.</p> 
analyzeSpecs[].<br>content | **string** (byte) <br>`analyzeSpecs[]` includes only one of the fields `content`, `signature`<br><br><p>Image content, represented as a stream of bytes. Note: As with all bytes fields, protobuffers use a pure binary representation, whereas JSON representations use base64.</p> <p>The maximum string length in characters is 10485760.</p> 
analyzeSpecs[].<br>signature | **string** <br>`analyzeSpecs[]` includes only one of the fields `content`, `signature`<br><br><p>The maximum string length in characters is 16384.</p> 
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

          // `results[].results[]` includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`
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
                            ],
                            "entityIndex": "string"
                          }
                        ],
                        "confidence": "number"
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
                "probability": "number"
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
          // end of the list of possible fields`results[].results[]`

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
results[].<br>results[].<br>error | **object**<br>Return error in case of error during the specified feature processing.
results[].<br>results[].<br>error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>results[].<br>error.<br>message | **string**<br><p>An error message.</p> 
results[].<br>results[].<br>error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
results[].<br>results[].<br>textDetection | **object**<br>Text detection (OCR) result. <br>`results[].results[]` includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`<br>
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
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>words[].<br>entityIndex | **string** (int64)<br><p>Id of recognized word in entities array</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>blocks[].<br>lines[].<br>confidence | **number** (double)<br><p>Confidence of the OCR results for the line. Range [0, 1].</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>entities[] | **object**<br><p>Recognized entities</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>entities[].<br>name | **string**<br><p>Entity name</p> 
results[].<br>results[].<br>textDetection.<br>pages[].<br>entities[].<br>text | **string**<br><p>Recognized entity text</p> 
results[].<br>results[].<br>classification | **object**<br>Classification result. <br>`results[].results[]` includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`<br>
results[].<br>results[].<br>classification.<br>properties[] | **object**<br><p>Properties extracted by a specified model.</p> <p>For example, if you ask to evaluate the image quality, the service could return such properties as ``good`` and ``bad``.</p> 
results[].<br>results[].<br>classification.<br>properties[].<br>name | **string**<br><p>Property name.</p> 
results[].<br>results[].<br>classification.<br>properties[].<br>probability | **number** (double)<br><p>Probability of the property, from 0 to 1.</p> 
results[].<br>results[].<br>faceDetection | **object**<br>Face detection result. <br>`results[].results[]` includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`<br>
results[].<br>results[].<br>faceDetection.<br>faces[] | **object**<br><p>An array of detected faces for the specified image.</p> 
results[].<br>results[].<br>faceDetection.<br>faces[].<br>boundingBox | **object**<br><p>Area on the image where the face is located.</p> 
results[].<br>results[].<br>faceDetection.<br>faces[].<br>boundingBox.<br>vertices[] | **object**<br><p>The bounding polygon vertices.</p> 
results[].<br>results[].<br>faceDetection.<br>faces[].<br>boundingBox.<br>vertices[].<br>x | **string** (int64)<br><p>X coordinate in pixels.</p> 
results[].<br>results[].<br>faceDetection.<br>faces[].<br>boundingBox.<br>vertices[].<br>y | **string** (int64)<br><p>Y coordinate in pixels.</p> 
results[].<br>results[].<br>imageCopySearch | **object**<br>Image Copy Search result. <br>`results[].results[]` includes only one of the fields `textDetection`, `classification`, `faceDetection`, `imageCopySearch`<br>
results[].<br>results[].<br>imageCopySearch.<br>copyCount | **string** (int64)<br><p>Number of image copies</p> 
results[].<br>results[].<br>imageCopySearch.<br>topResults[] | **object**<br><p>Top relevance result of image copy search</p> 
results[].<br>results[].<br>imageCopySearch.<br>topResults[].<br>imageUrl | **string**<br><p>url of image</p> 
results[].<br>results[].<br>imageCopySearch.<br>topResults[].<br>pageUrl | **string**<br><p>url of page that contains image</p> 
results[].<br>results[].<br>imageCopySearch.<br>topResults[].<br>title | **string**<br><p>page title that contains image</p> 
results[].<br>results[].<br>imageCopySearch.<br>topResults[].<br>description | **string**<br><p>image description</p> 
results[].<br>error | **object**<br><p>Return error in case of error with file processing.</p> <p>The error result of the operation in case of failure or cancellation.</p> 
results[].<br>error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
results[].<br>error.<br>message | **string**<br><p>An error message.</p> 
results[].<br>error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 