---
title: Как назначить права пулу пользователей в {{ org-full-name }}
description: Из этой статьи вы узнаете, как настроить доступ пулу пользователей в {{ org-full-name }}.
---

# Настроить доступ пользователям пула


Чтобы предоставить доступ к [пулу](../../concepts/user-pools.md), назначьте [роли](../../../iam/concepts/access-control/roles.md) субъектам. [Узнайте](../../security/index.md#roles-list), какие роли действуют в сервисе, чтобы назначить нужные.

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева нажмите ![userpool](../../../_assets/organization/userpool.svg) **{{ ui-key.yacloud_org.pages.userpools }}** и выберите пул пользователей.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.organization.userpools.UserpoolPageLayout.title_userpool_acl_5rdMM }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к пулу пользователей.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роль. При необходимости добавьте другие роли.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Посмотрите описание команды CLI для назначения ролей пользователям [пула](../../concepts/user-pools.md):

      ```bash
      yc organization-manager idp userpool set-access-bindings --help
      ```

   1. Получите список пулов пользователей и их идентификаторы:

      ```bash
      yc organization-manager idp userpool list --organization-id <идентификатор_организации>
      ```

      Где `--organization-id` — [идентификатор организации](../organization-get-id.md), в которой нужно получить список пулов пользователей.

   1. Получите [идентификатор пользователя](../../../organization/operations/users-get.md), [сервисного аккаунта](../../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.
   1. С помощью команды `yc organization-manager idp userpool set-access-bindings` назначьте роли:
      
      * Пользователю с аккаунтом на Яндексе или локальному пользователю:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <идентификатор_пула> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <идентификатор_пула> \
           --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <идентификатор_пула> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <идентификатор_пула> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      * Всем авторизованным пользователям ([публичная группа](../../../iam/concepts/access-control/public-group.md) `All authenticated users`):

         ```bash
         yc organization-manager idp userpool set-access-bindings \
           --id <идентификатор_пула> \
           --access-binding role=<роль>,all-authenticated-users
         ```

      Для каждой роли передайте отдельный параметр `--access-binding`. Пример:

      ```bash
      yc organization-manager idp userpool set-access-bindings \
        --id <идентификатор_пула> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

  Воспользуйтесь методом REST API [Userpool.SetAccessBindings](../../idp/api-ref/Userpool/setAccessBindings.md) для ресурса [Userpool](../../idp/api-ref/Userpool/index.md) или вызовом gRPC API [UserpoolService/SetAccessBindings](../../idp/api-ref/grpc/Userpool/setAccessBindings.md).

{% endlist %}
