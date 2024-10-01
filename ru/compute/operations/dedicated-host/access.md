---
title: "Настроить права доступа к группе выделенных хостов"
description: "Для группы выделенных хостов {{ compute-name }} вы можете назначить или отозвать права доступа."
---

# Настроить права доступа к группе выделенных хостов


Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [группе выделенных хостов](../../concepts/dedicated-host.md), назначьте [роль](../../../iam/concepts/access-control/roles.md) на нее.

## Назначить роль {#add-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа выделенных хостов.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Выберите нужную группу выделенных хостов.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе выделенных хостов.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимую [роль](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на группу выделенных хостов:

     ```bash
     yc compute host-group add-access-binding --help
     ```

  1. Получите список групп выделенных хостов в [каталоге](../../../resource-manager/concepts/resources-hierarchy.md#folder) по умолчанию:

     ```bash
     yc compute host-group list
     ```

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     yc compute host-group list-access-bindings <имя_или_идентификатор_группы_выделенных_хостов>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       yc compute host-group add-access-binding <имя_или_идентификатор_группы_выделенных_хостов> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../iam/operations/users/get.md). Чтобы назначить роль для всех аутентифицированных пользователей, воспользуйтесь флагом `--all-authenticated-users`.
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       yc compute host-group add-access-binding <имя_или_идентификатор_группы_выделенных_хостов> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

- API {#api}

  Чтобы назначить роль, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/HostGroup/updateAccessBindings.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызовом gRPC API [HostGroupService/UpdateAccessBindings](../../api-ref/grpc/host_group_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#set-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа выделенных хостов.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Выберите нужную группу выделенных хостов.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе выделенных хостов.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимую [роль](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     yc compute host-group list-access-bindings <имя_или_идентификатор_группы_выделенных_хостов>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на группу выделенных хостов:

     ```bash
     yc compute host-group set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     yc compute host-group set-access-bindings <имя_или_идентификатор_группы_выделенных_хостов> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — параметры для установки прав доступа:

       * `role` — назначаемая [роль](../../security/index.md#roles-list).
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     yc compute host-group set-access-bindings my-host-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh********
       --access-binding role=viewer,subject=userAccount:helj89sfj80a********
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Чтобы назначить роли на ресурс, воспользуйтесь методом REST API [setAccessBindings](../../api-ref/HostGroup/setAccessBindings.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызовом gRPC API [HostGroupService/SetAccessBindings](../../api-ref/grpc/host_group_service.md#SetAccessBindings).

  {% note alert %}

  Метод `setAccessBindings` и вызов `HostGroupService/SetAccessBindings` полностью перезаписывают права доступа к ресурсу. Все текущие роли на ресурс будут удалены.

  {% endnote %}

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором расположена группа выделенных хостов.
  1. Выберите сервис **{{ ui-key.yacloud.compute.label_service }}**.
  1. На панели слева выберите ![image](../../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud.compute.switch_host-groups }}**.
  1. Выберите нужную группу выделенных хостов.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![image](../../../_assets/horizontal-ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Рядом с ролью нажмите значок ![image](../../../_assets/cross.svg).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на группу выделенных хостов:

     ```bash
     yc compute host-group remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     yc compute host-group list-access-bindings <имя_или_идентификатор_группы_выделенных_хостов>
     ```

  1. Чтобы отозвать права доступа, выполните команду:

     ```bash
     yc compute host-group remove-access-binding <имя_или_идентификатор_группы_выделенных_хостов> \
       --role=<роль> \
       --subject=<тип_субъекта>:<идентификатор_субъекта> \
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на группу выделенных хостов:

     ```bash
     yc compute host-group remove-access-binding my-host-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Чтобы отозвать роль, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/HostGroup/updateAccessBindings.md) для ресурса [HostGroup](../../api-ref/HostGroup/index.md) или вызовом gRPC API [HostGroupService/UpdateAccessBindings](../../api-ref/grpc/host_group_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
