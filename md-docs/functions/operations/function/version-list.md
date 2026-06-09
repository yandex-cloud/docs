# Получить список версий функции

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/curly-brackets-function.svg) **{{ ui-key.yacloud.serverless-functions.switch_list }}**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **{{ ui-key.yacloud.serverless-functions.item.overview.label_title-history }}** будет показан список версий функции и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор функции, [получите](function-list.md) список функций в каталоге.

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

    Чтобы получить список версий функции, воспользуйтесь методом REST API [listVersions](../../functions/api-ref/Function/listVersions.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/ListVersions](../../functions/api-ref/grpc/Function/listVersions.md).


{% endlist %}