Чтобы изменить название или описание группы:

{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.

    1. Перейдите в сервис [{{org-full-name}}]({{ link-org-main }}).

    1. На левой панели выберите раздел **Группы** ![icon-services](../../_assets/organization/icon-groups.svg).
    
    1. Выберите группу в списке и нажмите значок ![image](../../_assets/options.svg) напротив имени группы.
    
    1. Нажмите **Изменить** и введите новое название или описание группы.

    1. Нажмите **Сохранить**.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

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