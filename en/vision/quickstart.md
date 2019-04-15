# Getting started with [!KEYREF vision-short-name]

This section describes how to get started with the [!KEYREF vision-short-name] API for image analysis. For now, the service allows you to recognize text in an image.

## Before getting started

1. Make sure you have installed the [cURL](https://curl.haxx.se) utility that is used in the examples.

1. [Get the ID of the folder](../resource-manager/operations/folder/get-id.md) for which you are granted the `editor` role or a higher role. For more information about the required roles, see [Access management](security/index.md).

    If there is no folder yet, create one:

    [!INCLUDE [create-folder](../_includes/create-folder.md)]

1. Get the IAM token required for authentication (to get the IAM token for a service account, follow these [instructions](../iam/operations/iam-token/create-for-sa.md)):

    ---

    **[!TAB CLI]**

    ```
    $ yc iam create-token
    ```

    **[!TAB API]**

    [!INCLUDE [create-iam-token-api-steps](../_includes/iam/create-iam-token-api-steps.md)]

    ---

## Recognize text in an image

[!INCLUDE [text-detection-steps](../_includes/vision/text-detection-steps.md)]

