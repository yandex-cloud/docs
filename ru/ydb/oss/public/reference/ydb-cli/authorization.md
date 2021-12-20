# Авторизация в {{ ydb-short-name }} CLI

Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }} с помощью {{ ydb-short-name }} CLI необходимо авторизоваться. Выберите один из доступных способов:

* Если вы работаете от имени {% if audience == "external" %}[аккаунта на Яндексе](../../../../../iam/concepts/index.md#passport){% else %}аккаунта на Яндексе{% endif %}, авторизуйтесь с помощью {% if audience == "external" %}[OAuth-токена](../../../../../iam/concepts/authorization/oauth-token.md){% else %}OAuth-токена{% endif %}.
* Если вы работаете от имени {% if audience == "external" %}[федеративного аккаунта](../../../../../iam/concepts/index.md#saml-federation){% else %}федеративного аккаунта{% endif %}, авторизуйтесь с помощью {% if audience == "external" %}[IAM-токена](../../../../../iam/concepts/authorization/iam-token.md){% else %}IAM-токена{% endif %}.
* Для авторизации из {% if audience == "external" %}[виртуальной машины](../../../../../compute/concepts/vm.md){% else %}виртуальной машины{% endif %} используйте {% if audience == "external" %}[сервис метаданных](../../../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md){% else %}сервис метаданных{% endif %}.
* Если вы хотите выполнять команды от имени {% if audience == "external" %}[сервисного аккаунта](../../../../../iam/concepts/index#sa){% else %}сервисного аккаунта{% endif %}, используйте {% if audience == "external" %}[авторизованный ключ доступа](../../../../../iam/concepts/authorization/key.md){% else %}авторизованный ключ доступа{% endif %}.

{% list tabs %}

- OAuth-токен

  {% if audience == "external" %}

  Получите OAuth-токен с помощью [запроса]({{ link-cloud-oauth }}) и сохраните его в файл. При запуске команды {{ ydb-short-name }} CLI в параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш OAuth-токен.

  Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YC_TOKEN` или [настройте профиль](profile/create.md) {{ ydb-short-name }} CLI.

  Проверьте корректность авторизации, запросив информацию о пользователе:

  ```bash
  {{ ydb-cli }} \
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
  {{ ydb-cli }} \
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

  {% else %}

  Получите [OAuth-токен](../../../../getting_started/start_auth.md) для аутентификации и сохраните его в файл. При запуске команды {{ ydb-short-name }} CLI в параметре `--token-file` укажите путь к файлу, в котором содержится ваш OAuth-токен.

  Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YDB_TOKEN` или сохраните токен в файл по умолчанию `~/.ydb/token`.

  Проверьте корректность авторизации, запросив информацию о пользователе:

  ```bash
  {{ ydb-cli }} \
    --endpoint ydb-ru.yandex.net:2135 \
    --database /ru/tutorial/home/testdb \
    --token-file ~/my_token \
    discovery whoami \
    --groups
  ```

  {% endif %}

- IAM-токен

  1. С помощью {% if audience == "external" %}[CLI {{ yandex-cloud }}](../../../../../cli/index.yaml){% else %}CLI {{ yandex-cloud }}{% endif %} получите IAM-токен:

      ```bash
      yc iam create-token
      ```

  1. Сохраните полученный токен в файл.
  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--iam-token-file` укажите путь к файлу с вашим IAM-токеном.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](profile/create.md) {{ ydb-short-name }} CLI.
  1. Проверьте корректность авторизации, запросив информацию о пользователе:

      ```bash
      {{ ydb-cli }} \
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
      {{ ydb-cli }} \
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

  {% if audience == "external" %}[Время жизни](../../../../../iam/concepts/authorization/iam-token.md#lifetime){% else %}Время жизни{% endif %} IAM-токена не более 12 часов.

  {% endnote %}

- Сервис метаданных

  При запуске команды {{ ydb-short-name }} CLI из виртуальной машины в {{ yandex-cloud }} укажите параметр `--use-metadata-credentials`. {{ ydb-cli }} получит IAM-токен с помощью сервиса метаданных.

  Чтобы не указывать этот параметр при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](profile/create.md) {{ ydb-short-name }} CLI.

  Проверьте корректность авторизации, запросив информацию о пользователе:

  ```bash
  {{ ydb-cli }} \
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
  {{ ydb-cli }} \
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

  1. С помощью {% if audience == "external" %}[CLI {{ yandex-cloud }}](../../../../../cli/index.yaml){% else %}CLI {{ yandex-cloud }}{% endif %} создайте авторизованный ключ сервисного аккаунта:

      ```bash
      yc iam key create \
        --service-account-name <имя_сервисного_аккаунта> \
        --output <имя_файла>
      ```

      * `--service-account-name` — имя сервисного аккаунта.
      * `--output` — имя файла, в который будет сохранен авторизованный ключ.

  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--sa-key-file` укажите путь к файлу с авторизованным ключом доступа сервисного аккаунта.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](profile/create.md) {{ ydb-short-name }} CLI.

  1. Проверьте корректность авторизации, запросив информацию о пользователе:

      ```bash
      {{ ydb-cli }} \
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
      {{ ydb-cli }} \
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
