1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../foundation-models/security/index.md#imageGeneration-user) `ai.imageGeneration.user`.

Также назначьте сервисному аккаунту [роль](../../../foundation-models/security/index.md#languageModels-user) `ai.languageModels.user` — в примере дополнительно используется модель [{{ gpt-pro }}](../../../foundation-models/concepts/yandexgpt/index.md) для генерации промта для {{ yandexart-name }}.
1. [Получите](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) и сохраните API-ключ сервисного аккаунта.

    {% include [sdk-auth-details-paragraph](../sdk-auth-details-paragraph.md) %}
1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите библиотеку {{ ml-sdk-name }}:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```