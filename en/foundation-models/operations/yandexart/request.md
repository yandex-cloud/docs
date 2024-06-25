# Generating an image using {{ yandexart-name }}

{% include notitle [preview-stage](../../../_includes/foundation-models/yandexgpt/preview.md) %}

With {{ yandexart-name }}, you can generate images in [asynchronous mode](../../concepts/index.md#working-mode). In response to an asynchronous request, the model will return an [Operation object](../../../api-design-guide/concepts/operation.md) containing an operation ID, which you can use to [track its execution](../../../api-design-guide/concepts/operation.md#monitoring) and get the result after generation is completed. Generating a result in asynchronous mode can take from a couple of minutes to several hours.

## Getting started {#before-begin}

{% list tabs group=instructions %}

- API {#api}

   To run sample requests using the API, install:

   * [cURL](https://curl.haxx.se) to send API requests
   * [jq](https://github.com/jqlang/jq) utility to work with JSON files

   Get API authentication credentials as described on the [{#T}](../../api-ref/authentication.md) page.

{% endlist %}

## Generate an image {#generate-text}

{% note info %}

To improve the quality of responses, {{ yandexart-name }} logs user prompts. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=instructions %}

- API {#api}

   1. Create a file with the request body, e.g., `prompt.json`:

      ```json
      {
      "modelUri": "art://<folder_ID>/yandex-art/latest",
      "generationOptions": {
        "seed": "1863",
        "aspectRatio": {
           "widthRatio": "2",
           "heightRatio": "1"
         }
      },
      "messages": [
        {
          "weight": "1",
          "text": "a pattern of pastel colored succulents of various sorts, hd full wallpaper, sharp focus, many intricate details, picture depth, top view"
        }
      ]
      }
      ```

      {% include [api-parameters](../../../_includes/foundation-models/yandexart/api-parameters.md) %}

   1. To send a request to the neural network using the [ImageGenerationAsync.generate](../../image-generation/api-ref/ImageGenerationAsync/generate.md) method, run the following command:

      ```bash
      curl --request POST \
        -H "Authorization: Bearer <IAM_token_value>" \
        -d "@prompt.json" \
        "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"  
      ```

      Where:

      * `<IAM_token_value>`: IAM token of your account.
      * `prompt.json`: JSON file with request parameters.

      In response, the service will return the Operation object:

      ```json
      {
      "id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
      ```

      Save the operation `id` received in the response.

   1. Generating an image may take from a few seconds to a few hours. Wait a while and send a request to `https://llm.api.cloud.yandex.net:443/operations/<operation_ID>` to get the generation result. When the image is ready, you will get the result in a [Base64-encoded](https://en.wikipedia.org/wiki/Base64) file named `image.jpeg`.

      ```bash
      curl -X GET -H "Authorization: Bearer <IAM_token_value>" https://llm.api.cloud.yandex.net:443/operations/<operation_ID> | jq -r '.response | .image' | base64 -d > image.jpeg
      ```

      Where:

      * `<IAM_token_value>`: IAM token received [before you started](#before-begin).
      * `<operation_ID>`: `id` field value obtained in response to the generation request.

{% endlist %}
