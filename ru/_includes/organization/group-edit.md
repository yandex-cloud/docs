Чтобы изменить название или описание группы:

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.

    1. Перейдите в сервис [{{org-full-name}}]({{ link-org-main }}).

    1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
    
    1. Выберите группу в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив имени группы.
    
    1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_edit }}** и введите новое название или описание группы.

    1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Измените в конфигурационном файле параметры группы:

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
        name            = "new-group-name"
        description     = "My first group"
        organization_id = "<идентификатор_организации>"
     }
     ```

     Где: 

     * `name` — новое имя группы. Формат имени:

        {% include [name-format](../../_includes/name-format.md) %}

     * `description` — новое описание группы.
     * `organization_id` — идентификатор организации, к которой принадлежит группа.

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc organization-manager group get --name=<имя_группы> --organization-id=<идентификатор_организации>
      ```

{% endlist %}