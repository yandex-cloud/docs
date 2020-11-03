{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Откройте сервис **{{ sf-name }}**.
    1. Перейдите на вкладку **Функции**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Получите подробную информацию о версии функции по:

    * `ID`:
        ```
        yc serverless function version get <идентификатор версии>
        ```
        Результат:
        ```
        id: b09u830mb1n32a7rj0n8
        function_id: b097d9ous3gep99khe83
        created_at: "2019-06-13T09:23:23.383Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - $latest
        log_group_id: eolv6578frac08uh5h6s
        ```

    * `TAGS`:
        ```
        yc serverless function version get-by-tag --function-name <имя функции> --tag <тег>
        ```
        Результат:
        ```
        id: b09ch6pmpohfc9sogj5f
        function_id: b097d9ous3gep99khe83
        created_at: "2019-06-13T09:12:38.464Z"
        runtime: python37
        entrypoint: test.handler
        resources:
          memory: "134217728"
        execution_timeout: 5s
        image_size: "4096"
        status: ACTIVE
        tags:
        - beta
        log_group_id: eolv6578frac08uh5h6s
        ```

- API

    Получить подробную информацию о версии функции можно с помощью метода API [getVersion](../../functions/functions/api-ref/Function/getVersion.md).

{% endlist %}