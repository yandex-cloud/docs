# Getting started with {{ yandexart-name }}

{% include notitle [preview-stage](../../_includes/foundation-models/yandexgpt/preview.md) %}

In this section, you will learn how to use the {{ yandexart-name }} neural network to generate images.

In the [management console]({{ link-console-main }}/link/foundation-models/yandexart), {{ art-freetier }} free requests per day are available to new users without a [billing account](../../billing/concepts/billing-account.md). To access the API and increase usage [quotas](../concepts/limits.md), [link](../../billing/operations/pin-cloud.md) your billing account to the cloud.

## Getting started {#before-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure that you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

{% list tabs group=instructions %}

- Management console {#console}

   You can start working from the management console right away.

- API {#api}

   To use request examples via the API, install [cURL](https://curl.haxx.se) for sending API requests to [jq](https://github.com/jqlang/jq) to work with JSON files.

   To work with the {{ yandexart-name }} API, you need to get authenticated using your account:

   1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md).
   1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-yaart-user }}` role or higher. You will need the folder ID to get the [model's URI](../concepts/yandexart/models.md).
   1. When accessing {{ yandexart-name }} via the API, specify the IAM token in the `Authorization` header of each request:

      ```json
      x-folder-id: <folder_ID>
      ```

   For information about other API authentication methods, see [{#T}](../api-ref/authentication.md).

{% endlist %}

## Generate an image {#generate-text}

{% note info %}

To improve the quality of generated responses, {{ yandexart-name }} logs user prompts. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `{{ roles-yaart-user }}` role or higher.
   1. In the list of services, select **{{ foundation-models-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/palette.svg) **{{ yandexart-name }}**.
   1. In the input field, describe the image you want to generate. You should use vivid and detailed descriptions, specify styles if you want your image styled in a certain way.
   1. Leave the [**Seed** parameter](../concepts/yandexart/index.md) random or specify any value.
   1. Click **Generate**. Image generation is going to take some time. The output will be presented in the left portion of the screen.

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

      {% include [api-parameters](../../_includes/foundation-models/yandexgpt/api-parameters.md) %}

   1. To request the neural network using the [ImageGenerationAsync.generate](../image-generation/api-ref/ImageGenerationAsync/generate.md) method, run the following command:

      ```bash
      curl --request POST \
        -H "Authorization: Bearer <IAM_token_value>" \
        -d "@prompt.json" \
        "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
      ```

      Where:

      * `<IAM_token_value>`: IAM token you got for your account.
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


      **Result**:

      ![succulent](../../_assets/yandexgpt/succulent.jpeg)

{% endlist %}

#### What's next {#what-is-next}

* [Learn more about {{ yagpt-full-name }}](../concepts/index.md)
* [Learn about API authentication methods](../api-ref/authentication.md)