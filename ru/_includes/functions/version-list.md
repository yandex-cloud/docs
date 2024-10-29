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

    {% include [note](function-list-note.md) %}

    Чтобы получить список версий функции, выполните команду:

    ```bash
    yc serverless function version list --function-name <имя_функции>
    ```

    Результат:

    ```text
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    |          ID          |     FUNCTION ID      |  RUNTIME  |  ENTRYPOINT  |  TAGS   |     CREATED AT      |
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    | b09u830mb1n3******** | b097d9ous3ge******** | python311 | test.handler | $latest | 2023-08-22 09:23:23 |
    | b09ch6pmpohf******** | b097d9ous3ge******** | python311 | test.handler | beta    | 2023-08-22 09:12:38 |
    +----------------------+----------------------+-----------+--------------+---------+---------------------+
    ```

- API {#api}

    Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../../functions/functions/api-ref/Function/listVersions.md) для ресурса [Function](../../functions/functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../../functions/functions/api-ref/grpc/Function/listVersions.md).


- {{ yandex-cloud }} Toolkit {#yc-toolkit}

    Получить список версий функции можно с помощью [плагина {{ yandex-cloud }} Toolkit](https://github.com/yandex-cloud/ide-plugin-jetbrains) для семейства IDE на [платформе IntelliJ](https://www.jetbrains.com/ru-ru/opensource/idea/) от [JetBrains](https://www.jetbrains.com/).


{% endlist %}
