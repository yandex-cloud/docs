1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роли](../../foundation-models/security/index.md#service-roles) `ai.assistants.editor` и `ai.languageModels.user`.
1. [Получите](../../iam/operations/api-key/create.md) и сохраните API-ключ сервисного аккаунта.

    {% include [sdk-auth-details-paragraph](./sdk-auth-details-paragraph.md) %}
1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите библиотеку {{ ml-sdk-name }}:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```