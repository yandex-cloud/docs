# Получить список пользователей в пуле


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите нужный [пул пользователей](../../concepts/user-pools.md).
  1. Перейдите на вкладку **Участники**. Отобразится список всех пользователей пула.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка пользователей в [пуле](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp user list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp user list --userpool-id <идентификатор_пула>
      ```

      Где `--userpool-id` — идентификатор пула, список пользователей которого нужно получить.

- API {#api}

  Воспользуйтесь методом REST API [User.List](../../idp/api-ref/User/list.md) для ресурса [User](../../idp/api-ref/User/index.md) или вызовом gRPC API [UserService/List](../../idp/api-ref/grpc/User/list.md).

{% endlist %}