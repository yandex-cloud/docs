1. [Создайте](../../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../../ai-studio/security/index.md#imageGeneration-user) `ai.imageGeneration.user`.

Также назначьте сервисному аккаунту [роль](../../../ai-studio/security/index.md#languageModels-user) `ai.languageModels.user` — в примере дополнительно используется модель [{{ gpt-pro }}](../../../ai-studio/concepts/generation/index.md) для генерации промпта для {{ yandexart-name }}.
1. [Получите](../../../iam/operations/authentication/manage-api-keys.md#create-api-key) и сохраните API-ключ сервисного аккаунта.

    {% include [sdk-auth-details-paragraph](../sdk-auth-details-paragraph.md) %}
1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите библиотеку {{ ml-sdk-name }}:

    ```bash
    pip install yandex-ai-studio-sdk
    ```