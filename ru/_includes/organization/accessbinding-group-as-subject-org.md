{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  1. Войдите в сервис [{{ org-full-name }}]({{ link-org-cloud-center }}) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud_org.pages.acl }}**.
  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_components.acl.action.assign-roles }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_org.pages.groups }}** и выберите [группу](../../organization/concepts/groups.md) или воспользуйтесь поиском по названию группы.

      Вы также можете назначить роль одной из [системных](../../iam/concepts/access-control/system-group.md) групп:

      * `All users in organization X` — в группу входят все пользователи организации `X`.
      * `All users in federation N` — в группу входят все пользователи федерации `N`.

  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** и выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить группе на организацию. Вы можете назначить несколько ролей.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  1. Назначьте [роль](../../iam/concepts/access-control/roles.md) [группе](../../organization/concepts/groups.md) на организацию:

      ```bash
      yc organization-manager organization add-access-binding \
        --id <идентификатор_организации> \
        --role <идентификатор_роли> \
        --subject group:<идентификатор_группы>
      ```

      Где:

      * `--id` — идентификатор организации, на которую назначается роль.
      * `--role` — идентификатор роли, которую нужно назначить.
      * `--subject` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-cli](../iam/subjects-designations-cli.md) %}

          {% endcut %}

  1. Проверьте, что запрошенные права были выданы:

      ```bash
      yc organization-manager organization list-access-bindings <идентификатор_организации>
      ```

      Ответ содержит список всех ролей, выданных пользователям и группам в организации:

      ```text
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.admin               | userAccount  | ajev1p2345lj******** |
      | organization-manager.organizations.owner | userAccount  | ajev1p2345lj******** |
      | editor                                   | group        | ajev1p2345lj******** |
      | viewer                                   | group        | ajev1p2345lj******** |
      +------------------------------------------+--------------+----------------------+
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../terraform-install.md) %}

  1. Добавьте в конфигурационный файл параметры ресурса, укажите нужную [роль](../../iam/concepts/access-control/roles.md) и [группу](../../organization/concepts/groups.md):

     ```hcl
     resource "yandex_organizationmanager_organization_iam_member" "users-editors" {
       organization_id = "<идентификатор_организации>"
       role            = "<идентификатор_роли>"
       member          = "group:<идентификатор_группы>"
     }
     ```

     Где:
     
     * `organization_id` — [идентификатор организации](../../organization/operations/organization-get-id.md). Обязательный параметр.
     * `role` — назначаемая роль. Обязательный параметр.
     * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль. Обязательный параметр.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../iam/subjects-designations-terraform.md) %}

          {% endcut %}

     Подробнее о параметрах ресурса `yandex_organizationmanager_organization_iam_member` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_member).

  1. Создайте ресурсы:

     {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     После этого будут назначены указанные права доступа. Проверить назначение роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}) или с помощью команды [CLI](../../cli/):

     ```bash
     yc organization-manager organization list-access-bindings <идентификатор_организации>
     ```

- API {#api}

  Чтобы назначить роль группе пользователей на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md) и передайте в запросе:

  * Значение `ADD` в параметре `accessBindingDeltas[].action`, чтобы добавить роль.
  * Роль в параметре `accessBindingDeltas[].accessBinding.roleId`.
  * Идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.id`.
  * Тип субъекта, которому назначается роль, в параметре `accessBindingDeltas[].accessBinding.subject.type`.

      {% cut "Обозначения субъектов" %}

      {% include [subjects-designations-api](../iam/subjects-designations-api.md) %}

      {% endcut %}

{% endlist %}