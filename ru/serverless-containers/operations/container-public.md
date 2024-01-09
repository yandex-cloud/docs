# Сделать контейнер публичным

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, сделайте контейнер публичным.

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}
    
    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы сделать контейнер публичным, выполните команду:

    ```
    yc serverless container allow-unauthenticated-invoke <имя_контейнера>
    ```

    Результат:

    ```
    done (1s)
    ```

- API {#api}

  Чтобы сделать контейнер публичным, воспользуйтесь методом REST API [setAccessBindings](../containers/api-ref/Container/setAccessBindings.md) для ресурса [Container](../containers/api-ref/Container/index.md) или вызовом gRPC API [ContainerService/SetAccessBindings](../containers/api-ref/grpc/container_service.md#SetAccessBindings).

{% endlist %}