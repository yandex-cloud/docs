---
title: Как предоставить доступ к SAML-приложению в {{ org-full-name }}
description: Из этой статьи вы узнаете, как настроить доступ к SAML-приложению в {{ org-full-name }}.
---

# Настроить доступ пользователям SAML-приложения в {{ org-full-name }}


Чтобы предоставить доступ к [SAML-приложению](../../concepts/applications.md#saml), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для назначения ролей пользователям SAML-приложения:

      ```bash
      yc organization-manager idp application saml application set-access-bindings --help
      ```

   1. Получите список SAML-приложений и их идентификаторы:

      ```bash
      yc organization-manager idp application saml application list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список SAML-приложений.

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.

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