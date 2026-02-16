1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `ai.imageGeneration.user` [role](../../../ai-studio/security/index.md#imageGeneration-user).

You also need to assign the `ai.languageModels.user` [role](../../../ai-studio/security/index.md#languageModels-user) to the service account; in the example, we will utilize [{{ gpt-pro }}](../../../ai-studio/concepts/generation/index.md) to generate a prompt for {{ yandexart-name }}.
1. [Get](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) and save the service account's API key.

    {% include [sdk-auth-details-paragraph](../sdk-auth-details-paragraph.md) %}
1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the {{ ml-sdk-name }} library:

    ```bash
    pip install yandex-ai-studio-sdk
    ```