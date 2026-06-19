{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием нужной [группы](../../organization/concepts/groups.md).
  
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  
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

    1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым назначаете роль.
    1. С помощью команды `yc organization-manager group add-access-binding` назначьте роль:

        ```bash
        yc organization-manager group add-access-binding \
          --id <идентификатор_группы> \
          --role <роль> \
          --user-account-id <идентификатор_пользователя> \
          --federation-users <идентификатор_пользователя> \
          --service-account-id <идентификатор_сервисного_аккаунта> \
          --subject group:<идентификатор_группы>
        ```

        Где:

        * `--id` — идентификатор группы пользователей.
        * `--role` — идентификатор роли.

        Идентификатор объекта, которому назначается роль:

        * `--user-account-id` — идентификатор аккаунта на Яндексе.
        * `--federation-users` — идентификатор федеративного пользователя.
        * `--service-account-id` — идентификатор сервисного аккаунта.
        * `--subject group` — идентификатор группы.

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_binding" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        members  = [
          "userAccount:<идентификатор_пользователя>",
        ]
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](../../organization/operations/group-get-id.md).
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один `yandex_organizationmanager_group_iam_binding`.
      * `members` — массив идентификаторов пользователей, которым будет назначена роль:

        * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе или локального пользователя.
        * `federatedUser:<идентификатор_пользователя>` — идентификатор федеративного пользователя.
        * `serviceAccount:<идентификатор_сервисного_аккаунта>` — идентификатор сервисного аккаунта.
        * `group:<идентификатор_группы>` — идентификатор группы пользователей.

      Подробнее о ресурсах, которые вы можете создать с помощью {{ TF }}, читайте в [документации провайдера]({{ tf-provider-link }}).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}
   
  После этого указанным пользователям будут назначены роли на группу пользователей. Проверить появление роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

   Воспользуйтесь методом [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, на кого назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

{% endlist %}
