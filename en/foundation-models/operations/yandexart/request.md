# Generating an image using {{ yandexart-name }}

{% include notitle [preview-stage](../../../_includes/foundation-models/yandexgpt/preview.md) %}

With {{ yandexart-name }}, you can generate images in [asynchronous mode](../../concepts/index.d#working-mode).


## Getting started {#before-begin}

{% list tabs group=instructions %}

- API {#api}

   To use request examples via the API, install [cURL](https://curl.haxx.se) for sending API requests to [jq](https://github.com/jqlang/jq) to work with JSON files.

   Get API authentication credentials as described on the [{#T}](../../api-ref/authentication.md) page.

{% endlist %}

## Generate an image {#generate-text}

{% note info %}

To improve the quality of generated responses, {{ yandexart-name }} logs user prompts. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=instructions %}

- API {#api}

   1. Create a file with the request body (for example, `prompt.json`).

      ```json
      {
      "modelUri": "art://<folder_ID>/yandex-art/latest",
      "generationOptions": {
        "seed": 17
      },
      "messages": [
        {
          "weight": 1,
          "text": "a pattern of pastel colored succulents of various sorts, hd full wallpaper, sharp focus, many complex details, picture depth, top view"
        }
      ]
      }
      ```

      Where:

      {% include [api-parameters](../../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

   1. To request the neural network using the [ImageGenerationAsync.generate](../../image-generation/api-ref/ImageGenerationAsync/generate.md) method, run the following command:

      ```bash
      curl --request POST \
        -H "Authorization: Bearer <IAM_token_value>" \
        -d "@prompt.json" \
        "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
      ```

      Where:

      * `<IAM_token_value>`: IAM token of your account.
      * `prompt.json`: JSON file with request parameters.

      The service will return the ID of your request in response:

      ```json
      {
      "id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
      ```

   1. Generating an image takes some time. Wait for 10 seconds and send your request to get the generation result. When the image is ready, you will get the result in a [Base64-encoded](https://en.wikipedia.org/wiki/Base64) file named `image.jpeg`.

      ```bash
      curl -X GET -H "Authorization: Bearer <IAM_token_value>" https://llm.api.cloud.yandex.net:443/operations/<request_ID> | jq -r '.response | .image' | base64 -d > image.jpeg
      ```

      Where:

      * `<IAM_token_value>`: IAM token received [before you started](#before-begin).
      * `<request_ID>`: `id` field value obtained in response to the generation request.

{% endlist %}
