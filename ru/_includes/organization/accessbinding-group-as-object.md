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

    1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым нужно предоставить доступ к группе.
    1. С помощью команды `yc organization-manager group add-access-binding` назначьте роль:

        ```bash
        yc organization-manager group add-access-binding \
          --id <идентификатор_группы> \
          --role <роль> \
          --subject <тип_субъекта>:<идентификатор_субъекта>
        ```

        Где:

        * `--id` — идентификатор группы пользователей, к которой нужно предоставить доступ.
        * `--role` — идентификатор роли.
        * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

            {% cut "Обозначения субъектов" %}

            {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

            {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, которым нужно предоставить доступ к группе.
  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        member   = "<субъект>"
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](../../organization/operations/group-get-id.md).
      * `role` — назначаемая роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_organizationmanager_group_iam_member` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_group_iam_member).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого указанным субъектам будут назначены роли на группу пользователей. Проверить назначение роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

   Чтобы назначить роль субъекту на группу пользователей, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}
