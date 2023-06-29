1. Клонируйте [репозиторий {{ yandex-cloud }} API](https://github.com/yandex-cloud/cloudapi):

    ```bash
    git clone https://github.com/yandex-cloud/cloudapi
    ```

1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт для работы с API {{ speechkit-short-name }}.
1. [Назначьте](../../iam/operations/sa/assign-role-for-sa.md) сервисному аккаунту роль `{{ roles-speechkit-tts }}` или выше на каталог, в котором он был создан.
1. [Получите](../../iam/operations/iam-token/create-for-sa.md) IAM-токен для сервисного аккаунта.
