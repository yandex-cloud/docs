Настройте CLI для работы от имени сервисного аккаунта:

1. {% include [cli-install](cli-install.md) %}
1. {% include [default-catalogue](default-catalogue.md) %}
1. Получите список доступных сервисных аккаунтов в каталоге по умолчанию:

    ```bash
    yc iam service-accounts list
    ```

    Результат:

    ```bash
    +----------------------+----------+--------+
    |          ID          |   NAME   | LABELS |
    +----------------------+----------+--------+
    | ajeb9l33h6mu******** | my-robot |        |
    +----------------------+----------+--------+
    ```

1. Создайте [авторизованный ключ](../iam/concepts/authorization/key.md) для вашего сервисного аккаунта и запишите его в файл:

    ```bash
    yc iam key create --output <путь_к_файлу_ключа> --service-account-name <имя_сервисного_аккаунта>
    ```

    Где:

    * `--output` — путь к файлу для записи авторизованного ключа в формате JSON. Обязательный параметр.
    * `--service-account-name` — имя сервисного аккаунта.

     Например:

     ```bash
     yc iam key create --output key.json --service-account-name my-service-account
     ```

     Результат:

     ```bash
     id: aje4lue48687********
     service_account_id: ajeb9l33h6m********
     created_at: "2024-08-01T11:58:52.313177213Z"
     key_algorithm: RSA_2048
     ```

    Подробнее о команде `yc iam key create` см. в [справочнике CLI](../cli/cli-ref/managed-services/iam/service-account/create.md).

1. Создайте профиль, который будет использоваться для выполнения операций от имени сервисного аккаунта:

    ```bash
    yc config profile create <имя_профиля>
    ```

1. Укажите в конфигурации профиля авторизованный ключ сервисного аккаунта:

    ```bash
    yc config set service-account-key <путь_к_файлу_ключа>
    ```