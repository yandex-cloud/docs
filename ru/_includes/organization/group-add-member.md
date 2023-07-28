{% list tabs %}

- Cloud Organization

    1. Перейдите в сервис [{{ org-full-name }}]({{link-org-main}}).

    1. На левой панели выберите раздел **Группы** ![icon-services](../../_assets/organization/icon-groups.svg) и нажмите строку с названием группы.

    1. Перейдите на вкладку **Участники**.

    1. Нажмите **Добавить участника**.

    1. В окне **Добавление участников** выберите пользователей из списка или воспользуйтесь поиском по пользователям. Также в группу можно добавлять [сервисные аккаунты](../../iam/concepts/users/service-accounts.md).

    1. Нажмите **Сохранить**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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
     * `members` — [идентификаторы](../../organization/users-get.md) участников, которых надо присоединить к группе.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc organization-manager group --name=<имя_группы> list-members --organization-id=<идентификатор_организации>
      ```

{% endlist %}