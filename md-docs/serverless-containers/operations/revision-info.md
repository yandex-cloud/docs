[Документация Yandex Cloud](../../index.md) > [Yandex Serverless Containers](../index.md) > [Пошаговые инструкции](index.md) > Получение информации о контейнере > Получить информацию о ревизии контейнера

# Получить информацию о ревизии контейнера

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится контейнер.
    1. Перейдите в сервис **Serverless Containers**.
    1. Выберите контейнер, информацию о ревизии которого хотите получить.
    1. В разделе **Ревизии** будет показан список ревизий контейнера и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор ревизии контейнера, [получите](revision-list.md) список ревизий контейнера в каталоге.

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