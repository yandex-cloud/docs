Настройте CLI для работы от имени сервисного аккаунта:

1. {% include [cli-install](cli-install.md) %}
1. Создайте [авторизованный ключ](../iam/concepts/authorization/key.md) для вашего сервисного аккаунта и запишите его в файл:
    ```
    yc iam key create --service-account-name my-robot --output key.json
    ```

    Если вы получили ошибку `ERROR: service account with name "my-robot" not found`, значит в каталоге по умолчанию нет сервисного аккаунта с таким именем. Если имя правильное, то выполните одну из команд:
    * Укажите каталог с сервисным аккаунтом с помощью параметра `--folder-name` или `--folder-id`:
         ```
         yc iam key create --folder-name my-folder --service-account-name my-robot --output key.json
         ```
    * Укажите сервисный аккаунт по [идентификатору](../iam/operations/sa/get-id.md) с помощью параметра `--service-account-id`:
         ```
         yc iam key create --service-account-id b1gnbfd11bq5******** --output key.json
         ```
1. Создайте профиль, который будет использоваться для выполнения операций от имени сервисного аккаунта:
    ```
    yc config profile create my-robot-profile
    ```
1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта:
    ```
    yc config set service-account-key key.json
    ```