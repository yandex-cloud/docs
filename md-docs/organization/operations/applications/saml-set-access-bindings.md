# Настроить доступ к SAML-приложению в {{ org-full-name }}


Чтобы предоставить доступ к [SAML-приложению](../../concepts/applications.md#saml), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).
  1. На панели слева нажмите ![shapes-4](../../../_assets/console-icons/shapes-4.svg) **{{ ui-key.yacloud_org.pages.apps }}** и выберите нужное приложение.
  1. Перейдите на вкладку **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к приложению.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль. При необходимости добавьте другие роли.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

   1. Посмотрите описание команды CLI для назначения ролей пользователям SAML-приложения:

      ```bash
      yc organization-manager idp application saml application set-access-bindings --help
      ```

   1. Получите список SAML-приложений и их идентификаторы:

      ```bash
      yc organization-manager idp application saml application list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список SAML-приложений.

   1. Получите [идентификатор пользователя](../users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.

   1. С помощью команды `yc organization-manager idp application saml application set-access-bindings` назначьте роли:
      
      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Всем пользователям федерации:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,federation-users=<идентификатор_федерации>
         ```

      * Всем пользователям организации:
        
         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,organization-users=<идентификатор_организации>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc organization-manager idp application saml application set-access-bindings \
           --id <идентификатор_приложения> \
           --access-binding role=<роль>,group-members=<идентификатор_группы>
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

  Воспользуйтесь методом REST API [Application.SetAccessBindings](../../idp/application/saml/api-ref/Application/setAccessBindings.md) для ресурса [Application](../../idp/application/saml/api-ref/Application/index.md) или вызовом gRPC API [ApplicationService/SetAccessBindings](../../idp/application/saml/api-ref/grpc/Application/setAccessBindings.md).

{% endlist %}