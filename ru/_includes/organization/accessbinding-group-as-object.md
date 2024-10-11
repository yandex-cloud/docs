{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием нужной [группы](../../organization/concepts/groups.md).
  
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-acl }}**.
  
  1. Выберите группу, пользователя или [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), которым нужно предоставить доступ к группе. При необходимости воспользуйтесь поиском.
  
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите роли, которые нужно назначить на группу.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    Чтобы выдать права доступа на группу пользователей:

    1. Посмотрите описание команды CLI для назначения роли:

        ```bash
        yc organization-manager group add-access-binding --help
        ```

    1. Получите список групп пользователей вместе с идентификаторами этих групп:

        ```bash
        yc organization-manager group list \
          --organization-id <идентификатор_организации>
        ```

    1. Получите [идентификатор пользователя](../../iam/operations/users/get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
    1. С помощью команды `yc organization-manager group add-access-binding` назначьте роль:

        ```bash
        yc organization-manager group add-access-binding \
          --id <идентификатор_группы> \
          --role <роль> \
          --user-account-id <идентификатор_пользователя> \
          --federation-users <идентификатор_пользователя> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --subject group: <идентификатор_группы>
        ```

        Где:

        * `--id` — идентификатор группы пользователей.
        * `--role` — идентификатор роли.

        Идентификатор объекта, которому назначается роль:

        * `--user-account-id` — идентификатор аккаунта на Яндексе.
        * `--federation-users` — идентификатор федеративного пользователя.
        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--subject group` — идентификатор группы.

- API {#api}

   Воспользуйтесь методом [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/group_service.md#UpdateAccessBindings) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}
