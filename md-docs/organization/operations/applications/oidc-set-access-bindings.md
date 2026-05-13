# Настроить доступ пользователям OIDC-приложения в Yandex Identity Hub


Чтобы предоставить доступ к [OIDC-приложению](../../concepts/applications.md#oidc), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Посмотрите описание команды CLI для назначения ролей пользователям OIDC-приложения:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings --help
      ```

   1. Получите список OIDC-приложений и их идентификаторы:

      ```bash
      yc organization-manager idp application oauth application list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список OIDC-приложений.

   1. Получите [идентификатор пользователя](../users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.

   1. С помощью команды `yc organization-manager idp application oauth application set-access-bindings` назначьте роли:
      
      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Всем пользователям федерации:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,federation-users=<идентификатор_федерации>
         ```

      * Всем пользователями организации:
        
         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,organization-users=<идентификатор_организации>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      * Всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

         ```bash
         yc organization-manager idp application oauth application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,all-authenticated-users
         ```

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager idp application oauth application set-access-bindings \
        --id <идентификатор_приложения> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Application.SetAccessBindings](../../idp/application/oauth/api-ref/Application/setAccessBindings.md) для ресурса [Application](../../idp/application/oauth/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/SetAccessBindings](../../idp/application/oauth/api-ref/grpc/Application/setAccessBindings.md).

{% endlist %}