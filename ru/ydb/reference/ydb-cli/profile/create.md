# Создание профиля

В профиле {{ ydb-short-name }} CLI вы можете задать эндпоинт, полный путь к базе данных, а также способ авторизации пользователя, от имени которого будут выполняться команды. Заданные в профиле параметры можно не указывать при вызове команд {{ ydb-short-name }} CLI.

С помощью профилей можно быстро переключать контекст выполнения команд {{ ydb-short-name }} CLI. Для переключения на нужный профиль [активируйте](activate.md) его. Также указать профиль для выполнения команды можно с помощью глобального параметра `profile`.

Чтобы создать профиль с именем `example`:

{% note info %}

Если профиль с таким именем уже существует, вам будет предложено изменить его настройки.

{% endnote %}

1. Выполните команду:

    ```bash
    {{ ydb-cli }} config profile create example
    ```

1. Введите эндпоинт или не сохраняйте этот параметр для профиля:

    ```text
    Pick desired action to configure endpoint:
     [1] Set a new endpoint value
     [2] Don't save endpoint for profile "example"
    Please enter your numeric choice: 
    ```

1. Введите путь базы данных или не сохраняйте этот параметр для профиля:

    ```text
    Pick desired action to configure database:
     [1] Set a new database value
     [2] Don't save database for profile "example"
    Please enter your numeric choice: 
    ```

1. Выберите метод аутентификации или не сохраняйте этот параметр для профиля:

    ```text
    Pick desired action to configure authentication method:
     [1] Use IAM token (iam-token) cloud.yandex.ru/docs/iam/concepts/authorization/iam-token
     [2] Use OAuth token of a Yandex Passport user (yc-token) cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
     [3] Use metadata service on a virtual machine (use-metadata-credentials) cloud.yandex.ru/docs/compute/operations/vm-connect/auth-inside-vm
     [4] Use security account key file (sa-key-file) cloud.yandex.ru/docs/iam/operations/iam-token/create-for-sa
     [5] Don't save authentication data for profile "example"
    Please enter your numeric choice: 
    ```

1. Укажите, надо ли активировать создаваемый профиль как профиль по-умолчанию:

    ```text
    Activate profile "example" to use by default? (current active profile is not set) y/n:
    ```
