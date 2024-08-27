Чтобы аутентифицироваться от имени сервисного аккаунта:

1. Получите список сервисных аккаунтов, которые существуют в вашем облаке:

    ```bash
    yc iam service-account --folder-id <ID_каталога> list
    ```

    Результат:
    ```text
    +----------------------+------------+
    |          ID          |    NAME    |
    +----------------------+------------+
    | aje3932acd0c5ur7dagp | default-sa |
    +----------------------+------------+
    ```
1. Создайте авторизованный ключ для сервисного аккаунта и сохраните его в файл `key.json`:

    ```bash
    yc iam key create --service-account-name default-sa --output key.json --folder-id <ID_каталога>
    ```
    
    Результат:
    ```text
    id: aje83v701b1un777sh40
    service_account_id: aje3932acd0c5ur7dagp
    created_at: "2019-08-26T12:31:25Z"
    key_algorithm: RSA_2048
    ```

1. Добавьте авторизованный ключ сервисного аккаунта в профиль CLI.

    1. Создайте новый профиль CLI:

        ```bash
        yc config profile create sa-profile
        ```
    1. Добавьте авторизованный ключ:

        ```bash
        yc config set service-account-key key.json
        ```
       

1. Проверьте, что параметры для сервисного аккаунта добавлены верно:

      
    ```bash
    yc config list
    ```
    
    Результат:

    ```text
    service-account-key:
      id: aje83v701b1un777sh40
      service_account_id: aje3932acd0c5ur7dagp
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
