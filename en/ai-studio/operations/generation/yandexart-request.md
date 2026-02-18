# Generating an image using {{ yandexart-name }}

With {{ yandexart-name }}, you can generate images in [asynchronous mode](../../concepts/generation/index.md#working-mode). In response to an asynchronous request, the model will return an [operation object](../../../api-design-guide/concepts/operation.md) containing the operation ID you can use to [follow up the operation's progress](../../../api-design-guide/concepts/operation.md#monitoring) and get the result once the generation is complete. Generating a result in asynchronous mode can take from a few minutes up to several hours.

## Getting started {#before-begin}

To use the examples:

{% list tabs group=programming_language %}

- Management console {#console}

  You can start working from the management console right away.

- SDK {#sdk}

  {% include [yandexart-sdk-before-start](../../../_includes/ai-studio/yandexart/yandexart-sdk-before-start.md) %}

- cURL {#curl}

  1. Get API authentication credentials as described here: [{#T}](../../api-ref/authentication.md).

      To access the {{ yandexart-name }} API, first assign the `ai.imageGeneration.user` [role](../../security/index.md#imageGeneration-user) to the user or service account you will use to authenticate with the API.
  1. Install these tools:

      * [cURL](https://curl.haxx.se) to send API requests.
      * [jq](https://github.com/jqlang/jq) to handle JSON files.

{% endlist %}

## Generate an image {#generate-text}

{% note info %}

{{ yandexart-name }} logs user prompts to keep improving its responses. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=programming_language %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a folder for which your account has the `ai.playground.user` role or higher.
  1. [Go](../../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_ai-studio }}**.
  1. In the panel that opens, click ![image](../../../_assets/console-icons/flask.svg) **{{ ui-key.yacloud.yagpt.playground }}**.

     ![screen01](../../../_assets/ai-studio/quickstart/yandexart/screen01.png)

  1. Select the generation type: **{{ ui-key.yacloud.yagpt.YaGPT.CreateExperiment.foundation-models_playground_image-generation_title_rZxwV }}**.  
  1. Under **{{ ui-key.yacloud.yagpt.settings }}**, specify the following generation settings:

     * **{{ ui-key.yacloud.yagpt.label_seed }}**: Number used to generate the image. You can specify the number yourself or set a random value. The same prompt and seed will produce the same generation results.
     * **{{ ui-key.yacloud.yagpt.aspect-ratio-key-value }}**: Select the required image aspect ratio.

  1. Type your query in the input field below and click ![image](../../../_assets/console-icons/arrow-up.svg) or press **Enter**. You can also use the query examples provided above. You should use vivid and detailed descriptions, specify styles if you want your image styled in a certain way.

     All your dialogs are saved in the **{{ ui-key.yacloud.yagpt.experiments-page-subtitle }}** panel on the right. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the dialog to rename or delete it.

  1. Under **{{ ui-key.yacloud.yagpt.model-using }}**, click ![image](../../../_assets/console-icons/code.svg) **View code** to get the code for a request to the model via the AI Studio SDK for Python.

     ![screen02](../../../_assets/ai-studio/quickstart/yandexart/screen02.png)

- SDK {#sdk}

  This code includes four independent examples illustrating different uses of the SDK interface:
  * Example 1: A simple request consisting of one text description.
  * Example 2: A request of two text descriptions with the result saved to a file named `./image.jpeg`.
  * Example 3: A request of two text descriptions with weight specified.
  * Example 4: A combination of a request to [{{ gpt-pro }}](../../concepts/generation/models.md) (to generate an extended prompt) and a request to {{ yandexart-name }} (to generate an image based on that prompt).

  The code in the example does not return an [operation object](../../../api-design-guide/concepts/operation.md) but waits for the models to execute their requests and stores the result in the `result` variable.

  1. Create a file named `generate-image.py` and paste the following code into it:

      {% include [yandexart-sdk-big](../../../_includes/ai-studio/examples/yandexart-sdk-big.md) %}

      Where:

      {% note info %}

      {% include [sdk-input-format](../../../_includes/ai-studio/sdk-input-format.md) %}

      {% endnote %}

      * `message1`: Main part of the image generation prompt.
      * `message2`: Clarifying part of the image generation prompt.

      {% include [sdk-code-legend](../../../_includes/ai-studio/examples/sdk-code-legend.md) %}
      
  1. Run the file you created:

      ```bash
      python3 generate-image.py
      ```

      Result:

      ```text
      ImageGenerationModelResult(model_version='', image_bytes=<889288 bytes>)
      ImageGenerationModelResult(model_version='', image_bytes=<1062632 bytes>)
      GPTModelResult(alternatives=(Alternative(role='assistant', text='Here is an example of what a request to a YandexART model may look like:\n\n"Create an image of a red cat in Hayao Miyazaki anime style. Make the background in soft pastel shades with details emphasizing the atmosphere of magic and comfort."\n\n*Note that this is just an example and you can adapt it to your needs.*', status=<AlternativeStatus.FINAL: 3>),), usage=Usage(input_text_tokens=31, completion_tokens=76, total_tokens=107), model_version='07.03.2024')
      ImageGenerationModelResult(model_version='', image_bytes=<1180073 bytes>)
      ```

- cURL {#curl}

  {% include [bash-windows-note-single](../../../_includes/translate/bash-windows-note-single.md) %}

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
         "text": "a pattern of pastel-colored succulents of multiple varieties, hd full wallpaper, sharp focus, many intricate details, picture depth, top view"
       }
     ]
     }
     ```

     {% include [api-parameters](../../../_includes/ai-studio/yandexart/api-parameters.md) %}

  1. To send a request to the neural network using the [ImageGenerationAsync.generate](../../image-generation/api-ref/ImageGenerationAsync/generate.md) method, run the following command:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer <IAM_token_value>" \
       --data "@prompt.json" \
       "https://ai.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
     ```

     Where:

     * `<IAM_token_value>`: Your account's IAM token.
     * `prompt.json`: JSON file with the request parameters.

     The service will return the `operation` object in response:

     ```json
     {"id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

     Save the operation `id` you get in the response.

  1. Generating an image may take from a few seconds up to a few hours. Wait for a while and send a request to `https://operation.api.cloud.yandex.net:443/operations/<operation_ID>` to get the generation result. When the image is ready, you will get the result in a [Base64-encoded](https://en.wikipedia.org/wiki/Base64) file named `image.jpeg`. 

     ```bash
     curl --request GET --header "Authorization: Bearer <IAM_token_value>" https://operation.api.cloud.yandex.net:443/operations/<operation_ID> | jq -r '.response | .image' | base64 -d > image.jpeg
     ```

     Where:

     * `<IAM_token_value>`: IAM token you obtained [when getting started](#before-begin).
     * `<operation_ID>`: `id` field value obtained in response to the generation prompt.

{% endlist %}

#### See also {#see-also}

* [{#T}](../../concepts/generation/index.md)
* Examples of working with {{ ml-sdk-name }} on [GitHub](https://github.com/yandex-cloud/yandex-ai-studio-sdk/tree/master/examples/sync/image_generation)