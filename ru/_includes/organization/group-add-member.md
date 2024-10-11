{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}** и нажмите строку с названием [группы](../../organization/concepts/groups.md).
  
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.
  
  1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.
  
  1. В открывшемся окне выберите нужных пользователей или [сервисные аккаунты](../../iam/concepts/users/service-accounts.md). При необходимости воспользуйтесь поиском.
  
  1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления участников в группу пользователей {{ org-name }}:

      ```bash
      yc organization-manager group add-members --help
      ```

  1. Чтобы добавить участников в группу пользователей, выполните команду:

      ```bash
      yc organization-manager group add-members \
        --name <имя_группы> \
        --organization-id <идентификатор_организации> \
        --subject-id <идентификатор_участника>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр.
      * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации.
      * `--subject-id` — идентификатор участника, которого добавляют в группу.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле новых участников [группы](../../organization/concepts/groups.md):

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

     * `group_id` — идентификатор группы, к которой нужно присоединить участника.
     * `members` — [идентификаторы](../../organization/operations/users-get.md) участников, которых надо присоединить к группе.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group list-memebers \
       --name <имя_группы> \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.updateMembers](../../organization/api-ref/Group/updateMembers.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/UpdateMembers](../../organization/api-ref/grpc/group_service.md#UpdateMembers).

{% endlist %}