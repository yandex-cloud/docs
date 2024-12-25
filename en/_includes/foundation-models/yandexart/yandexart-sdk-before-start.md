1. [Create](../../../iam/operations/sa/create.md) a service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `ai.imageGeneration.user` [role](../../../foundation-models/security/index.md#imageGeneration-user).

    You also need to assign the `ai.languageModels.user` [role](../../../foundation-models/security/index.md#languageModels-user) to the service account; in the example, we will utilize a [{{ yagpt-full-name }}](../../../foundation-models/concepts/yandexgpt/index.md) model to generate a prompt for {{ yandexart-name }}.
1. [Get](../../../iam/operations/api-key/create.md) the service account API key and save it.  
1. Use the [pip](https://pip.pypa.io/en/stable/) package manager to install the {{ ml-sdk-name }} library:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```