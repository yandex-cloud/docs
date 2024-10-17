{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}).

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. В правом верхнем углу страницы нажмите ![Circles3Plus](../../_assets/console-icons/circles-3-plus.svg) **{{ ui-key.yacloud_org.entity.group.action_create }}**.

  1. Задайте название и описание [группы](../../organization/concepts/groups.md).

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](group-name-format.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_org.groups.action_create-group }}**.

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

      * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации. Необязательный параметр.
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
     * `organization_id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, к которой нужно присоединить группу.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group list \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.create](../../organization/api-ref/Group/create.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/Create](../../organization/api-ref/grpc/Group/create.md).

{% endlist %}