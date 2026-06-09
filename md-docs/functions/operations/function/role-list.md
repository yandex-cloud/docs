# Посмотреть роли, назначенные на функцию

{% note info %}

[Роли](../../security/index.md#roles-list), назначенные на каталог, облако или организацию, автоматически [наследуются](../../../iam/concepts/access-control/index.md#inheritance) функцией. При этом они не отображаются в списке ролей, назначенных на нее. Подробнее о [просмотре ролей](../../../iam/operations/roles/get-assigned-roles.md).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

    Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

    По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

    Чтобы посмотреть [роли](../../security/index.md#roles-list), назначенные на функцию, выполните команду:
    
    ```bash
    yc serverless function list-access-bindings <имя_функции>
    ```

    Результат:
    ```text
    +------------------------------+--------------+-----------------------+
    |           ROLE ID            | SUBJECT TYPE |       SUBJECT ID      |
    +------------------------------+--------------+-----------------------+
    | functions.functionInvoker    | system       | allAuthenticatedUsers |
    +------------------------------+--------------+-----------------------+
    ```

- API {#api}

  Чтобы посмотреть роли на функцию, воспользуйтесь методом REST API [listAccessBindings](../../functions/api-ref/Function/listAccessBindings.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/ListAccessBindings](../../functions/api-ref/grpc/Function/listAccessBindings.md).

{% endlist %}