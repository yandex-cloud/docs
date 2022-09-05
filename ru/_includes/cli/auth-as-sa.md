Чтобы аутентифицироваться от имени сервисного аккаунта:

1. Получите список сервисных аккаунтов, которые существуют в вашем облаке:

    ```bash
    yc iam service-account --folder-id <ID_каталога> list
    ```

    Результат:
    ```bash
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
    ```bash
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
       
{% if product == "cloud-il" %}
1. Добавьте в профиль CLI доменное имя и порт для запросов к {{ yandex-cloud }}:

   ```bash
   yc config set endpoint {{ api-host }}:443
   ```   
{% endif %}

1. Проверьте, что параметры для сервисного аккаунта добавлены верно:

   {% if product == "yandex-cloud" %}
   
    ```bash
    yc config list
    ```
    
    Результат:

    ```bash
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
   
   {% endif %}
   
   {% if product == "cloud-il" %}

    ```bash
    yc config list
    ```
    
    Результат:
    ```bash
    endpoint: {{ api-host }}:443
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

   {% endif %}
   
1. Настройте профиль для запуска команд.

    {% include [add-folder](../cli-add-folder.md) %}
