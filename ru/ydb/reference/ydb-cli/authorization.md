---
sourcePath: overlay/reference/ydb-cli/authorization.md
---
# Авторизация в YDB CLI

Для выполнения запросов к Yandex Database в Yandex.Cloud с помощью YDB CLI необходимо авторизоваться. Выберите один из доступных способов:

* Если вы работаете от имени [аккаунта на Яндексе](../../../iam/concepts/index.md#passport), авторизуйтесь с помощью [OAuth-токена](../../../iam/concepts/authorization/oauth-token.md).
* Если вы работаете от имени [федеративного аккаунта](../../../iam/concepts/index.md#saml-federation), авторизуйтесь с помощью [IAM-токена](../../../iam/concepts/authorization/iam-token.md).
* Для авторизации из [виртуальной машины](../../../compute/concepts/vm.md) используйте [сервис метаданных](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md).
* Если вы хотите выполнять команды от имени [сервисного аккаунта](../../../iam/concepts/index#sa), используйте [авторизованный ключ доступа](../../../iam/concepts/authorization/key.md).

{% list tabs %}

- OAuth-токен

  
  Получите OAuth-токен с помощью [запроса](https://oauth.yandex.ru/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) и сохраните его в файл. При запуске команды YDB CLI в параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш OAuth-токен.

  Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YC_TOKEN` или [настройте профиль](profile/create.md) YDB CLI.

  Проверьте корректность авторизации, запросив информацию о пользователе:

  ```bash
  ydb \
    --endpoint <эндпоинт> \
    --database <база_данных> \
    --yc-token-file <путь> \
    discovery whoami \
    --groups
  ```

  * `--endpoint` — эндпоинт БД.
  * `--database` — полный путь к БД.
  * `--yc-token-file` — путь к файлу с OAuth-токеном.
  * `--groups` — добавить в вывод список групп, в которых состоит пользователь.

  Пример команды:

  ```bash
  ydb \
    --endpoint ydb.serverless.yandexcloud.net:2135 \
    --database /ru-central1/b1gia87mbaomkfvscrup/etn02j1mlm4vgjhij03e \
    --yc-token-file oauth-token.txt \
    discovery whoami \
    --groups
  ```

  Пример результата:

  ```text
  User SID: aje6o75au36h5d0tnr8k@as

  User has no groups
  ```

- IAM-токен

  1. С помощью [CLI Yandex.Cloud](../../../cli/index.yaml) получите IAM-токен:

      ```bash
      yc iam create-token
      ```

  1. Сохраните полученный токен в файл.
  1. При запуске команды YDB CLI в параметре `--iam-token-file` укажите путь к файлу с вашим IAM-токеном.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](profile/create.md) YDB CLI.
  1. Проверьте корректность авторизации, запросив информацию о пользователе:

      ```bash
      ydb \
        --endpoint <эндпоинт> \
        --database <база_данных> \
        --iam-token-file <путь> \
        discovery whoami \
        --groups
      ```

      * `--endpoint` — эндпоинт БД.
      * `--database` — полный путь к БД.
      * `--iam-token-file` — путь файла с IAM-токеном.
      * `--groups` — добавить в вывод список групп, в которых состоит пользователь.

      Пример команды:

      ```bash
      ydb \
        --endpoint ydb.serverless.yandexcloud.net:2135 \
        --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
        --iam-token-file iam-token.txt \
        discovery whoami \
        --groups
      ```

      Пример результата:

      ```text
      User SID: aje6o75au36h5d0tnr8k@as

      User has no groups
      ```

  {% note alert %}

  [Время жизни](../../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена не более 12 часов.

  {% endnote %}

- Сервис метаданных

  При запуске команды YDB CLI из виртуальной машины в Yandex.Cloud укажите параметр `--use-metadata-credentials`. ydb получит IAM-токен с помощью сервиса метаданных.

  Чтобы не указывать этот параметр при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](profile/create.md) YDB CLI.

  Проверьте корректность авторизации, запросив информацию о пользователе:

  ```bash
  ydb \
    --endpoint <эндпоинт> \
    --database <база_данных> \
    --use-metadata-credentials \
    discovery whoami \
    --groups
  ```

  * `--endpoint` — эндпоинт БД.
  * `--database` — полный путь к БД.
  * `--use-metadata-credentials` — использовать сервис метаданных.
  * `--groups` — добавить в вывод список групп, в которых состоит пользователь.

  Пример команды:

  ```bash
  ydb \
    --endpoint ydb.serverless.yandexcloud.net:2135 \
    --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
    --use-metadata-credentials \
    discovery whoami \
    --groups
  ```

  Пример результата:

  ```text
  User SID: aje6o75au36h5d0tnr8k@as

  User has no groups
  ```

- Авторизованный ключ доступа

  1. С помощью [CLI Yandex.Cloud](../../../cli/index.yaml) создайте авторизованный ключ сервисного аккаунта:

      ```bash
      yc iam key create \
        --service-account-name <имя_сервисного_аккаунта> \
        --output <имя_файла>
      ```

      * `--service-account-name` — имя сервисного аккаунта.
      * `--output` — имя файла, в который будет сохранен авторизованный ключ.

  1. При запуске команды YDB CLI в параметре `--sa-key-file` укажите путь к файлу с авторизованным ключом доступа сервисного аккаунта.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](profile/create.md) YDB CLI.

  1. Проверьте корректность авторизации, запросив информацию о пользователе:

      ```bash
      ydb \
        --endpoint <эндпоинт> \
        --database <база данных> \
        --sa-key-file <путь к файлу с ключом>\
        discovery whoami \
        --groups
      ```

      * `--endpoint` — эндпоинт БД.
      * `--database` — полный путь к БД.
      * `--sa-key-file` — путь к файлу с закрытым ключом и идентификатором открытого ключа.
      * `--groups` — добавить в вывод список групп, в которых состоит пользователь.

      Пример команды:

      ```bash
      ydb \
        --endpoint ydb.serverless.yandexcloud.net:2135 \
        --database /ru-central1/b1gia87mbaomkfvsgrup/etn02j1mlm4vgjhig16t \
        --sa-key-file sa-key-file.txt \
        discovery whoami \
        --groups
      ```

      Пример результата:

      ```text
      User SID: aje6o75au36h5d0tnr8k@as

      User has no groups
      ```

{% endlist %}
