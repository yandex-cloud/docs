{% list tabs %}

- Cloud Organization

    1. Перейдите в сервис [{{ org-full-name }}]({{link-org-main}}).

    1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/organization/icon-groups.svg) и нажмите строку с названием группы.

    1. Перейдите на вкладку **{{ ui-key.yacloud_org.entity.group.title_tab-members }}**.

    1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_add-member }}**.

    1. В окне **{{ ui-key.yacloud_org.component.subject-select-dialog.title_dialog }}** выберите пользователей из списка или воспользуйтесь поиском по пользователям. Также в группу можно добавлять [сервисные аккаунты](../../iam/concepts/users/service-accounts.md).

    1. Нажмите **{{ ui-key.yacloud_org.component.subject-select-dialog.action_apply }}**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле новых участников группы:

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

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc organization-manager group --name=<имя_группы> list-members --organization-id=<идентификатор_организации>
      ```

{% endlist %}