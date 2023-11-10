# Getting started with {{ vision-short-name }}

This section describes how to recognize text in an image or file using the {{ vision-short-name }} [OCR API](../vision/ocr/api-ref/index.md).

## Getting started {#before-you-begin}

{% include [curl](../_includes/curl.md) %}


{% list tabs %}

- User's Yandex account

   1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
   1. [Get an IAM token](../iam/operations/iam-token/create.md), which is required for authentication.
   1. [Get the ID of any folder](../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
   1. Specify the ID in the `x-folder-id` header.

{% endlist %}

## Recognize text {#analyze-image}

You can use any of the analysis features from the [list](concepts/index.md#features). For example, use the [Text recognition](concepts/ocr/index.md) feature:

1. Prepare an image file that meets the requirements:

   {% include [file-restrictions](../_includes/vision/ocr-file-restrictions.md) %}

   {% note info %}

   Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

   {% endnote %}

1. Encode the image file as Base64:

   {% include [base64-encode-command](../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body (for example, `body.json`).

   **body.json:**
   ```json
   {
     "mimeType": "JPEG",
     "languageCodes": ["*"],
     "model": "page",
     "content": "<base64-encoded_image>"
   }
   ```

   In the `content` property, specify the image file contents [encoded](./operations/base64-encode.md) as Base64.

   For the service to automatically detect the text language, specify the `"languageCodes": ["*"]` property in the configuration.


1. {% include [send-request](../_includes/vision/send-request_ocr.md) %}

   The result will consist of recognized blocks of text, lines, and words with their position on the image:

   ```json
   {
     "result": {
       "text_annotation": {
         "width": "1920",
         "height": "1280",
         "blocks": [{
           "bounding_box": {
             "vertices": [{
               "x": "460",
               "y": "777"
             }, {
               "x": "460",
               "y": "906"
             }, {
               "x": "810",
               "y": "906"
             }, {
               "x": "810",
               "y": "777"
             }]
           },
           "lines": [{
             "bounding_box": {
               "vertices": [{
                 "x": "460",
                 "y": "777"
               }, {
                 "x": "460",
                 "y": "820"
               }, {
                 "x": "802",
                 "y": "820"
               }, {
                 "x": "802",
                 "y": "777"
               }]
             },
             "alternatives": [{
               "text": "PENGUINS",
               "words": [{
                 "bounding_box": {
                   "vertices": [{
                     "x": "460",
                     "y": "768"
                   }, {
                     "x": "460",
                     "y": "830"
                   }, {
                     "x": "802",
                     "y": "830"
                   }, {
                     "x": "802",
                     "y": "768"
                   }]
                 },
                 "text": "PENGUINS",
                 "entity_index": "-1"
               }]
             }]
           }, {
             "bounding_box": {
               "vertices": [{
                 "x": "489",
                 "y": "861"
               }, {
                 "x": "489",
                 "y": "906"
               }, {
                 "x": "810",
                 "y": "906"
               }, {
                 "x": "810",
                 "y": "861"
               }]
             },
             "alternatives": [{
               "text": "CROSSING",
               "words": [{
                 "bounding_box": {
                   "vertices": [{
                     "x": "489",
                     "y": "852"
                   }, {
                     "x": "489",
                     "y": "916"
                   }, {
                     "x": "810",
                     "y": "916"
                   }, {
                     "x": "810",
                     "y": "852"
                   }]
                 },
                 "text": "CROSSING",
                 "entity_index": "-1"
               }]
             }]
           }],
           "languages": [{
             "language_code": "en"
           }]
         }, {
           "bounding_box": {
             "vertices": [{
               "x": "547",
               "y": "989"
             }, {
               "x": "547",
               "y": "1046"
             }, {
               "x": "748",
               "y": "1046"
             }, {
               "x": "748",
               "y": "989"
             }]
           },
           "lines": [{
             "bounding_box": {
               "vertices": [{
                 "x": "547",
                 "y": "989"
               }, {
                 "x": "547",
                 "y": "1046"
               }, {
                 "x": "748",
                 "y": "1046"
               }, {
                 "x": "748",
                 "y": "989"
               }]
             },
             "alternatives": [{
               "text": "SLOW",
               "words": [{
                 "bounding_box": {
                   "vertices": [{
                     "x": "547",
                     "y": "983"
                   }, {
                     "x": "547",
                     "y": "1054"
                   }, {
                     "x": "748",
                     "y": "1054"
                   }, {
                     "x": "748",
                     "y": "983"
                   }]
                 },
                 "text": "SLOW",
                 "entity_index": "-1"
               }]
             }]
           }],
           "languages": [{
             "language_code": "en"
           }]
         }],
         "entities": []
       },
       "page": "0"
     }
   }
   ```

1. To get all the recognized words in an image, find all the values with the `text` property.

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}

#### What's next {#what-is-next}

* [Find out about all the service features](concepts/index.md)
* [Learn about API authentication methods](api-ref/authentication.md)
* [Detect faces in a photo](operations/face-detection/index.md)
* [Assess the quality of an image](operations/classification/quality.md)
* [Moderate images](operations/classification/moderation.md)
