
{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием [группы](../../organization/concepts/groups.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-access }}**.
  1. Чтобы отозвать определенные роли:

      1. В строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. Нажмите ![image](../../_assets/console-icons/xmark.svg) напротив ролей, которые вы хотите отозвать.
      1. Нажмите **{{ ui-key.yacloud.common.save }}**.

  1. Чтобы отозвать все роли, в строке с нужным пользователем, сервисным аккаунтом или группой нажмите ![image](../../_assets/console-icons/ellipsis.svg), выберите ![TrashBin](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_components.acl.action.revoke-access }}** и подтвердите действие.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Посмотрите описание команды CLI для отзыва роли:

      ```bash
      yc organization-manager group remove-access-binding --help
      ```

  1. Получите список групп пользователей вместе с идентификаторами этих групп:

      ```bash
      yc organization-manager group list \
        --organization-id <идентификатор_организации>
      ```

  1. Получите [идентификатор пользователя](../../organization/operations/users-get.md), [сервисного аккаунта](../../iam/operations/sa/get-id.md) или группы пользователей, у которых отзываете роль.
  1. С помощью команды `yc organization-manager group remove-access-binding` отзовите роль у субъекта:

      ```bash
      yc organization-manager group remove-access-binding \
        --id <идентификатор_группы> \
        --role <роль> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--id` — идентификатор группы пользователей, к которой был предоставлен доступ.
      * `--role` — идентификатор роли, которую нужно отозвать.
      * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

          {% endcut %}

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  Чтобы отозвать роль у пользователя, сервисного аккаунта или группы пользователей:

  1. Откройте конфигурационный файл {{ TF }} и удалите фрагмент с ресурсом `yandex_organizationmanager_group_iam_member`, соответствующим роли, которую хотите отозвать.

      ```hcl
      resource "yandex_organizationmanager_group_iam_member" "editor" {
        group_id = "<идентификатор_группы>"
        role     = "<идентификатор_роли>"
        member   = "<тип_субъекта>:<идентификатор_субъекта>"
      }
      ```

      Где:

      * `group_id` — [идентификатор группы пользователей](../../organization/operations/group-get-id.md).
      * `role` — отзываемая роль. Обязательный параметр.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

  1. Примените изменения:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого роль будет отозвана у указанного субъекта. Проверить отсутствие роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

   Чтобы отозвать роль у субъекта на группу пользователей, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Group/updateAccessBindings.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateAccessBindings](../../organization/api-ref/grpc/Group/updateAccessBindings.md) и передайте в запросе:

   * Значение `REMOVE` в параметре `accessBindingDeltas[].action`, чтобы отозвать роль.
   * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
   * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
   * Тип субъекта, у которого отзывается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

        {% cut "Обозначения субъектов" %}

        {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

        {% endcut %}

{% endlist %}
