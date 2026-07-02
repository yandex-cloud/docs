[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Functions](../index.md) > [Концепции](index.md) > Резервное копирование

# Резервное копирование в Cloud Functions

Данные в сервисе Cloud Functions надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Вы можете получить:
* [списки функций](#function-list);
* [списки версий функций](#version-list);
* [информацию о версиях функций](#version-get);
* [списки триггеров](#trigger-list);
* [информацию о триггерах](#trigger-get).

## Получить список функций {#function-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список функций.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **Функции**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы получить список функций, выполните команду:

  ```bash
  yc serverless function list
  ```

  Результат:

  ```text
  +----------------------+--------------------+----------------------+--------+
  |          ID          |        NAME        |      FOLDER ID       | STATUS |
  +----------------------+--------------------+----------------------+--------+
  | b097d9ous3ge******** | my-beta-function   | aoek49ghmknn******** | ACTIVE |
  +----------------------+--------------------+----------------------+--------+
  ```

- API {#api}

  Чтобы получить список функций, воспользуйтесь методом REST API [list](../functions/api-ref/Function/list.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/List](../functions/api-ref/grpc/Function/list.md).


{% endlist %}

## Получить список версий функции {#version-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **Функции**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор функции, [получите](../operations/function/function-list.md) список функций в каталоге.

    Чтобы получить список версий функции, выполните команду:

    ```bash
    yc serverless function version list --function-name <имя_функции>
    ```

    Результат:

    ```text
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      |  RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    | b09u830mb1n3******** | b097d9ous3ge******** | python311 | test.handler | $latest | 2023-08-22 09:23:23 |
    | b09ch6pmpohf******** | b097d9ous3ge******** | python311 | test.handler | beta    | 2023-08-22 09:12:38 |
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    ```

- API {#api}

    Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../functions/api-ref/Function/listVersions.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../functions/api-ref/grpc/Function/listVersions.md).


{% endlist %}

## Получить информацию о версии функции {#version-get}

{% note warning %}

Резервного копирования кода функции нет. Рекомендуем сохранять его самостоятельно.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **Функции**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор версии функции, получите [список версий функции](../operations/function/version-list.md) в каталоге.

    Чтобы получить подробную информацию о версии функции:

    * по `ID`, выполните команду:
        ```
        yc serverless function version get <идентификатор_версии>
        ```
        Результат:
      
        ```
        id: b09u830mb1n3********
        function_id: b097d9ous3ge********
        created_at: "2023-08-22T09:23:23.383Z"
        runtime: python311
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac********
        ```

    * по `TAGS`, выполните команду:
        ```
        yc serverless function version get-by-tag --function-name <имя_функции> --tag <тег>
        ```
        Результат:
      
        ```
        id: b09ch6pmpohf********
        function_id: b097d9ous3ge********
        created_at: "2023-08-22T09:12:38.464Z"
        runtime: python311
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - beta
        log_group_id: eolv6578frac********
        ```

- API {#api}

    Чтобы получить подробную информацию о версии функции, воспользуйтесь методом REST API [getVersion](../functions/api-ref/Function/getVersion.md) для ресурса [Function](../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/GetVersion](../functions/api-ref/grpc/Function/getVersion.md).


{% endlist %}

## Получить список триггеров {#trigger-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список триггеров.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Получите список триггеров:

    ```bash
    yc serverless trigger list
    ```

    Результат:

    ```text
    +----------------------+------------+----------------------+
    |          ID          |    NAME    |      FOLDER ID       |
    +----------------------+------------+----------------------+
    | dd0gj5tsj2********** | my-trigger | aoek49ghmk********** |
    +----------------------+------------+----------------------+
    ```

- API {#api}

  Чтобы получить список триггеров, воспользуйтесь методом REST API [list](../triggers/api-ref/Trigger/list.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/List](../triggers/api-ref/grpc/Trigger/list.md).

{% endlist %}

## Получить информацию о триггере {#trigger-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **Cloud Functions**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор триггера, [получите](../operations/trigger/trigger-list.md) список триггеров в каталоге.

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1s9q2li6t**********
    folder_id: b1g9hv2loa**********
    created_at: "2023-08-01T12:36:14.321Z"
    name: my-trigger
    description: Trigger for uploaded objects
    rule:
      object_storage:
        event_type:
          - OBJECT_STORAGE_EVENT_TYPE_CREATE_OBJECT
        bucket_id: **********
        batch_settings:
          size: "10"
          cutoff: 10s
        invoke_function:
          function_id: d4e5muirrt**********
          function_tag: $latest
          service_account_id: ajek0fou8e**********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить подробную информацию о триггере, воспользуйтесь методом REST API [get](../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}