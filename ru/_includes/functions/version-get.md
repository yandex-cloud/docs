{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** будет показан список версий функции и подробная информация о них.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы узнать имя или уникальный идентификатор версии функции, получите [список версий функции](../../functions/operations/function/version-list.md) в каталоге.

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

    Чтобы получить подробную информацию о версии функции, воспользуйтесь методом REST API [getVersion](../../functions/functions/api-ref/Function/getVersion.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/GetVersion](../../functions/functions/api-ref/grpc/function_service.md#GetVersion).


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    Получить подробную информацию о версии функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}
