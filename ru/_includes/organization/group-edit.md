{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.
  
  1. В строке с нужной [группой](../../organization/concepts/groups.md) нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud_org.entity.group.action_edit }}**.

  1. Задайте новое название или описание группы.

      Название должно быть уникальным в организации и соответствовать требованиям:

      {% include [group-name-format](group-name-format.md) %}

  1. Нажмите **{{ ui-key.yacloud_org.actions.save-changes }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды редактирования группы пользователей {{ org-name }}:

      ```bash
      yc organization-manager group update --help
      ```

  1. Чтобы редактировать группу пользователей, выполните команду:

      ```bash
      yc organization-manager group update \
        --name <имя_группы> \
        --new-name <новое_имя_группы> \
        --organization-id <идентификатор_организации> \
        --description <описание_группы>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр. Название должно быть уникальным в организации и соответствовать требованиям:

        {% include [group-name-format](group-name-format.md) %}

      * `--new-name` — новое имя группы пользователей.
      * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации. Необязательный параметр.
      * `--description` — текстовое описание группы пользователей. Необязательный параметр.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Измените в конфигурационном файле параметры группы:

     ```hcl
     resource "yandex_organizationmanager_group" "my-group" {
        name            = "<название_группы>"
        description     = "<описание_группы>"
        organization_id = "<идентификатор_организации>"
     }
     ```

     Где:

     * `name` — новое название группы. Название должно быть уникальным в организации и соответствовать требованиям:

        {% include [group-name-format](group-name-format.md) %}

     * `description` — новое описание группы.
     * `organization_id` — [идентификатор](../../organization/operations/organization-get-id.md) организации, к которой принадлежит группа.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group get \
       --name <название_группы> \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.update](../../organization/api-ref/Group/update.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/Update](../../organization/api-ref/grpc/Group/update.md).

{% endlist %}