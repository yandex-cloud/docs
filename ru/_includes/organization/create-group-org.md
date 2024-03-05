{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud_org.entity.group.action_create }}** и введите название и описание [группы](../../organization/concepts/groups.md).

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры [группы](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
        name            = "<имя_группы>"
        description     = "<описание_группы>"
        organization_id = "<идентификатор_организации>"
     }
     ```

     Где:
     * `name` — имя группы. Формат имени:

       {% include [name-format](../../_includes/name-format.md) %}

     * `description` — описание группы. Необязательный параметр.
     * `organization_id` — идентификатор организации, к которой нужно присоединить группу.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group list --organization-id=<идентификатор_организации>
     ```

{% endlist %}