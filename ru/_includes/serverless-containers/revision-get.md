{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится контейнер.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.
    1. Выберите контейнер, информацию о ревизии которого хотите получить.
    1. В разделе **{{ ui-key.yacloud.serverless-containers.section-revisions }}** будет показан список ревизий контейнера и подробная информация о них.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    {% include [get-revision-list](../../_includes/serverless-containers/get-revision-list.md) %}

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

- API {#api}

  Чтобы получить информацию о ревизии контейнера, воспользуйтесь методом REST API [getRevision](../../serverless-containers/containers/api-ref/Container/getRevision.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/GetRevision](../../serverless-containers/containers/api-ref/grpc/container_service.md#GetRevision).

{% endlist %}