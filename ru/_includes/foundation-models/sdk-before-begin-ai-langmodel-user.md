1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт и [назначьте](../../iam/operations/sa/assign-role-for-sa.md) ему [роль](../../foundation-models/security/index.md#languageModels-user) `ai.languageModels.user`.
1. [Получите](../../iam/operations/api-key/create.md) и сохраните API-ключ сервисного аккаунта.  
1. С помощью менеджера пакетов [pip](https://pip.pypa.io/en/stable/) установите библиотеку {{ ml-sdk-name }}:

    ```bash
    pip install yandex-cloud-ml-sdk
    ```