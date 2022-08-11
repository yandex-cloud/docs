# Подключение к БД с помощью {{ ydb-short-name }} CLI

{{ ydb-short-name }} CLI — инструмент для управления вашими данными в {{ ydb-full-name }} из командной строки. Вы можете использовать {{ ydb-short-name }} CLI для выполнения действий с БД на системах без графического интерфейса или для автоматизации задач с помощью скриптов.

Перед началом работы установите [{{ ydb-short-name }} CLI](https://ydb.tech/ru/docs/reference/ydb-cli/install). Для подключения к БД {{ ydb-full-name }} из {{ ydb-short-name }} CLI необходимо указать [эндпоинт и путь](#endpoint-and-path), а также [выбрать и настроить](#auth) режим аутентификации.

{% note warning %}

Для подключения к БД в Dedicated-режиме снаружи {{ yandex-cloud }} необходимо разрешить входящий и исходящий трафик по протоколу TCP на порте `2135`. Убедитесь, что в назначенной [группе безопасности](../../vpc/concepts/security-groups.md) есть соответствующее правило или добавьте его.

{% endnote %}

## Получите реквизиты для подключения {#endpoint-and-path}

Получить реквизиты для подключения к БД можно в консоли управления {{ yandex-cloud }} или с помощью интерфейса командной строки {{ yandex-cloud }}.

{% list tabs %}

- Консоль управления

  1. Перейдите в [консоль управления]({{ link-console-main }}).
  1. Выберите каталог с вашей БД и перейдите в сервис **{{ ydb-full-name }}**.
  1. Выберите базу данных, для которой нужно получить эндпоинт и путь.
      
      * Эндпоинт БД указан в блоке **Соединение** в строке **Эндпоинт**:

          >Например, эндпоинт для БД в режиме Serverless — `{{ ep-serverless }}`, для БД в режиме Dedicated — `{{ ep-dedicated }}`.
      * Путь БД указан блоке **Соединение** в строке **Размещение базы данных**.  
      
          >Пример пути БД: `{{ path-serverless }}`.

- YC CLI

  1. {% include [cli-install](../../_includes/cli-install.md) %}
  1. Получите список баз в каталоге:

      ```bash
      yc ydb database list
      ```

      Результат:

      ```text
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      |          ID          |      NAME      | DESCRIPTION |                                                           ENDPOINT                                                            |     CREATED AT      | STATUS  |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      | {{ id-serverless }} | {{ name-serverless }} |             | {{ ep-serverless }}/?database={{ path-serverless }}                  | 2022-05-29 21:10:35 | RUNNING |
      | {{ id-dedicated }} | {{ name-dedicated }}  |             | {{ ep-dedicated }}/?database={{ path-dedicated }} | 2022-05-31 10:10:12 | RUNNING |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      ```

      Реквизиты для подключения к БД указаны в колонке `ENDPOINT`.

      >Например, для БД в режиме Serverless:
      >* эндпоинт — `{{ ep-serverless }}`;
      >* путь — `{{ path-serverless }}`.
      >
      >Для БД в режиме Dedicated:
      >* эндпоинт — `{{ ep-dedicated }}`;
      >* путь — `{{ path-dedicated }}`.

{% endlist %}

## Настройте аутентификацию {#auth}

Выберите один из режимов аутентификации:

* [OAuth-токен](../../iam/concepts/authorization/oauth-token.md) — позволяет выполнять команды только от имени [аккаунта в {{ yandex-cloud }}](../../iam/concepts/index.md#passport). Время жизни токена 1 год. Режим не рекомендуется для продуктовых сред.
* [IAM-токен](../../iam/concepts/authorization/iam-token.md) — рекомендуется для выполнения разовых операций от имени [аккаунта в {{ yandex-cloud }}](../../iam/concepts/index.md#passport) или [федеративного аккаунта](../../iam/concepts/index.md#saml-federation). Время жизни токена не более 12 часов.
* [Авторизованный ключ доступа](../../iam/concepts/authorization/key.md) — рекомендуется для выполнения команд {{ ydb-short-name }} CLI снаружи {{ yandex-cloud }} от имени [сервисного аккаунта](../../iam/concepts/index#sa).
* [Сервис метаданных](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md) — наиболее безопасный и производительный режим. Применяется при выполнении команд на виртуальных машинах внутри {{ yandex-cloud }}. Также поддерживается сервисом [{{ sf-full-name }}](../../functions/index.yaml).

Настройте выбранный режим:

{% list tabs %}

- OAuth-токен

  Получите OAuth-токен с помощью [запроса]({{ link-cloud-oauth }}) и сохраните его в файл. При запуске команды {{ ydb-short-name }} CLI в параметре `--yc-token-file` укажите путь к файлу с вашим OAuth-токеном.

  Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение OAuth-токена в переменную окружения `YC_TOKEN` или [настройте профиль](https://ydb.tech/ru/docs/reference/ydb-cli/profile/create) {{ ydb-short-name }} CLI.

  Проверьте корректность подключения, запросив информацию о пользователе:

  ```bash
  {{ ydb-cli }} \
    --endpoint <эндпоинт> \
    --database <имя> \
    --yc-token-file <путь> \
    discovery whoami
  ```

  * `--endpoint` — эндпоинт БД.
  * `--database` — путь к БД.
  * `--yc-token-file` — путь к файлу с OAuth-токеном.

  >Пример команды:
  >
  >```bash
  >{{ ydb-cli }} \
  >  --endpoint {{ ep-serverless }} \
  >  --database {{ path-serverless }} \
  >  --yc-token-file oauth-token.txt \
  >  discovery whoami
  >```
  >
  >Результат:
  >
  >```text
  >User SID: aje6o75au36h5d0tnr8k@as
  >```

- IAM-токен

  1. С помощью [CLI {{ yandex-cloud }}](../../cli/index.yaml) получите IAM-токен:

      ```bash
      yc iam create-token
      ```

  1. Сохраните полученный токен в файл.
  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--iam-token-file` укажите путь к файлу с вашим IAM-токеном.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](https://ydb.tech/ru/docs/reference/ydb-cli/profile/create) {{ ydb-short-name }} CLI.
  1. Проверьте корректность подключения, запросив информацию о пользователе:

      ```bash
      {{ ydb-cli }} \
        --endpoint <эндпоинт> \
        --database <имя> \
        --iam-token-file <путь> \
        discovery whoami
      ```

      * `--endpoint` — эндпоинт БД.
      * `--database` — путь к БД.
      * `--iam-token-file` — путь к файлу с IAM-токеном.

      >Пример команды:
      >
      >```bash
      >{{ ydb-cli }} \
      >  --endpoint {{ ep-serverless }} \
      >  --database {{ path-serverless }} \
      >  --iam-token-file iam-token.txt \
      >  discovery whoami
      >```
      >
      >Результат:
      >
      >```text
      >User SID: aje6o75au36h5d0tnr8k@as
      >```

- Авторизованный ключ доступа

  1. {% include [cli-install](../../_includes/cli-install.md) %}
  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт для доступа к БД. Сервисный аккаунт должен располагаться в том же каталоге, что и БД и иметь роль `viewer` или `viewer` + `editor` в зависимости от того, какой доступ к БД необходим.
  1. С помощью [CLI {{ yandex-cloud }}](../../cli/index.yaml) создайте авторизованный ключ для сервисного аккаунта:

      ```bash
      yc iam key create \
        --service-account-name <имя> \
        --output <путь>
      ```

      * `--service-account-name` — имя сервисного аккаунта.
      * `--output` — путь к файлу с авторизованным ключом.

  1. При запуске команды {{ ydb-short-name }} CLI в параметре `--sa-key-file` укажите путь к файлу с авторизованным ключом доступа сервисного аккаунта.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](https://ydb.tech/ru/docs/reference/ydb-cli/profile/create) {{ ydb-short-name }} CLI.

  1. Проверьте корректность подключения, запросив информацию о пользователе:

      ```bash
      {{ ydb-cli }} \
        --endpoint <эндпоинт> \
        --database <имя> \
        --sa-key-file <путь>\
        discovery whoami
      ```

      * `--endpoint` — эндпоинт БД.
      * `--database` — путь к БД.
      * `--sa-key-file` — путь к файлу с закрытым ключом и идентификатором открытого ключа.

      Пример команды:

      >```bash
      >{{ ydb-cli }} \
      >  --endpoint {{ ep-serverless }} \
      >  --database {{ path-serverless }} \
      >  --sa-key-file sa-key-file.txt \
      >  discovery whoami
      >```
      >
      >Результата:
      >
      >```text
      >User SID: aje6o75au36h5d0tnr8k@as
      >```

- Сервис метаданных

  При запуске команды {{ ydb-short-name }} CLI из виртуальной машины в {{ yandex-cloud }} укажите параметр `--use-metadata-credentials`. {{ ydb-short-name }} CLI получит IAM-токен с помощью сервиса метаданных.

  Чтобы не указывать этот параметр при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](https://ydb.tech/ru/docs/reference/ydb-cli/profile/create) {{ ydb-short-name }} CLI.

  Проверьте корректность подключения, запросив информацию о пользователе:

  ```bash
  {{ ydb-cli }} \
    --endpoint <эндпоинт> \
    --database <имя> \
    --use-metadata-credentials \
    discovery whoami
  ```

  * `--endpoint` — эндпоинт БД.
  * `--database` — путь к БД.
  * `--use-metadata-credentials` — использовать сервис метаданных.

  >Пример команды:
  >
  >```bash
  >{{ ydb-cli }} \
  >  --endpoint {{ ep-serverless }} \
  >  --database {{ path-serverless }} \
  >  --use-metadata-credentials \
  >  discovery whoami
  >```
  >
  >Результат:
  >
  >```text
  >User SID: aje6o75au36h5d0tnr8k@as
  >```

{% endlist %}
