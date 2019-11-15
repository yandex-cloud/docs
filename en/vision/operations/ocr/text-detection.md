# Recognizing text in an image

To recognize text in an image, use the [Text recognition](../../concepts/ocr/index.md) feature.

In the [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) method, set the `type` property to `TEXT_DETECTION`, and specify the recognition settings in the `textDetectionConfig` property.

{% note info %}

The service recognizes text written horizontally. If an image or text is rotated, recognition may fail. If you scanned a document and don't know how the image was rotated, send several versions of the image with different rotation angles.

{% endnote %}

## Examples {#examples}

{% include [ai-before-beginning](../../../_includes/ai-before-beginning.md) %}

### Recognize text {#basic}

{% include [text-detection-steps](../../../_includes/vision/text-detection-steps.md) %}

### Recognize text in multiple languages {#multiple-languages}

1. Create a file with the request body (for example, `body.json`). In the `content` property, specify a [Base64-encoded](../base64-encode.md) image.

    **body.json:**

    ```json
    {
        "folderId": "b1gvmob95yysaplct532",
        "analyze_specs": [{
            "content": "iVBORw0KGgo...",
            ...
    ```

1. [Select the languages](../../concepts/ocr/supported-languages.md) for text recognition and the appropriate recognition models:

   * If all the languages are in the same model, specify multiple languages in the request body (for example, French and German):

       **body.json:**

       ```json
       {
           "folderId": "b1gvmob95yysaplct532",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["fr", "de"]
                   }
               }]
           }]
       }
       ```

   * If the languages are from different models, set multiple configurations in the `features` property.
For example, you can recognize images in Hebrew, Arabic, and English:

       **body.json:**

       ```json
       {
           "folderId": "b1gvmob95yysaplct532",
           "analyze_specs": [{
               "content": "iVBORw0KGgo...",
               "features": [{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["he","en"]
                   }
               },{
                   "type": "TEXT_DETECTION",
                   "text_detection_config": {
                       "language_codes": ["ar","en"]
                   }
               }]
           }]
       }
       ```

1. Send a recognition request using the [batchAnalyze](../../api-ref/Vision/batchAnalyze.md) method and save the response to a file, such as `output.json`:

    ```bash
    $ export IAM_TOKEN=CggaATEVAgA...
    $ curl -X POST \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer ${IAM_TOKEN}" \
        -d '@body.json' \
        https://vision.api.cloud.yandex.net/vision/v1/batchAnalyze > output.json
    ```

