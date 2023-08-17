{% list tabs %}

- Cloud Organization

    1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.

    1. Перейдите в сервис [{{ org-full-name }}]({{link-org-main}}).

    1. На левой панели выберите раздел **Группы** ![icon-services](../../_assets/organization/icon-groups.svg).

    1. В правом верхнем углу страницы нажмите **Создать группу** и введите название и описание группы.

- {{ TF }}

  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  Если у вас ещё нет {{ TF }}, [установите его и настройте провайдер {{ yandex-cloud }}](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

  1. Опишите в конфигурационном файле параметры группы:

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

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
      
      {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/quickstart.md):

      ```bash
      yc organization-manager group list --organization-id=<идентификатор_организации>
      ```

{% endlist %}