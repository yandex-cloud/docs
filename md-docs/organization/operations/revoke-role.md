[Документация Yandex Cloud](../../index.md) > [Yandex Identity Hub](../index.md) > [Пошаговые инструкции](index.md) > Управление доступом > Отозвать роль у пользователя

# Отозвать роль у пользователя

Если вы хотите запретить пользователю доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее об управлении доступом в Yandex Cloud читайте в документации [Yandex Identity and Access Management](../../iam/concepts/access-control/index.md).

Отозвать роль может [пользователь с ролью администратора](add-org-admin.md) `organization-manager.admin` или владельца `organization-manager.organizations.owner` организации.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1.  Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.
  
  1. Найдите в списке нужного пользователя. При необходимости воспользуйтесь строкой поиска или фильтром.
  
  1. В строке с нужным пользователем нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **Назначить роли**. В открывшемся окне:
    
      1. Нажмите значок ![cross](../../_assets/console-icons/xmark.svg) рядом с ролью, чтобы удалить ее.
  
      1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  1. Посмотрите, кому и какие роли назначены на ресурс:

      ```bash
      yc <имя_сервиса> <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
      ```

      Где:

      * `<имя_сервиса>` — имя сервиса, которому принадлежит ресурс, например, `organization-manager`.
      * `<ресурс>` — категория ресурса. Для организации всегда имеет значение `organization`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Вы можете указать имя или идентификатор ресурса. Для организации в качестве имени используйте [техническое название](org-profile.md).

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
        "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
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
        "https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

#### Полезные ссылки {#see-also}

[Назначить роль пользователю](add-role.md)