# Getting started with {{ yandexart-name }}

In this section, you will learn how to use the {{ yandexart-name }} neural network to generate images.

In the [management console]({{ link-console-main }}/link/foundation-models/yandexart), {{ art-freetier }} free prompts per day are available to new users without a [billing account](../../billing/concepts/billing-account.md). To access the API and increase usage [quotas](../concepts/limits.md), [link](../../billing/operations/pin-cloud.md) your billing account to the cloud.

## Getting started {#before-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. In [{{ billing-name }}]({{ link-console-billing }}), make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and its [status](../../billing/concepts/billing-account-statuses.md) is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) yet, [create one](../../resource-manager/operations/folder/create.md).

{% list tabs group=instructions %}

- Management console {#console}

  You can start working from the management console right away.

- SDK {#sdk}

  To use the examples of requests using SDK:

  1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `ai.imageGeneration.user` role to it.

  1. [Get](../../iam/operations/authentication/manage-api-keys.md#create-api-key) the service account API key and save it.

      {% include [sdk-auth-details-paragraph](../../_includes/foundation-models/sdk-auth-details-paragraph.md) %}
  1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the {{ ml-sdk-name }} library:

      ```bash
      pip install yandex-cloud-ml-sdk
      ```

- API {#api}

  To run examples of requests using the API, install:
  
  * [cURL](https://curl.haxx.se) to send API requests.
  * [jq](https://github.com/jqlang/jq) utility to work with JSON files.

  To work with the {{ yandexart-name }} API, you need to get authenticated using your account:

  1. Get an IAM token for your [Yandex account](../../iam/operations/iam-token/create.md) or [federated account](../../iam/operations/iam-token/create-for-federation.md).
  1. Get the [ID of the folder](../../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-yaart-user }}` role or higher. You will need the folder ID to get the [model URI](../concepts/yandexart/models.md).
  1. When accessing {{ yandexart-name }} via the API, specify the IAM token in the `Authorization` header of each request:

     ```json
     x-folder-id: <folder_ID>
     ```

  For information about other API authentication methods, see [{#T}](../api-ref/authentication.md).

{% endlist %}

## Generate an image {#generate-text}

{% note info %}

{{ yandexart-name }} logs user prompts to generate better responses. Do not use sensitive information and personal data in your prompts.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder for which your account has the `{{ roles-yaart-user }}` role or higher.
  1. From the list of services, select **{{ foundation-models-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/palette.svg) **{{ yandexart-name }}**.
  1. In the input field, describe the image you want to generate. You should use vivid and detailed descriptions, specify styles if you want your image styled in a certain way.
  1. Leave the [**seed**](../concepts/yandexart/index.md) parameter random or specify any value.
  1. Click **Generate**. Generating an image takes some time The output will appear on the left side of the screen.

- SDK {#sdk}

  The code in the example waits until the model completes the request, then saves the result to the `result` variable before saving the generated image on the disk to the `image.jpeg` file in the current directory. For additional methods of working with the {{ yandexart-name }} model, see [{#T}](../operations/yandexart/request.md).

  1. Create a file named `generate-image.py` and paste the following code into it:

      {% include [yandexart-sdk-small](../../_includes/foundation-models/examples/yandexart-sdk-small.md) %}

      Where:
      * `message`: Variable containing the text of the image generation request.

          {% include [sdk-input-format](../../_includes/foundation-models/sdk-input-format.md) %}

      {% include [sdk-code-legend](../../_includes/foundation-models/examples/sdk-code-legend.md) %}

      For more information about accessing a model, see [{#T}](../concepts/yandexart/models.md#addressing-models).
      
  1. Run the created file:

      ```bash
      python3 generate-image.py
      ```

     **Result:** 

     ![succulent](../../_assets/yandexgpt/succulent.jpeg)

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
         "text": "a pattern of pastel colored succulents of multiple varieties, hd full wallpaper, sharp focus, many intricate details, picture depth, top view"
       }
     ]
     }
     ```

     {% include [api-parameters](../../_includes/foundation-models/yandexart/api-parameters.md) %}

  1. To send a request to the neural network using the [ImageGenerationAsync.generate](../image-generation/api-ref/ImageGenerationAsync/generate.md) method, run the following command:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer <IAM_token_value>" \
       --data "@prompt.json" \
       "https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync"
     ```

     Where:
 
     * `<IAM_token_value>`: IAM token you got for your account.
     * `prompt.json`: JSON file with request parameters.
     
     The service will respond with your request ID:

     ```json
     {
     "id":"fbveu1sntj**********","description":"","createdAt":null,"createdBy":"","modifiedAt":null,"done":false,"metadata":null}
     ```

  1. Generating an image takes some time. Wait for 10 seconds and send your request to get the generation result. When the image is ready, you will get the result in a [Base64-encoded](https://en.wikipedia.org/wiki/Base64) file named `image.jpeg`.
  
     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer <IAM_token_value>" \
       https://llm.api.cloud.yandex.net:443/operations/<request_ID> | \
       jq -r '.response | .image' | base64 -d > image.jpeg
     ```

     Where:

     * `<IAM_token_value>`: IAM token you obtained [when getting started](#before-begin).
     * `<request_ID>`: `id` field value obtained in response to the generation request.
     

     **Result:** 

     ![succulent](../../_assets/yandexgpt/succulent.jpeg)

{% endlist %}

#### What's next {#what-is-next}

* [Learn more about the service](../concepts/index.md)
* [Learn about API authentication methods](../api-ref/authentication.md)