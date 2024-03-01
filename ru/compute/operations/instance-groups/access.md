---
title: "Настроить права доступа к группе виртуальных машин"
description: "Следуя данной инструкции, вы сможете настроить права доступа группе виртуальных машин."
---

# Настроить права доступа к группе виртуальных машин

Чтобы предоставить пользователю, группе или [сервисному аккаунту](../../../iam/concepts/users/service-accounts.md) доступ к [группе виртуальных машин](../../concepts/instance-groups/index.md), назначьте [роль](../../../iam/concepts/access-control/roles.md) на нее.

## Назначить роль {#access-to-user}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для назначения роли на группу ВМ:

     ```bash
     {{ yc-compute-ig }} add-access-binding --help
     ```

  1. Получите список групп виртуальных машин в каталоге по умолчанию:

     {% include [instance-group-list](../../../_includes/instance-groups/instance-group-list.md) %}

  1. Посмотрите список ролей, которые уже назначены на ресурс:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Назначьте роль с помощью команды:

     * Пользователю:

       ```bash
       {{ yc-compute-ig }} add-access-binding <имя_или_идентификатор_группы_ВМ> \
         --user-account-id <идентификатор_пользователя> \
         --role <роль>
       ```

       Где:

       * `--user-account-id` — [идентификатор пользователя](../../../iam/operations/users/get.md).
       * `--role` — назначаемая [роль](../../security/index.md#roles-list).

     * Сервисному аккаунту:

       ```bash
       {{ yc-compute-ig }} add-access-binding <имя_или_идентификатор_группы_ВМ> \
         --service-account-id <идентификатор_сервисного_аккаунта> \
         --role <роль>
       ```

       Где:

       * `--service-account-id` — [идентификатор сервисного аккаунта](../../../iam/operations/sa/get-id.md).
       * `--role` — назначаемая роль.

- API {#api}

  Воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/InstanceGroup/updateAccessBindings.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/) или вызовом gRPC API [InstanceGroupService/UpdateAccessBindings](../../api-ref/grpc/instance_group_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `ADD`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}

## Назначить несколько ролей {#multiple-roles}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.resource-acl.button_new-bindings }}**.
  1. В открывшемся окне выберите группу, пользователя или сервисный аккаунт, которым нужно предоставить доступ к группе ВМ.
  1. Нажмите кнопку ![image](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите необходимые [роли](../../security/index.md#roles-list).
  1. Добавьте еще роль через кнопку **{{ ui-key.yacloud_components.acl.button.add-role }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.apply }}**.
  
- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  Вы можете назначить несколько ролей с помощью команды `set-access-bindings`.

  {% include [set-access-bindings](../../../_includes/compute/set-access-bindings-note.md) %}

  1. Убедитесь, что на ресурс не назначены роли, которые вы не хотите потерять:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Посмотрите описание команды CLI для назначения ролей на группу ВМ:

     ```bash
     {{ yc-compute-ig }} set-access-bindings --help
     ```

  1. Назначьте роли:

     ```bash
     {{ yc-compute-ig }} set-access-bindings <имя_или_идентификатор_группы_ВМ> \
       --access-binding role=<роль>,subject=<тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--access-binding` — назначаемая роль:

       * `role` — идентификатор назначаемой роли.
       * `subject` — тип и идентификатор [субъекта](../../../iam/concepts/access-control/index.md#subject), которому назначается роль.

     Например, назначьте роли нескольким пользователям и сервисному аккаунту:

     ```bash
     {{ yc-compute-ig }} set-access-bindings test-group \
       --access-binding role=editor,subject=userAccount:gfei8n54hmfh******** \
       --access-binding role=viewer,subject=userAccount:helj89sfj80a******** \
       --access-binding role=editor,subject=serviceAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Воспользуйтесь методом REST API [setAccessBindings](../../api-ref/InstanceGroup/setAccessBindings.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/) или вызовом gRPC API [InstanceGroupService/SetAccessBindings](../../api-ref/grpc/instance_group_service.md#SetAccessBindings).

{% endlist %}

## Отозвать роль {#revoke-role}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится группа ВМ.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. На панели слева выберите ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.compute.switch_groups }}**.
  1. Выберите нужную группу.
  1. Перейдите на вкладку ![image](../../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}**.
  1. В строке нужного пользователя нажмите значок ![icon-context-menu](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_assign-binding }}**.
  1. Нажмите значок ![cross](../../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.
  
- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли на группу ВМ:

     ```bash
     {{ yc-compute-ig }} remove-access-binding --help
     ```

  1. Посмотрите, кому и какие роли назначены на ресурс:

     ```bash
     {{ yc-compute-ig }} list-access-bindings <имя_или_идентификатор_группы_ВМ>
     ```

  1. Чтобы удалить привязку прав доступа, выполните команду:

     ```bash
     {{ yc-compute-ig }} remove-access-binding <имя_или_идентификатор_группы_ВМ> \
       --role <идентификатор_роли> \
       --subject <тип_субъекта>:<идентификатор_субъекта>
     ```

     Где:

     * `--role` — идентификатор роли, которую надо отозвать.
     * `--subject` — [субъект](../../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

     Например, чтобы отозвать роль `{{ roles-viewer }}` у пользователя с идентификатором `ajel6l0jcb9s********` на группу ВМ:

     ```bash
     {{ yc-compute-ig }} remove-access-binding test-group \
       --role viewer \
       --subject userAccount:ajel6l0jcb9s********
     ```

- API {#api}

  Чтобы отозвать роли на ВМ, воспользуйтесь методом REST API [updateAccessBindings](../../api-ref/InstanceGroup/updateAccessBindings.md) для ресурса [InstanceGroup](../../api-ref/InstanceGroup/) или вызовом gRPC API [InstanceGroupService/UpdateAccessBindings](../../api-ref/grpc/instance_group_service.md#UpdateAccessBindings). В теле запроса в свойстве `action` укажите `REMOVE`, а в свойстве `subject` — тип и идентификатор пользователя.

{% endlist %}
