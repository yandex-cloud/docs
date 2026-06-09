# Получить список пулов пользователей


{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}**.
  
     Отобразятся все [пулы пользователей](../../concepts/user-pools.md), доступные в вашей организации.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды CLI для получения списка [пулов пользователей](../../concepts/user-pools.md):

     ```bash
     yc organization-manager idp userpool list --help
     ```

  1. Выполните команду:

      ```bash
      yc organization-manager idp userpool list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), список пулов пользователей которой нужно получить.

- API {#api}

  Воспользуйтесь методом REST API [Userpool.List](../../idp/api-ref/Userpool/list.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/List](../../idp/api-ref/grpc/Userpool/list.md).

{% endlist %}