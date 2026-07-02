[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for YDB](../index.md) > [Пошаговые инструкции](index.md) > Подключение к БД с помощью YDB CLI

# Подключение к БД с помощью YDB CLI

YDB CLI — инструмент для управления вашими данными в Yandex Managed Service for YDB из командной строки. Вы можете использовать YDB CLI для выполнения действий с БД на системах без графического интерфейса или для автоматизации задач с помощью скриптов.

Перед началом работы установите [YDB CLI](https://ydb.tech/docs/ru//reference/ydb-cli/install). Для подключения к БД Yandex Managed Service for YDB из YDB CLI необходимо указать [эндпоинт и путь](#endpoint-and-path), а также [выбрать и настроить](#auth) режим аутентификации.

## Настройка групп безопасности {#configuring-security-groups}

Для подключения к БД в Dedicated-режиме нужно разрешить входящий и исходящий трафик по протоколу TCP на порте `2135`. Убедитесь, что в назначенной [группе безопасности](../../vpc/concepts/security-groups.md) есть соответствующее правило, или добавьте его:

* **Диапазон портов** — `2135`.
* **Протокол** — `TCP`.
* **Источник** — `CIDR`.
* **CIDR блоки** — `0.0.0.0/0`.

## Получите реквизиты для подключения {#endpoint-and-path}

Чтобы получить реквизиты для подключения к БД:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в [консоль управления](https://console.yandex.cloud) и выберите каталог с вашей БД.
  1. Перейдите в сервис **Managed Service for&nbsp;YDB**.
  1. Выберите базу данных, для которой нужно получить эндпоинт и путь.
      
      * Эндпоинт БД указан в блоке **Соединение** в первой части значения поля **Эндпоинт** (часть до вхождения `/?database=`):

          >Например, эндпоинт для БД в режиме Serverless — `grpcs://ydb.serverless.yandexcloud.net:2135`, для БД в режиме Dedicated — `grpcs://lb.etnk1u65e4sh********.ydb.mdb.yandexcloud.net:2135`.
      * Путь БД указан в блоке **Соединение** во второй части значения поля **Эндпоинт** (часть после вхождения `/?database=`).
      
          >Пример пути БД: `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.

- Yandex Cloud CLI {#cli}

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  1. Получите список баз в каталоге:

      ```bash
      yc ydb database list
      ```

      Результат:

      ```text
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      |          ID          |      NAME      | DESCRIPTION |                                                           ENDPOINT                                                            |     CREATED AT      | STATUS  |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      | etnudu2n9ri3******** | ydb-serverless |             | grpcs://ydb.serverless.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etnudu2n9ri3********                  | 2022-05-29 21:10:35 | RUNNING |
      | etnk1u65e4sh******** | ydb-dedicated  |             | grpcs://lb.etnk1u65e4sh********.ydb.mdb.yandexcloud.net:2135/?database=/ru-central1/b1gia87mbaom********/etnk1u65e4sh******** | 2022-05-31 10:10:12 | RUNNING |
      +----------------------+----------------+-------------+-------------------------------------------------------------------------------------------------------------------------------+---------------------+---------+
      ```

      Реквизиты для подключения к БД указаны в колонке `ENDPOINT`.

      >Например, для БД в режиме Serverless:
      >* эндпоинт — `grpcs://ydb.serverless.yandexcloud.net:2135`;
      >* путь — `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.
      >
      >Для БД в режиме Dedicated:
      >* эндпоинт — `grpcs://lb.etnk1u65e4sh********.ydb.mdb.yandexcloud.net:2135`;
      >* путь — `/ru-central1/b1gia87mbaom********/etnk1u65e4sh********`.

- API {#api}

  Воспользуйтесь методом REST API [get](../api-ref/Database/get.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Get](../api-ref/grpc/Database/get.md) и передайте в запросе идентификатор требуемой БД в параметре `databaseId`.

  Реквизиты для подключения к БД указаны в параметре `endpoint`.

  >Например, для БД в режиме Serverless:
  >* эндпоинт — `grpcs://ydb.serverless.yandexcloud.net:2135`;
  >* путь — `/ru-central1/b1gia87mbaom********/etnudu2n9ri3********`.
  >
  >Для БД в режиме Dedicated:
  >* эндпоинт — `grpcs://lb.etnk1u65e4sh********.ydb.mdb.yandexcloud.net:2135`;
  >* путь — `/ru-central1/b1gia87mbaom********/etnk1u65e4sh********`.

  Идентификатор БД можно получить со [списком БД](manage-databases.md#list-db).

{% endlist %}

## Настройте аутентификацию {#auth}

Выберите один из режимов аутентификации:

* [IAM-токен](../../iam/concepts/authorization/iam-token.md) — рекомендуется для выполнения разовых операций от имени [аккаунта в Yandex Cloud](../../iam/concepts/users/accounts.md#passport) или [федеративного аккаунта](../../iam/concepts/users/accounts.md#saml-federation). Время жизни токена не более 12 часов.
* [Авторизованный ключ доступа](../../iam/concepts/authorization/key.md) — рекомендуется для выполнения команд YDB CLI снаружи Yandex Cloud от имени [сервисного аккаунта](../../iam/concepts/index.md#sa).
* [Сервис метаданных](../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm.md) — наиболее безопасный и производительный режим. Применяется при выполнении команд на виртуальных машинах внутри Yandex Cloud. Также поддерживается сервисом [Yandex Cloud Functions](../../functions/index.md).

Настройте выбранный режим:

{% list tabs %}

- IAM-токен

  1. С помощью [Yandex Cloud CLI](../../cli/index.md) получите IAM-токен:

      ```bash
      yc iam create-token
      ```

  1. Сохраните полученный токен в файл.
  1. При запуске команды YDB CLI в параметре `--iam-token-file` укажите путь к файлу с вашим IAM-токеном.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните значение IAM-токена в переменную окружения `IAM_TOKEN` или [настройте профиль](https://ydb.tech/docs/ru//reference/ydb-cli/profile/create) YDB CLI.
  1. Проверьте корректность подключения, запросив информацию о пользователе:

      ```bash
      ydb \
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
      >ydb \
      >  --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
      >  --database /ru-central1/b1gia87mbaom********/etnudu2n9ri3******** \
      >  --iam-token-file iam-token.txt \
      >  discovery whoami
      >```
      >
      >Результат:
      >
      >```text
      >User SID: aje6o75au36h********@as
      >```

- Авторизованный ключ доступа

  1. Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).
  1. [Создайте](../../iam/operations/sa/create.md) сервисный аккаунт для доступа к БД. Сервисный аккаунт должен располагаться в том же каталоге, что и БД и иметь роль `viewer` или `viewer` + `editor` в зависимости от того, какой доступ к БД необходим.
  1. С помощью [Yandex Cloud CLI](../../cli/index.md) создайте авторизованный ключ для сервисного аккаунта:

      ```bash
      yc iam key create \
        --service-account-name <имя> \
        --output <путь>
      ```

      * `--service-account-name` — имя сервисного аккаунта.
      * `--output` — путь к файлу с авторизованным ключом.

  1. При запуске команды YDB CLI в параметре `--sa-key-file` укажите путь к файлу с авторизованным ключом доступа сервисного аккаунта.

      Чтобы не указывать этот параметр при каждом вызове команды, сохраните путь к файлу в переменную окружения `SA_KEY_FILE` или [настройте профиль](https://ydb.tech/docs/ru//reference/ydb-cli/profile/create) YDB CLI.

  1. Проверьте корректность подключения, запросив информацию о пользователе:

      ```bash
      ydb \
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
      >ydb \
      >  --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
      >  --database /ru-central1/b1gia87mbaom********/etnudu2n9ri3******** \
      >  --sa-key-file sa-key-file.txt \
      >  discovery whoami
      >```
      >
      >Результата:
      >
      >```text
      >User SID: aje6o75au36h********@as
      >```

- Сервис метаданных

  При запуске команды YDB CLI из виртуальной машины в Yandex Cloud укажите параметр `--use-metadata-credentials`. YDB CLI получит IAM-токен с помощью сервиса метаданных.

  Чтобы не указывать этот параметр при каждом вызове команды, установите значение переменной окружения `USE_METADATA_CREDENTIALS` в  `1` или [настройте профиль](https://ydb.tech/docs/ru//reference/ydb-cli/profile/create) YDB CLI.

  Проверьте корректность подключения, запросив информацию о пользователе:

  ```bash
  ydb \
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
  >ydb \
  >  --endpoint grpcs://ydb.serverless.yandexcloud.net:2135 \
  >  --database /ru-central1/b1gia87mbaom********/etnudu2n9ri3******** \
  >  --use-metadata-credentials \
  >  discovery whoami
  >```
  >
  >Результат:
  >
  >```text
  >User SID: aje6o75au36h********@as
  >```

{% endlist %}