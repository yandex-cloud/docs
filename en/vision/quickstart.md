# Getting started with {{ vision-short-name }}

This section describes how to recognize text in an image or file using the {{ vision-short-name }} [API](../vision/ocr/api-ref/index.md).

## Getting started {#before-you-begin}

{% include [curl](../_includes/curl.md) %}


{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) that is either `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
  1. [Get an IAM token](../iam/operations/iam-token/create.md), which is required for authentication.
  1. [Get the ID of any folder](../resource-manager/operations/folder/get-id.md) for which your account has the `{{ roles-vision-user }}` role or higher.
  1. Specify the ID in the `x-folder-id` header.

{% endlist %}

## Recognize text {#analyze-image}

You can use any recognition model from [this list](concepts/ocr/index.md#models). As an example, we will use the `page` model which can recognize any amount of text in an image:

1. Prepare an image file that meets the requirements:

    {% include [file-restrictions](../_includes/vision/ocr-file-restrictions.md) %}

    {% include [file-restrictions](../_includes/vision/example-image.md) %}

1. Encode the image file as Base64:

    {% include [base64-encode-command](../_includes/vision/base64-encode-command.md) %}

1. Create a file with the request body, e.g., `body.json`.

    **body.json:**
    ```json
    {
      "mimeType": "JPEG",
      "languageCodes": ["*"],
      "model": "page",
      "content": "<base64_encoded_image>"
    }
    ```

    In the `content` property, specify the image file contents [encoded](./operations/base64-encode.md) as Base64.
    
    To automatically detect the text language, specify the `"languageCodes": ["*"]` property in the configuration.


1. {% include [send-request](../_includes/vision/send-request_ocr.md) %}

    The result will consist of recognized blocks of text, lines, and words with their position on the image:

    {% include [text-detection-penguins](../_includes/vision/text-detection-example.md) %}

1. To get all the words recognized in the image, find all values with the `text` property.

{% include [coordinate-definition-issue-note](../_includes/vision/coordinate-definition-issue-note.md) %}
