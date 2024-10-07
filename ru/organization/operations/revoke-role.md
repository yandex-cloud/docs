# Отозвать роль у пользователя

Если вы хотите запретить пользователю доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее об управлении доступом в {{ yandex-cloud }} читайте в документации [{{ iam-full-name }}](../../iam/concepts/access-control/index.md).

Отозвать роль может [пользователь с ролью администратора](add-org-admin.md) `organization-manager.admin` или владельца `organization-manager.organizations.owner` организации.

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  
  1. На панели слева выберите раздел ![persons-lock](../../_assets/console-icons/persons-lock.svg) [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}).

  1. Выберите пользователя из списка или воспользуйтесь строкой поиска вверху страницы.
  
  1. В правом столбце нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.acl }}**.
  
  1. Нажмите значок ![cross](../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.

  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  1. Посмотрите, кому и какие роли назначены на ресурс:

      ```bash
      yc <имя_сервиса> <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
      ```

      Где:

      * `<имя_сервиса>` — имя сервиса, которому принадлежит ресурс, например, `organization-manager`.
      * `<ресурс>` — категория ресурса. Для организации всегда имеет значение `organization`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Вы можете указать имя или идентификатор ресурса. Для организации в качестве имени используйте [техническое название](../operations/org-profile.md).

      Например, посмотрите, кому и какие роли назначены в организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization list-access-bindings bpf3crucp1v2********
      ```

      Результат:

      ```text
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.organizations.owner | userAccount  | aje3r40rsemj******** |
      | organization-manager.admin               | userAccount  | aje6o61dvog2******** |
      +------------------------------------------+--------------+----------------------+
      ```

  1. Чтобы удалить права доступа, выполните команду:

      ```bash
      yc <имя_сервиса> <ресурс> remove-access-binding <имя_или_идентификатор_ресурса> \
        --role <идентификатор_роли> \
        --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      Где:

      * `--role` — идентификатор роли, которую надо отозвать, например, `organization-manager.admin`.
      * `<тип_субъекта>` — тип [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.
      * `<идентификатор_субъекта>` — идентификатор субъекта.

      Например, чтобы отозвать роль у пользователя с идентификатором `aje6o61dvog2********`:

      ```bash
      yc organization-manager organization remove-access-binding bpf3crucp1v2******** \
        --role organization-manager.admin \
        --subject userAccount:aje6o61dvog2********
      ```

- API {#api}

  1. Посмотрите, кому и какие роли назначены на ресурс с помощью метода `listAccessBindings`. Например, чтобы посмотреть роли в организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=<IAM-токен>
      curl \
        --header "Authorization: Bearer ${IAM_TOKEN}" \
        "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
      ```

      Результат:

      ```text
      {
      "accessBindings": [
      {
        "subject": {
        "id": "aje6o61dvog2********",
        "type": "userAccount"
        },
        "roleId": "organization-manager.admin"
      }
      ]
      }
      ```

  1. Сформируйте тело запроса, например, в файле `body.json`. В теле запроса укажите, какие права доступа необходимо удалить. Например, отзовите у пользователя `aje6o61dvog2********` роль `organization-manager.admin`:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "REMOVE",
          "accessBinding": {
            "roleId": "organization-manager.admin",
            "subject": {
              "id": "aje6o61dvog2********",
              "type": "userAccount"
            }
          }
        }]
      }
      ```

  1. Отзовите роль, удалив указанные права доступа:

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

#### См. также {#see-also}

[{#T}](add-role.md)
