Настройте CLI для работы от имени сервисного аккаунта:

1. {% include [cli-install](cli-install.md) %}
1. Создайте авторизованный ключ для вашего сервисного аккаунта и запишите его файл. Сервисный аккаунт укажите с помощью опции `--service-account-name` или `--service-account-id`:
    ```
    yc iam key create --service-account-name my-robot --output key.json
    ```
1. Создайте профиль, который будет использоваться для выполнения операций от имени сервисного аккаунта:
    ```
    yc config profile create my-robot-profile
    ```
1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта:
    ```
    yc config set service-account-key key.json
    ```