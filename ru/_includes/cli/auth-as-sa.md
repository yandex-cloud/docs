1. {% include [list-sas](./list-sas.md) %}
1. Создайте авторизованный ключ для сервисного аккаунта и сохраните его в файл `key.json`:

    ```bash
    yc iam key create \
      --service-account-name default-sa \
      --output key.json \
      --folder-id <идентификатор_каталога>
    ```

    Где:
    * `--service-account-name` — имя сервисного аккаунта, полученное ранее.
    * `--output` — имя файла, в котором будет сохранен авторизованный ключ.
    * `--folder-id` — идентификатор каталога с сервисным аккаунтом.

    Результат:

    ```text
    id: aje83v701b1u********
    service_account_id: aje3932acd0c********
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```

1. Если вы создали авторизованный ключ на локальной машине и хотите использовать его для аутентификации в CLI на ВМ, предварительно [скопируйте его по SCP](../../compute/operations/vm-connect/scp-sftp.md#scp).
1. Добавьте авторизованный ключ сервисного аккаунта в профиль CLI.

    1. Создайте новый профиль CLI:

        ```bash
        yc config profile create sa-profile
        ```

    1. Добавьте авторизованный ключ:

        ```bash
        yc config set service-account-key key.json
        ```

1. Убедитесь, что параметры для сервисного аккаунта добавлены верно:

    ```bash
    yc config list
    ```
    
    Результат:

    ```text
    service-account-key:
      id: aje83v701b1u********
      service_account_id: aje3932acd0c********
      created_at: "2019-08-26T12:31:25Z"
      key_algorithm: RSA_2048
      public_key: |
        -----BEGIN PUBLIC KEY-----
        MIIBIjANBg...
        -----END PUBLIC KEY-----
      private_key: |
        -----BEGIN PRIVATE KEY-----
        MIIEvwIBAD...
        -----END PRIVATE KEY-----
    ```

1. Настройте профиль для запуска команд.

    {% include [add-folder](../cli-add-folder.md) %}
