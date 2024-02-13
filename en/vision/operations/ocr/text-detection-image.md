# Text recognition in images

You can [recognize text](../../concepts/ocr/index.md) in an image using the [OCR API](../../ocr/api-ref/index.md). The OCR API is an updated and revised interface with enhanced [features](../../concepts/limits.md#vision-limits), including multi-column text recognition.

## Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Recognizing text in an image through the OCR API {#ocr-api-recognition}

Image text recognition is implemented in the [recognize](../../ocr/api-ref/TextRecognition/recognize.md) OCR API method.

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../../../_includes/vision/ocr-file-restrictions.md) %}

    {% note info %}

    Need a sample image? Download an image of the [penguin crossing](https://{{ s3-storage-host }}/vision/penguins_sample.jpg) road sign.

    {% endnote %}

1. Encode the image file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<base64-encoded_image>"
    }
    ```

    In the `content` property, specify the image file contents [encoded](../base64-encode.md) as Base64.

    For the service to automatically detect the text language, specify the `"languageCodes": ["*"]` property in the configuration.


1. {% include [send-request](../../../_includes/vision/send-request_ocr.md) %}

    The result will consist of recognized blocks of text, lines, and words with their position on the image:

    {% include [text-detection](../../../_includes/vision/text-detection-example.md) %}

1. To get all the recognized words in an image, find all the values with the `text` property.

{% include [coordinate-definition-issue-note](../../../_includes/vision/coordinate-definition-issue-note.md) %}

