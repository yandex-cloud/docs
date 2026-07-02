[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Управление контейнером > Масштабировать контейнер > Удалить настройки масштабирования

# Удалить настройки масштабирования контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер.
    1. Перейдите на вкладку **Редактор**.
    1. В блоке **Настройки** укажите:
       * **Количество подготовленных экземпляров** — `0`.
       * **Количество экземпляров контейнера в зоне доступности** — `0`.
       * **Количество одновременно выполняемых вызовов контейнера в зоне доступности** — `0`.
    1. Нажмите кнопку **Создать ревизию**.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы удалить настройки масштабирования, создайте новую ревизию контейнера, не указывая настройки масштабирования:

    ```bash
    yc serverless container revision deploy \
      --container-id <идентификатор_контейнера> \
      --image <URL_Docker-образа> \
      --service-account-id <идентификатор_сервисного_аккаунта>
    ```

    Где:
    * `--container-id` — идентификатор контейнера. Чтобы узнать идентификатор, [получите](list.md) список контейнеров.
    * `--image` — URL [Docker-образа](../../container-registry/concepts/docker-image.md).
    * `--service-account-id` — [идентификатор сервисного аккаунта](../../iam/operations/sa/get-id.md), у которого есть права на скачивание образа.

    Результат:

    ```
    done (2s)
    id: bbam2cv903iv********
    container_id: bbab5i36nvda********
    created_at: "2026-04-01T13:31:11.459Z"
    image:
      image_url: cr.yandex/crpp35hht729********/ubuntu:hello
      image_digest: sha256:f6f34c6cf5f56e594e9828274592f1cc4d9383b1689057ccaf188d41********
    resources:
      memory: "134217728"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 3s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    log_options:
      folder_id: b1gc1t4cb638********
    runtime:
      http: {}
    metadata_options: {}
    ```

    Более подробную информацию о команде смотрите в [справочнике CLI](../../cli/cli-ref/serverless/cli-ref/container/revision/deploy.md).

- API {#api}

  Чтобы удалить настройки масштабирования контейнера, воспользуйтесь методом REST API [deployRevision](../containers/api-ref/Container/deployRevision.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/DeployRevision](../containers/api-ref/grpc/Container/deployRevision.md).

{% endlist %}

## Полезные ссылки

* [Масштабирование контейнера](../concepts/container.md#scaling)