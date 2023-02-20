{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ serverless-containers-name }}**.
    1. Выберите контейнер, информацию о ревизии которого хотите получить.
    1. В разделе **Ревизии** будет показан список ревизий контейнера и подробная информация о них.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы узнать имя или уникальный идентификатор ревизии контейнера, [получите](../../serverless-containers/operations/revision-list.md) список ревизий контейнера в каталоге.

    Чтобы получить подробную информацию о ревизии контейнера, выполните команду:

    ```
    yc serverless container revision get <идентификатор_ревизии>
    ```
    Результат:
    ```
    id: bbaq84v92qqc********
    container_id: bbab5i36nvda********
    created_at: "2021-09-09T11:22:28.128Z"
    image:
      image_url: {{ registry }}/crpp35hht729********/ubuntu:test
      image_digest: sha256:9f05670784f562f278177e43a9ae0179f29b3cb93b2ef165b935f1**********
    resources:
      memory: "1207959552"
      cores: "1"
      core_fraction: "100"
    execution_timeout: 0s
    concurrency: "1"
    service_account_id: aje07l4q4vmo********
    status: ACTIVE
    ```

- API

  Получить информацию о ревизии контейнера можно с помощью метода API [getRevision](../../serverless-containers/containers/api-ref/Container/getRevision.md).


{% endlist %}