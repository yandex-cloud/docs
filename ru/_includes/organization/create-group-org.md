{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
  1. В правом верхнем углу страницы нажмите **{{ ui-key.yacloud_org.entity.group.action_create }}** и введите название и описание [группы](../../organization/concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](group-name-format.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды создания группы пользователей {{ org-name }}:

      ```bash
      yc organization-manager group create --help
      ```
  
  1. Чтобы создать группу пользователей в {{ org-name }}, выполните команду:

      ```bash
      yc organization-manager group create \
        --name <имя_группы> \
        --organization-id <идентификатор_организации> \
        --description <описание_группы>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр. Название должно быть уникальным в организации и соответствовать требованиям:

        {% include [group-name-format](group-name-format.md) %}

      * `--organization-id` — идентификатор организации. Необязательный параметр.
      * `--description` — текстовое описание группы пользователей. Необязательный параметр.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры [группы](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
       name            = "<название_группы>"
       description     = "<описание_группы>"
       organization_id = "<идентификатор_организации>"
     }
     ```

     Где:
     * `name` — название группы. Название должно быть уникальным в организации и соответствовать требованиям:

        {% include [group-name-format](group-name-format.md) %}

     * `description` — описание группы. Необязательный параметр.
     * `organization_id` — идентификатор организации, к которой нужно присоединить группу.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group list \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.create](../../organization/api-ref/Group/create.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/Create](../../organization/api-ref/grpc/group_service.md#Create).

{% endlist %}