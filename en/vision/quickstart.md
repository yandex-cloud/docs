# Getting started with [!KEYREF vision-short-name]

This section describes how to get started with the [!KEYREF vision-short-name] API for image analysis.

## Before getting started

1. Make sure you have installed the [cURL](https://curl.haxx.se) utility that is used in the examples.

1. [Get the ID of the folder](../resource-manager/operations/folder/get-id.md) for which you are granted the `editor` role or a higher role. The folder ID is used for authorization. For more information, see [Access management](security/index.md).

1. Get the IAM token required for authentication in the API ([other authentication methods](api-ref/authentication.md)):

    ---

    **[!TAB CLI]**

    ```
    $ yc iam create-token
    ```

    **[!TAB API]**

    [!INCLUDE [create-iam-token-api-steps](../_includes/iam/create-iam-token-api-steps.md)]

    ---

## Analyze the image

You can use any of the analysis features from the [list](concepts/index.md#features). For example, use the [Text recognition](concepts/ocr/index.md) feature:

[!INCLUDE [text-detection-steps](../_includes/vision/text-detection-steps.md)]

#### What's next

* [Find out about all the service features](concepts/index.md)
* [Detect faces in a photo](operations/face-detection/index.md)
* [Assess the quality of an image](operations/classification/quality.md)
* [Moderate images](operations/classification/moderation.md)

