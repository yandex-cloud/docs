# Удалить версию функции

{% note info %}

Если у версии функции есть [теги](../../concepts/function.md#tag), ее нельзя удалить. [Удалите теги](tag-delete.md) прежде, чем удалять версию функции.

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы удалить версию функции, выполните команду:

  ```bash
  yc serverless function version delete <идентификатор_версии_функции>
  ```

- API {#api}

  Чтобы удалить версию функции, воспользуйтесь методом REST API [deleteVersion](../../functions/api-ref/Function/deleteVersion.md) для ресурса [Function](../../functions/api-ref/Function/index.md) или вызовом gRPC API [FunctionService/DeleteVersion](../../functions/api-ref/grpc/Function/deleteVersion.md).

{% endlist %}