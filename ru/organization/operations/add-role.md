# Назначить роль пользователю

Назначать роли в {{ org-full-name }} могут [администраторы и владельцы организации](add-org-admin.md). Вы можете назначать пользователям не только роли для управления организацией, но и роли для доступа к ресурсам облаков, подключенных к вашей организации.

О том, какие роли доступны в {{ yandex-cloud }} и какие разрешения в них входят, читайте в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).

  1. На панели слева выберите раздел ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

  1. Справа сверху нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

  1. Выберите пользователя из списка или воспользуйтесь строкой поиска.

  1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и введите название роли или выберите роль в списке. Вы можете выбрать больше одной роли.

  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Выберите роль, которую хотите назначить.

  1. [Получите идентификатор пользователя](../operations/users-get.md).

  1. Назначьте роль с помощью команды:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `<имя_сервиса>` — имя сервиса, на чей ресурс назначается роль, например, `organization-manager`.
      * `<ресурс>` — категория ресурса. Для организации всегда имеет значение `organization`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Для организации в качестве имени используйте [техническое название](../operations/org-profile.md).
      * `--role` — идентификатор роли.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      Например, назначьте пользователю роль администратора на каталог с идентификатором `b1gmit33ngp3********`:

      ```bash
      yc recource-manager folder add-access-binding b1gmit33ngp3******** \
        --role resource-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

      ```hcl
      resource "yandex_organizationmanager_organization_iam_binding" "editor" {
        organization_id = "<идентификатор_организации>"
        role = "<идентификатор_роли>"
        members = [
          "federatedUser:<идентификатор_пользователя>",
        ]
      }
      ```

      Где:

      * `organization_id` — идентификатор организации.
      * `role` — роль, которую хотите назначить. Для каждой роли можно использовать только один `yandex_organization manager_organization_iam_binding`.
      * `members` — массив идентификаторов пользователей, которым будет назначена роль:

        * `userAccount:<идентификатор_пользователя>` — идентификатор аккаунта пользователя на Яндексе.
        * `federatedUser:<идентификатор_пользователя>` — идентификатор федеративного пользователя.

      Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  1. Создайте ресурсы:

      {% include [terraform-validate-plan-apply](../../_tutorials/terraform-validate-plan-apply.md) %}
     
  После этого указанному пользователю будут назначены роли в организации. Проверить появление роли можно в [консоли управления]({{ link-console-main }}).

- API {#api}

  Чтобы назначить роль, воспользуйтесь методом REST API `updateAccessBindings` для соответствующего ресурса:

  1. Выберите роль, которую хотите назначить.

  1. [Получите идентификатор пользователя](../operations/users-get.md).

  1. Сформируйте тело запроса, например, в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` или `federatedUser` и идентификатор пользователя:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "<идентификатор_роли>",
            "subject": {
              "id": "gfei8n54hmfh********",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

  1. Назначьте роль. Например, для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-токен>
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

Аналогичным образом можно [назначить роль](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) на организацию сервисному аккаунту.

#### См. также {#see-also}

* [{#T}](../../iam/operations/sa/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
* [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)
