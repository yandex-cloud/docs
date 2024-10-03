{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg) и нажмите строку с названием [группы](../../organization/concepts/groups.md).
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.
  1. Выберите в списке участников нужного и нажмите ![image](../../_assets/console-icons/ellipsis.svg) -> ![image](../../_assets/console-icons/trash-bin.svg)**{{ ui-key.yacloud_org.entity.group.action_remove-user }}**.
  1. В появившемся окне нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_remove-user }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды удаления участников из группы пользователей {{ org-name }}:

      ```bash
      yc organization-manager group remove-members --help
      ```
  
  1. Чтобы удалить участника из группы пользователей, выполните команду:

      ```bash
      yc organization-manager group remove-members \
        --name <имя_группы> \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_участника>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр.
      * `--organization-id` — идентификатор организации.
      * `--subject-id` — идентификатор участника, которого удаляют из группы.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле участников [группы](../../organization/concepts/groups.md), которых надо оставить в группе:

     ```hcl
     resource "yandex_organizationmanager_group_membership" "group-members" {
        group_id = "<идентификатор_группы>"
        members  = [
          "<идентификатор_участника_1>",
          "<идентификатор_участника_2>"
        ]
     }
     ```

     Где:

     * `group_id` — идентификатор группы, из которой нужно удалить участника.
     * `members` — [идентификаторы](../../organization/operations/users-get.md) участников, которых надо оставить в группе.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group list-members \
       --name <имя_группы> \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.updateMembers](../../organization/api-ref/Group/updateMembers.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateMembers](../../organization/api-ref/grpc/group_service.md#UpdateMembers).

{% endlist %}