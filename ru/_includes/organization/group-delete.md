{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.

  1. На панели слева выберите ![groups](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud_org.pages.groups }}**.

  1. В строке с нужной [группой](../../organization/concepts/groups.md) нажмите ![image](../../_assets/console-icons/ellipsis.svg) и выберите ![image](../../_assets/console-icons/trash-bin.svg) **{{ ui-key.yacloud_org.entity.group.action_delete-group }}**.

  1. В открывшемся окне подтвердите удаление группы.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды удаления группы пользователей {{ org-name }}:

      ```bash
      yc organization-manager group delete --help
      ```
  
  1. Чтобы удалить группу пользователей, выполните команду:

      ```bash
      yc organization-manager group delete \
        --name <имя_группы> \
        --organization-id <идентификатор_организации>
      ```

      Где:

      * `--name` — имя группы пользователей. Обязательный параметр.
      * `--organization-id` — [идентификатор](../../organization/operations/organization-get-id.md) организации.

- {{ TF }} {#tf}

  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле инфраструктуру, удалив нужную [группу](../../organization/concepts/groups.md):

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
     yc organization-manager group list-memebers \
       --name <имя_группы> \
       --organization-id <идентификатор_организации>
     ```

- API {#api}

    Воспользуйтесь методом REST API [Group.delete](../../organization/api-ref/Group/delete.md) для ресурса [Group](../../organization/api-ref/Group/index.md) или вызовом gRPC API [GroupService/Delete](../../organization/api-ref/grpc/group_service.md#Delete).

{% endlist %}