---
title: How to recognize a table in {{ vision-full-name }}. Step-by-step guide
description: In this guide, you will learn how to recognize text in Russian and English tables with {{ vision-full-name }}.
---

# Table recognition

You can [recognize text](../../concepts/ocr/index.md) in a table using the [OCR API](../../ocr/api-ref/index.md) with the `table` recognition model. With this model, you can recognize tables in Russian, English, and Turkish.

## Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Recognizing a table {#recognize-table-text}

Image text recognition is implemented in the [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API method.

1. Prepare an image file that meets the requirements:

   {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

1. Encode the image file as Base64:

   {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`.

   **body.json:**
   ```json
   {
     "mimeType": "JPEG",
     "languageCodes": ["ru","en"],
     "model": "table",
     "content": "<base64-encoded_image>"
   }
   ```

   In the `content` property, specify the image file contents [encoded](../base64-encode.md) as Base64.

1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

   The result will consist of recognized blocks of text, lines, and words with their position on the image.

   {% cut "Result:" %}

   ```json
   {
     "result": {
       "textAnnotation": {
         "width": "724",
         "height": "131",
         "blocks": [
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "68",
                   "y": "42"
                 },
                 {
                   "x": "68",
                   "y": "60"
                 },
                 {
                   "x": "194",
                   "y": "60"
                 },
                 {
                   "x": "194",
                   "y": "42"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "68",
                       "y": "42"
                     },
                     {
                       "x": "68",
                       "y": "60"
                     },
                     {
                       "x": "194",
                       "y": "60"
                     },
                     {
                       "x": "194",
                       "y": "42"
                     }
                   ]
                 },
                 "text": "Фамилия",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "68",
                           "y": "40"
                         },
                         {
                           "x": "68",
                           "y": "63"
                         },
                         {
                           "x": "194",
                           "y": "63"
                         },
                         {
                           "x": "194",
                           "y": "40"
                         }
                       ]
                     },
                     "text": "Фамилия",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "0",
                         "length": "7"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "0",
                     "length": "7"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "0",
                 "length": "7"
               }
             ]
           },
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "307",
                   "y": "40"
                 },
                 {
                   "x": "307",
                   "y": "61"
                 },
                 {
                   "x": "372",
                   "y": "61"
                 },
                 {
                   "x": "372",
                   "y": "40"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "307",
                       "y": "40"
                     },
                     {
                       "x": "307",
                       "y": "61"
                     },
                     {
                       "x": "372",
                       "y": "61"
                     },
                     {
                       "x": "372",
                       "y": "40"
                     }
                   ]
                 },
                 "text": "Имя",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "307",
                           "y": "39"
                         },
                         {
                           "x": "307",
                           "y": "63"
                         },
                         {
                           "x": "372",
                           "y": "63"
                         },
                         {
                           "x": "372",
                           "y": "39"
                         }
                       ]
                     },
                     "text": "Имя",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "8",
                         "length": "3"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "8",
                     "length": "3"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "8",
                 "length": "3"
               }
             ]
           },
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "506",
                   "y": "43"
                 },
                 {
                   "x": "506",
                   "y": "59"
                 },
                 {
                   "x": "632",
                   "y": "59"
                 },
                 {
                   "x": "632",
                   "y": "43"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "506",
                       "y": "43"
                     },
                     {
                       "x": "506",
                       "y": "59"
                     },
                     {
                       "x": "632",
                       "y": "59"
                     },
                     {
                       "x": "632",
                       "y": "43"
                     }
                   ]
                 },
                 "text": "Отчество",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "506",
                           "y": "40"
                         },
                         {
                           "x": "506",
                           "y": "63"
                         },
                         {
                           "x": "632",
                           "y": "63"
                         },
                         {
                           "x": "632",
                           "y": "40"
                         }
                       ]
                     },
                     "text": "Отчество",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "12",
                         "length": "8"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "12",
                     "length": "8"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "12",
                 "length": "8"
               }
             ]
           },
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "80",
                   "y": "81"
                 },
                 {
                   "x": "80",
                   "y": "98"
                 },
                 {
                   "x": "179",
                   "y": "98"
                 },
                 {
                   "x": "179",
                   "y": "81"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "80",
                       "y": "81"
                     },
                     {
                       "x": "80",
                       "y": "98"
                     },
                     {
                       "x": "179",
                       "y": "98"
                     },
                     {
                       "x": "179",
                       "y": "81"
                     }
                   ]
                 },
                 "text": "Иванов",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "80",
                           "y": "79"
                         },
                         {
                           "x": "80",
                           "y": "101"
                         },
                         {
                           "x": "179",
                           "y": "101"
                         },
                         {
                           "x": "179",
                           "y": "79"
                         }
                       ]
                     },
                     "text": "Иванов",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "21",
                         "length": "6"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "21",
                     "length": "6"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "21",
                 "length": "6"
               }
             ]
           },
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "302",
                   "y": "80"
                 },
                 {
                   "x": "302",
                   "y": "98"
                 },
                 {
                   "x": "370",
                   "y": "98"
                 },
                 {
                   "x": "370",
                   "y": "80"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "302",
                       "y": "80"
                     },
                     {
                       "x": "302",
                       "y": "98"
                     },
                     {
                       "x": "370",
                       "y": "98"
                     },
                     {
                       "x": "370",
                       "y": "80"
                     }
                   ]
                 },
                 "text": "Иван",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "302",
                           "y": "78"
                         },
                         {
                           "x": "302",
                           "y": "101"
                         },
                         {
                           "x": "370",
                           "y": "101"
                         },
                         {
                           "x": "370",
                           "y": "78"
                         }
                       ]
                     },
                     "text": "Иван",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "28",
                         "length": "4"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "28",
                     "length": "4"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "28",
                 "length": "4"
               }
             ]
           },
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "504",
                   "y": "82"
                 },
                 {
                   "x": "504",
                   "y": "98"
                 },
                 {
                   "x": "630",
                   "y": "98"
                 },
                 {
                   "x": "630",
                   "y": "82"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "504",
                       "y": "82"
                     },
                     {
                       "x": "504",
                       "y": "98"
                     },
                     {
                       "x": "630",
                       "y": "98"
                     },
                     {
                       "x": "630",
                       "y": "82"
                     }
                   ]
                 },
                 "text": "Иванович",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "504",
                           "y": "80"
                         },
                         {
                           "x": "504",
                           "y": "101"
                         },
                         {
                           "x": "630",
                           "y": "101"
                         },
                         {
                           "x": "630",
                           "y": "80"
                         }
                       ]
                     },
                     "text": "Иванович",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "33",
                         "length": "8"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "33",
                     "length": "8"
                   }
                 ]
               }
             ],
             "languages": [
               {
                 "languageCode": "ru"
               }
             ],
             "textSegments": [
               {
                 "startIndex": "33",
                 "length": "8"
               }
             ]
           }
         ],
         "entities": [],
         "tables": [
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "34",
                   "y": "30"
                 },
                 {
                   "x": "687",
                   "y": "41"
                 },
                 {
                   "x": "686",
                   "y": "119"
                 },
                 {
                   "x": "33",
                   "y": "108"
                 }
               ]
             },
             "rowCount": "2",
             "columnCount": "3",
             "cells": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "35",
                       "y": "30"
                     },
                     {
                       "x": "242",
                       "y": "33"
                     },
                     {
                       "x": "241",
                       "y": "64"
                     },
                     {
                       "x": "34",
                       "y": "61"
                     }
                   ]
                 },
                 "rowIndex": "0",
                 "columnIndex": "0",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Фамилия",
                 "textSegments": [
                   {
                     "startIndex": "0",
                     "length": "7"
                   }
                 ]
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "242",
                       "y": "33"
                     },
                     {
                       "x": "444",
                       "y": "37"
                     },
                     {
                       "x": "444",
                       "y": "67"
                     },
                     {
                       "x": "241",
                       "y": "64"
                     }
                   ]
                 },
                 "rowIndex": "0",
                 "columnIndex": "1",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Имя",
                 "textSegments": [
                   {
                     "startIndex": "8",
                     "length": "3"
                   }
                 ]
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "444",
                       "y": "37"
                     },
                     {
                       "x": "686",
                       "y": "40"
                     },
                     {
                       "x": "685",
                       "y": "71"
                     },
                     {
                       "x": "444",
                       "y": "67"
                     }
                   ]
                 },
                 "rowIndex": "0",
                 "columnIndex": "2",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Отчество",
                 "textSegments": [
                   {
                     "startIndex": "12",
                     "length": "8"
                   }
                 ]
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "34",
                       "y": "61"
                     },
                     {
                       "x": "241",
                       "y": "64"
                     },
                     {
                       "x": "241",
                       "y": "108"
                     },
                     {
                       "x": "34",
                       "y": "105"
                     }
                   ]
                 },
                 "rowIndex": "1",
                 "columnIndex": "0",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Иванов",
                 "textSegments": [
                   {
                     "startIndex": "21",
                     "length": "6"
                   }
                 ]
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "241",
                       "y": "64"
                     },
                     {
                       "x": "444",
                       "y": "67"
                     },
                     {
                       "x": "443",
                       "y": "111"
                     },
                     {
                       "x": "241",
                       "y": "108"
                     }
                   ]
                 },
                 "rowIndex": "1",
                 "columnIndex": "1",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Иван",
                 "textSegments": [
                   {
                     "startIndex": "28",
                     "length": "4"
                   }
                 ]
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "444",
                       "y": "67"
                     },
                     {
                       "x": "685",
                       "y": "71"
                     },
                     {
                       "x": "684",
                       "y": "115"
                     },
                     {
                       "x": "443",
                       "y": "111"
                     }
                   ]
                 },
                 "rowIndex": "1",
                 "columnIndex": "2",
                 "columnSpan": "1",
                 "rowSpan": "1",
                 "text": "Иванович",
                 "textSegments": [
                   {
                     "startIndex": "33",
                     "length": "8"
                   }
                 ]
               }
             ]
           }
         ],
         "fullText": "Фамилия\nИмя\nОтчество\nИванов\nИван\nИванович\n"
       },
       "page": "0"
     }
   }
   ```

   {% endcut %}

1. To get all the recognized words in an image, find all the values with the `text` property.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}