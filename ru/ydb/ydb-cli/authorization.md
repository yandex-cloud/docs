---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Авторизация в {{ ydb-short-name }} CLI

Для выполнения запросов к {{ ydb-full-name }} в {{ yandex-cloud }} с помощью {{ ydb-short-name }} CLI необходимо авторизоваться. Выберите один из доступных способов:

* Если вы работает от имени [аккаунта на Яндексе](../../iam/concepts/index.md#passport), авторизуйтесь с помощью [OAuth-токена](../../iam/concepts/authorization/oauth-token.md).
* Если вы работает от имени [федеративного аккаунта](../../iam/concepts/index.md#saml-federation), авторизуйтесь с помощью [IAM-токена](../../iam/concepts/authorization/iam-token.md).
* Для авторизации из [виртуальной машины](../../compute/concepts/vm.md) используйте [сервис метаданных](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md).
* Если вы хотите выполнять команды от имени [сервисного аккаунта](../../iam/concepts/index#sa), используйте [авторизованный ключ доступа](../../iam/concepts/authorization/key.md).

{% list tabs %}

- OAuth-токен

  Получите OAuth-токен с помощью [запроса]({{ link-cloud-oauth }}) и сохраните его в файл. При запуске команды {{ ydb-short-name }} CLI в параметре `--yc-token-file` укажите путь к файлу, в котором содержится ваш OAuth-токен.

  Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YC_TOKEN` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

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
  * `--database` — полный путь БД.
  * `--yc-token-file` — путь файла с OAuth-токеном.
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

- IAM-токен

  1. С помощью [CLI {{ yandex-cloud }}](../../cli/index.yaml) получите IAM-токен:

      ```bash
      yc iam create-token
      ```

  1. Сохраните полученный токен в файл.
  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--iam-token-file` укажите путь к файлу с вашим IAM-токеном.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.
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
      * `--database` — полный путь БД.
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

  [Время жизни](../../iam/concepts/authorization/iam-token.md#lifetime) IAM-токена не более 12 часов.

  {% endnote %}

- Сервис метаданных

  При запуске команды {{ ydb-short-name }} CLI из виртуальной машины в {{ yandex-cloud }} укажите параметр `--use-metadata-credentials`, и {{ ydb-cli }} получит IAM-токен с помощью сервиса метаданных.

  Чтобы не указывать этот параметр при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

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
  * `--database` — полный путь БД.
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

  1. С помощью [CLI {{ yandex-cloud }}](../../cli/index.yaml) создайте авторизованный ключ сервисного аккаунта:

      ```bash
      yc iam key create --service-account-name <имя> -o <путь>
      ```

      `--service-account-name` — сервисного аккаунта;
      `-o` — путь и имя файла, в который будет сохранен авторизованный ключ.

  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--sa-key-file` укажите путь к файлу с авторизованным ключом доступа сервисного аккаунта.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](../ydb-cli/profile/create.md) {{ ydb-short-name }} CLI.

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
      * `--database` — полный путь БД.
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
