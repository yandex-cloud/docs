{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите посмотреть список контейнеров.
    1. Выберите сервис **{{ serverless-containers-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы получить список контейнеров, выполните команду:

    ```
    yc serverless container list
    ```

    Результат:

    ```
    +----------------------+--------------------+-----------------------+--------+
    |          ID          |        NAME        |      FOLDER ID        | STATUS |
    +----------------------+--------------------+-----------------------+--------+
    | b097d9ous3ge******** | my-beta-container   | aoek49ghmknn******** | ACTIVE |
    +----------------------+--------------------+-----------------------+--------+
    ```

- API

  Чтобы посмотреть список контейнеров, воспользуйтесь методом REST API [list](../../serverless-containers/containers/api-ref/Container/list.md) для ресурса [Container](../../serverless-containers/containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/List](../../serverless-containers/containers/api-ref/grpc/container_service.md#List).

{% endlist %}
