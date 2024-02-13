# Text line recognition

If you do not want to send an entire image to {{ vision-name }}, you can cut out a single line and send it for recognition.

## Getting started {#before-you-begin}

{% include [curl](../../../_includes/curl.md) %}

{% include [ai-before-beginning](../../../_includes/vision/ai-before-beginning.md) %}

## Recognizing a text line using the OCR API {#ocr-line-recognition}

The OCR API allows you to recognize a separate line using the [recognize](../../ocr/api-ref/TextRecognition/recognize.md) method.

To recognize a single line of text in an image, follow the [Text recognition in images](./text-detection-image.md) guide.

## Recognizing a text line using the Vision API {#vision-line-recognition}

{% include [deprecation-warning](../../../_includes/vision/deprecation-warning.md) %}

The Vision API allows you to recognize a separate line using the [recognize](../../ocr/api-ref/TextRecognition/recognize.md) method.

In the configuration, specify the `line` model to recognize text lines more accurately.

{% note alert %}

{% include [include](../../../_includes/vision/text-detection-line-note.md) %}

{% endnote %}

To recognize a line of text:

1. Encode the file as Base64:

    {% include [base64-encode-command](../../../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`:

    **body.json:**
    ```json
    {
        "folderId": "b1gvmob95yys********",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            "features": [{
                "type": "TEXT_DETECTION",
                "text_detection_config": {
                    "language_codes": ["*"],
                    "model": "line"
                }
            }]
        }]
    }
    ```

    Where:
    * `folderId`: [ID of any folder](../../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
    * `content`: Image file contents [encoded](../base64-encode.md) as Base64.
    * `model`: `Line` model.

1. {% include [send-request](../../../_includes/vision/send-request.md) %}

