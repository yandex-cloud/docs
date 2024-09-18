{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{org-full-name}}]({{ link-org-main }}).
  1. На панели слева выберите раздел **{{ ui-key.yacloud_org.pages.groups }}** ![icon-services](../../_assets/console-icons/persons.svg).
  1. Выберите [группу](../../organization/concepts/groups.md) в списке и нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) напротив имени группы.
  1. Нажмите **{{ ui-key.yacloud_org.entity.group.action_edit }}** и введите новое название или описание группы.

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
      * `--organization-id` — идентификатор организации. Необязательный параметр.
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
     * `organization_id` — идентификатор организации, к которой принадлежит группа.
  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {{ TF }} создаст все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager group get \
       --name <название_группы> \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.update](../../organization/api-ref/Group/update.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/Update](../../organization/api-ref/grpc/group_service.md#Update).

{% endlist %}