[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Functions](../../index.md) > [Пошаговые инструкции](../index.md) > Получение информации о функции > Получить информацию о версии функции

# Получить информацию о версии функции

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления](https://console.yandex.cloud) перейдите в каталог, в котором находится функция.
    1. Перейдите в сервис **Cloud Functions**.
    1. На панели слева выберите ![image](../../../_assets/console-icons/curly-brackets-function.svg) **Функции**.
    1. Выберите функцию, для которой хотите получить список версий.
    1. В разделе **История версий** будет показан список версий функции и подробная информация о них.

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы узнать имя или уникальный идентификатор версии функции, получите [список версий функции](version-list.md) в каталоге.

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

    Чтобы получить подробную информацию о версии функции, воспользуйтесь методом REST API [getVersion](../../functions/api-ref/Function/getVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionsService/GetVersion](../../functions/api-ref/grpc/Function/getVersion.md).


{% endlist %}