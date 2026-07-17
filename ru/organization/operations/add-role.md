# Назначить роль пользователю

Назначать роли в {{ org-full-name }} могут [администраторы и владельцы организации](add-org-admin.md). Вы можете назначать пользователям не только роли для управления организацией, но и роли для доступа к ресурсам облаков, подключенных к вашей организации.

О том, какие роли доступны в {{ yandex-cloud }} и какие разрешения в них входят, читайте в документации {{ iam-full-name }} в разделе [{#T}](../../iam/roles-reference.md).

{% list tabs group=instructions %}

- Интерфейс {{ cloud-center }} {#cloud-center}

  {% include [assign-role-to-user](../../_includes/organization/assign-role-to-user.md) %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Назначьте роль с помощью команды:

      ```bash
      yc organization-manager organization add-access-binding <имя_или_идентификатор_организации> \
        --role <идентификатор_роли> \
        --user-account-id <идентификатор_пользователя>
      ```

      Где:

      * `--role` — идентификатор роли.
      * `--user-account-id` — идентификатор пользователя. Также вы можете использовать параметр `--user-yandex-login` и указать логин пользователя вместо идентификатора.

      Например, назначьте пользователю роль администратора на организацию с идентификатором `b1gmit33ngp3********`:

      ```bash
      yc organization-manager organization add-access-binding b1gmit33ngp3******** \
        --role resource-manager.admin \
        --user-account-id aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Опишите в конфигурационном файле параметры назначаемых ролей.

      Пример структуры конфигурационного файла для назначения роли на организацию:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<идентификатор_организации>"
        role            = "<идентификатор_роли>"
        member          = "userAccount:<идентификатор_пользователя>"
      }
      ```

      Где:

      * `organization_id` — [идентификатор](./organization-get-id.md) организации.
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один ресурс `yandex_organizationmanager_organization_iam_binding`.
      * `member` — обозначение [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-terraform](../../_includes/iam/subjects-designations-terraform.md) %}

          {% endcut %}

      Подробнее о параметрах ресурса `yandex_organizationmanager_organization_iam_binding` читайте в [документации провайдера]({{ tf-provider-resources-link }}/organizationmanager_organization_iam_binding).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  После этого указанному пользователю будут назначены роли в организации. Проверить назначение роли можно в [интерфейсе {{ cloud-center }}]({{ link-org-cloud-center }}).

- API {#api}

  Чтобы назначить роль пользователю на организацию, воспользуйтесь методом REST API [updateAccessBindings](../api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../api-ref/grpc/Organization/updateAccessBindings.md).

  1. Выберите [роль](../../iam/concepts/access-control/roles.md), которую хотите назначить.
  1. [Получите](users-get.md) идентификатор пользователя.
  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` или `federatedUser` и идентификатор пользователя:

      **body.json:**

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<идентификатор_роли>",
            "subject": {
              "id": "<идентификатор_пользователя>",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

      Где:

      * Значение `ADD` в параметре `accessBindingDeltas[].action` указывает, что роль нужно добавить.
      * `accessBindingDeltas[].accessBinding.roleId` — идентификатор роли, которую нужно назначить.
      * `accessBindingDeltas[].accessBinding.subject.id` — идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.
      * `accessBindingDeltas[].accessBinding.subject.type` — тип субъекта, которому назначается роль.

          {% cut "Обозначения субъектов" %}

          {% include [subjects-designations-api](../../_includes/iam/subjects-designations-api.md) %}

          {% endcut %}

  1. Назначьте роль. Например, для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-токен>
      curl \
        --request POST \
        --header "Content-Type: application/json" \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        --data '@body.json' \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

Аналогичным образом можно [назначить роль](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) на организацию сервисному аккаунту.

#### Полезные ссылки {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
