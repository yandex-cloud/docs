---
title: Как настроить доступ к управлению группой пользователей в {{ org-full-name }}
description: Следуя данной инструкции, вы сможете настроить доступ к управлению группой пользователей в {{ org-name }}.
---

## Настроить доступ к управлению группой {#access-manage-group}

Вы можете предоставить доступ к группе пользователей:

* [пользователям с аккаунтом на Яндексе](../../iam/concepts/users/accounts.md#passport);
* [федеративным пользователям](../../iam/concepts/users/accounts.md#saml-federation);
* [сервисным аккаунтам](../../iam/concepts/users/service-accounts.md);
* другим [группам пользователей](../../organization/concepts/groups.md).

Для этого назначьте [роли](../../iam/concepts/access-control/roles.md) на группу. Чтобы выбрать нужные, [узнайте](../security/index.md#roles-list), какие роли действуют в сервисе.

### Назначить роль {#add-access-binding}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-object.md) %}

### Назначить несколько ролей {#set-access-bindings}

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием [группы](../../organization/concepts/groups.md).
  
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.
  
  1. Выберите пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которому нужно предоставить доступ к группе. При необходимости воспользуйтесь поиском.
  
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роли, которые нужно назначить на группу.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

   {% include [set-access-bindings-cli](../../_includes/iam/set-access-bindings-cli.md) %}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   Чтобы назначить несколько ролей на группу пользователей:

   1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

      ```bash
      yc organization-manager group list-access-bindings \
        --id <идентификатор_группы>
      ```

   1. Посмотрите описание команды CLI для назначения ролей:

      ```bash
      yc organization-manager group set-access-bindings --help
      ```

   1. Получите список групп пользователей вместе с идентификаторами этих групп:

      ```bash
      yc organization-manager group list
      ```

   1. Получите [идентификатор пользователя](../../iam/operations/users/get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роли.
   1. С помощью команды `yc organization-manager group set-access-bindings` назначьте роли:

      * Пользователю с аккаунтом на Яндексе:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,user-account-id=<идентификатор_пользователя>
         ```

      * Федеративному пользователю:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,subject=federatedUser:<идентификатор_пользователя>
         ```

      * Сервисному аккаунту:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,service-account-id=<идентификатор_сервисного_аккаунта>
         ```

      * Группе пользователей:

         ```bash
         yc organization-manager group set-access-bindings \
           --id <идентификатор_группы> \
           --access-binding role=<роль>,subject=group:<идентификатор_группы>
         ```

      Для каждой роли передайте отдельный флаг `--access-binding`. Пример:

      ```bash
      yc organization-manager group set-access-bindings \
        --id <идентификатор_группы> \
        --access-binding role=<роль1>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль2>,service-account-id=<идентификатор_сервисного_аккаунта> \
        --access-binding role=<роль3>,service-account-id=<идентификатор_сервисного_аккаунта>
      ```

- API {#api}

   {% include [set-access-bindings-api](../../_includes/iam/set-access-bindings-api.md) %}

   Воспользуйтесь методом [setAccessBindings](../api-ref/Group/setAccessBindings.md) для ресурса [Group](../api-ref/Group/index.md) или вызовом gRPC API [GroupService/SetAccessBindings](../api-ref/grpc/group_service.md#SetAccessBindings). Передайте в запросе массив из объектов, каждый из которых соответствует отдельной роли и содержит следующие данные:

   * Роль в параметре `accessBindings[].roleId`.
   * Идентификатор субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.id`.
   * Тип субъекта, на кого назначаются роли, в параметре `accessBindings[].subject.type`.

{% endlist %}

### Отозвать роль {#remove-access-binding}

{% include [accessbinding-remove](../../_includes/organization/accessbinding-remove.md) %}