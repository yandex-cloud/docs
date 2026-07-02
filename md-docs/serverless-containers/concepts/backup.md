[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Концепции](index.md) > Резервное копирование

# Резервное копирование в Serverless Containers

Данные в сервисе Serverless Containers надежно хранятся и реплицируются в инфраструктуре Yandex Cloud. Вы можете получить:
* [списки контейнеров](#containers-list);
* [списки ревизий контейнеров](#revision-list);
* [информацию о ревизиях контейнеров](#revision-get);
* [списки триггеров](#trigger-list);
* [информацию о триггерах](#trigger-get).

О резервном копировании [Docker-образов](../../container-registry/concepts/docker-image.md), которые используются для создания ревизий контейнеров, читайте в [документации Yandex Container Registry](../../container-registry/concepts/backup.md).

## Получить список контейнеров {#containers-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список контейнеров.
    1. Перейдите в сервис **Serverless Containers**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы получить список контейнеров, выполните команду:

    ```bash
    yc serverless container list
    ```

    Результат:

    ```text
    +----------------------+--------------------+-----------------------+--------+
    |          ID          |        NAME        |      FOLDER ID        | STATUS |
    +----------------------+--------------------+-----------------------+--------+
    | b097d9ous3ge******** | my-beta-container   | aoek49ghmknn******** | ACTIVE |
    +----------------------+--------------------+-----------------------+--------+
    ```

- API {#api}

  Чтобы посмотреть список контейнеров, воспользуйтесь методом REST API [list](../containers/api-ref/Container/list.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/List](../containers/api-ref/grpc/Container/list.md).

{% endlist %}

## Получить список ревизий контейнера {#revision-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер, для которого хотите получить список ревизий.
    1. В разделе **Ревизии** будет показан список ревизий контейнера и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор контейнера, [получите](../operations/list.md) список контейнеров в каталоге.

    Чтобы получить список ревизий контейнера, выполните команду:

    ```bash
    yc serverless container revision list --container-name <имя_контейнера>
    ```

    Результат:

    ```text
    +----------------------+----------------------+--------------------------------------------+---------------------+
    |          ID          |     CONTAINER ID     |                   IMAGE                    |     CREATED AT      |
    +----------------------+----------------------+--------------------------------------------+---------------------+
    | bbaq84v92qqc******** | bbab5i36nvda******** | cr.yandex/crpp35hht729********/ubuntu:test | 2021-09-09 11:22:28 |
    | bba5eosk5sod******** | bbab5i36nvda******** | cr.yandex/crpp35hht729********/ubuntu:test | 2021-09-09 10:13:04 |
    +----------------------+----------------------+--------------------------------------------+---------------------+
    ```

- API {#api}

  Чтобы получить список ревизий контейнера, воспользуйтесь методом REST API [listRevisions](../containers/api-ref/Container/listRevisions.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/ListRevisions](../containers/api-ref/grpc/Container/listRevisions.md).

{% endlist %}

## Получить информацию о ревизии контейнера {#revision-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер, информацию о ревизии которого хотите получить.
    1. В разделе **Ревизии** будет показан список ревизий контейнера и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор ревизии контейнера, [получите](../operations/revision-list.md) список ревизий контейнера в каталоге.

    Чтобы получить подробную информацию о ревизии контейнера, выполните команду:

    ```bash
    yc serverless container revision get <идентификатор_ревизии>
    ```
    Результат:
    ```text
    id: bbaq84v92qqc********
    container_id: bbab5i36nvda********
    created_at: "2021-09-09T11:22:28.128Z"
    image:
      image_url: cr.yandex/crpp35hht729********/ubuntu:test
      image_digest: sha256:9f05670784f562f278177e43a9ae0179f29b3cb93b2ef165b935f1k9********
    resources:
      memory: "1207959552"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 0s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить информацию о ревизии контейнера, воспользуйтесь методом REST API [getRevision](../containers/api-ref/Container/getRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/GetRevision](../containers/api-ref/grpc/Container/getRevision.md).

{% endlist %}

## Получить список триггеров {#trigger-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором хотите посмотреть список триггеров.
    1. Перейдите в сервис **Serverless Containers**.
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
    | dd0gj5tsj2p3******** | my-trigger | aoek49ghmki7******** |
    +----------------------+------------+----------------------+
    ```

- API {#api}

  Чтобы получить список триггеров, воспользуйтесь методом REST API [list](../triggers/api-ref/Trigger/list.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/List](../triggers/api-ref/grpc/Trigger/list.md).

{% endlist %}

## Получить информацию о триггере {#trigger-get}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится триггер.
  1. Перейдите в сервис **Serverless Containers**.
  1. На панели слева выберите ![image](../../_assets/console-icons/gear-play.svg) **Триггеры**.
  1. Выберите триггер, о котором хотите получить подробную информацию.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Получите подробную информацию о триггере:

    ```bash
    yc serverless trigger get <имя_триггера>
    ```

    Результат:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflrih2********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    description: My trigger for mail.
    rule:
      mail:
        email: a1smdtklemh2********-xivn****@serverless.yandexcloud.net
        invoke_container:
          container_id: bba5jb38o8h2********
          service_account_id: aje03adgd2h2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:ru-central1:b1gmit33ngh2********:dlq
            service-account-id: aje3lebfemh2********
    status: ACTIVE
    ```

- API {#api}

  Чтобы получить информацию о триггере, воспользуйтесь методом REST API [get](../triggers/api-ref/Trigger/get.md) для ресурса [Trigger](../triggers/api-ref/Trigger/index.md) или вызовом gRPC API [TriggerService/Get](../triggers/api-ref/grpc/Trigger/get.md).

{% endlist %}