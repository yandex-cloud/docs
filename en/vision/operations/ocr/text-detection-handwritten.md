---
title: "How to recognize handwriting in {{ vision-full-name }}. Step-by-step guide"
description: "In this guide, you will learn how to recognize a combination of typed and handwritten text in Russian and English in {{ vision-full-name }}."
---

# Handwriting recognition

You can [recognize handwritten text](../../concepts/ocr/index.md) in an image using the [OCR API](../../ocr/api-ref/index.md) with the `handwritten` recognition model. With this model, you can recognize any combination of handwritten and typed text in Russian and English.

## Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Recognizing handwritten text in an image {#recognize-handwriting}

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
     "model": "handwritten",
     "content": "<base64-encoded_image>"
   }
   ```

   In the `content` property, specify the image file contents [encoded](../base64-encode.md) as Base64.


1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

   The result will consist of recognized blocks of text, lines, and words with their position on the image:

   ```json
   {
     "result": {
       "textAnnotation": {
         "width": "241",
         "height": "162",
         "blocks": [
           {
             "boundingBox": {
               "vertices": [
                 {
                   "x": "28",
                   "y": "8"
                 },
                 {
                   "x": "28",
                   "y": "130"
                 },
                 {
                   "x": "240",
                   "y": "130"
                 },
                 {
                   "x": "240",
                   "y": "8"
                 }
               ]
             },
             "lines": [
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "28",
                       "y": "8"
                     },
                     {
                       "x": "28",
                       "y": "77"
                     },
                     {
                       "x": "240",
                       "y": "77"
                     },
                     {
                       "x": "240",
                       "y": "8"
                     }
                   ]
                 },
                 "text": "Hello,",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "28",
                           "y": "9"
                         },
                         {
                           "x": "28",
                           "y": "81"
                         },
                         {
                           "x": "240",
                           "y": "81"
                         },
                         {
                           "x": "240",
                           "y": "9"
                         }
                       ]
                     },
                     "text": "Hello,",
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
               },
               {
                 "boundingBox": {
                   "vertices": [
                     {
                       "x": "112",
                       "y": "94"
                     },
                     {
                       "x": "112",
                       "y": "130"
                     },
                     {
                       "x": "240",
                       "y": "130"
                     },
                     {
                       "x": "240",
                       "y": "94"
                     }
                   ]
                 },
                 "text": "World!",
                 "words": [
                   {
                     "boundingBox": {
                       "vertices": [
                         {
                           "x": "112",
                           "y": "89"
                         },
                         {
                           "x": "112",
                           "y": "137"
                         },
                         {
                           "x": "240",
                           "y": "137"
                         },
                         {
                           "x": "240",
                           "y": "89"
                         }
                       ]
                     },
                     "text": "World!",
                     "entityIndex": "-1",
                     "textSegments": [
                       {
                         "startIndex": "8",
                         "length": "4"
                       }
                     ]
                   }
                 ],
                 "textSegments": [
                   {
                     "startIndex": "8",
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
                 "startIndex": "0",
                 "length": "12"
               }
             ]
           }
         ],
         "entities": [],
         "tables": [],
         "fullText": "Hello,\nWorld!\n"
       },
       "page": "0"
     }
   }
   ```

1. To get all the recognized words in an image, find all the values with the `text` property.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}