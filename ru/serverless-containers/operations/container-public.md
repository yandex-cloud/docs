# Сделать контейнер публичным

Чтобы любой пользователь мог вызвать контейнер без передачи заголовка авторизации, сделайте контейнер публичным.

{% list tabs %}

- CLI

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

- API

  Сделать контейнер публичным можно с помощью метода API [setAccessBindings](../../serverless-containers/containers/api-ref/Container/setAccessBindings.md).

{% endlist %}