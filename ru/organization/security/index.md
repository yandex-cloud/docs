# Управление доступом в {{ org-full-name }}

Управление доступом в {{ yandex-cloud }} построено на политике [Role Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (RBAC). Чтобы предоставить пользователю определенные права или доступ к ресурсу, нужно назначить ему соответствующие роли.

Каждая роль состоит из набора разрешений, описывающих допустимые операции с ресурсом. Пользователь может назначить роли только с теми разрешениями, которые имеются у него самого. Например, чтобы назначить роль [владельца организации](#admin), пользователь должен сам обладать этой ролью, а роли администратора для этого недостаточно.

Если у ресурса есть дочерние ресурсы, то все разрешения от родительского ресурса будут унаследованы дочерними ресурсами. Например, если вы назначите пользователю роль администратора организации, в которой находится облако, то все разрешения этой роли будут действовать для облака и всех вложенных ресурсов этого облака.

Подробнее об управлении доступом в {{ yandex-cloud }} читайте в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/index.md).

## Какие роли действуют в сервисе {#roles-list}

### Сервисные роли {#service-roles}

* `organization-manager.admin` — роль администратора организации.
  
  Роль дает возможность редактировать настройки организации, создавать федерации удостоверений, добавлять и удалять пользователей, назначать других администраторов.

* `organization-manager.organizations.owner` — роль владельца организации.
  
  Роль дает возможность назначать владельцев организации, а также пользоваться всеми полномочиями администратора.
  
  По умолчанию владелец организации — это пользователь, который ее создал.

* `organization-manager.viewer` — роль дает возможность просматривать настройки организации, но не редактировать их.

* `organization-manager.groups.memberAdmin` — роль дает возможность просматривать информацию о группе, добавлять и удалять участников.

* `organization-manager.federations.admin` — роль дает возможность создавать, изменять и удалять федерации, сертификаты и пользователей в них, просматривать настройки организации, получать список организаций и федераций, а также список сопоставлений групп.

* `organization-manager.federations.viewer` — роль дает возможность просматривать настройки организации, получать список организаций и федераций, а также список сопоставлений групп.

* `organization-manager.osLogins.admin` — роль позволяет редактировать профили OS Login и SSH-ключи, а также создавать сертификаты для пользователей организации.

* `organization-manager.osLogins.viewer` — роль позволяет просматривать профили OS Login и SSH-ключи пользователей организации.

### Примитивные роли {#primitive-roles}

{% include [roles-primitive](../../_includes/roles-primitive.md) %}

### Назначить пользователя администратором организации {#admin}

Чтобы дать пользователю права на управление организацией, [назначьте](#add-role) ему одну из ролей:

* `organization-manager.admin`;
* `organization-manager.organizations.owner`.

### Назначить роль пользователю {#add-role}

Назначать роли в {{ org-full-name }} могут администраторы и владельцы организации. Вы можете назначать пользователям не только роли для управления организацией, но и роли для доступа к ресурсам облаков, подключенных к вашей организации.

О том, какие роли доступны в {{ yandex-cloud }} и какие разрешения в них входят, читайте в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).

{% list tabs group=instructions %}

- Интерфейс {{ org-name }} {#cloud-org}

  1. [Войдите в аккаунт]({{ link-passport }}) администратора или владельца организации.

  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  
  1. На панели слева выберите раздел [{{ ui-key.yacloud_org.pages.acl }}]({{ link-org-acl }}) ![icon-acl](../../_assets/console-icons/shield.svg).

  1. Если у нужного пользователя уже есть хотя бы одна роль, выберите его из списка или воспользуйтесь строкой поиска вверху страницы. В строке пользователя нажмите значок ![icon-context-menu](../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_org.entity.user.action.acl }}**.

     Если нужного пользователя нет в списке, в правом верхнем углу страницы нажмите кнопку **{{ ui-key.yacloud_org.entity.user.action.acl }}**. В открывшемся окне нажмите кнопку **{{ ui-key.yacloud.component.acl.update-dialog.button_select-subject }}** и выберите пользователя из списка или воспользуйтесь строкой поиска.
  
  1. Нажмите **{{ ui-key.yacloud.component.acl.update-dialog.button_add-role }}** и введите название роли или выберите роль в списке.
  
     Описание доступных ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).
  
  1. Нажмите **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  1. Выберите роль, которую хотите назначить. Описание ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).

  1. [Получите идентификатор пользователя](../operations/users-get.md).

  1. Назначьте роль с помощью команды:

      ```bash
      yc <имя_сервиса> <ресурс> add-access-binding <имя_или_идентификатор_ресурса> \
          --role <идентификатор_роли> \
          --subject <тип_субъекта>:<идентификатор_субъекта>
      ```
      * `<имя_сервиса>` — имя сервиса, на чей ресурс назначается роль, например `organization-manager`.
      * `<ресурс>` — категория ресурса. Для организации всегда имеет значение `organization`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Для организации в качестве имени используйте [техническое название](../operations/org-profile.md).
      * `--role` — идентификатор роли, например `organization-manager.admin`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), которому назначается роль.

      Например, назначьте роль администратора для организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization add-access-binding bpf3crucp1v2******** \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2********
      ```

- {{ TF }} {#tf}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Опишите в конфигурационном файле параметры назначаемых ролей:

     * `organization_id` — идентификатор организации.
     * `role` — роль, которую хотите назначить. Описание ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md). Для каждой роли можно использовать только один `yandex_organization manager_organization_iam_binding`.
     * `members` — массив идентификаторов пользователей, которым будет назначена роль: 
       * `userAccount:{user_id}` — идентификатор аккаунта пользователя на Яндексе.
       * `serviceAccount:{service_account_id}` — идентификатор сервисного аккаунта.
       * `federatedUser:{federated_user_id}` —  идентификатор федеративного пользователя.

     Пример структуры конфигурационного файла:

     ```
     resource "yandex_organizationmanager_organization_iam_binding" "editor" {
       organization_id = "<идентификатор_организации>"
       role = "editor"
       members = [
        "federatedUser:<идентификатор_пользователя>",
       ]
     }
     ```

     Более подробную информацию о ресурсах, которые вы можете создать с помощью {{ TF }}, см. в [документации провайдера]({{ tf-provider-link }}/).

  2. Проверьте корректность конфигурационных файлов.
    
     1. В командной строке перейдите в папку, где вы создали конфигурационный файл.
     2. Выполните проверку с помощью команды:
 
       ```
       terraform plan
       ```

      Если конфигурация описана верно, в терминале отобразится список назначенных ролей. Если в конфигурации есть ошибки, {{ TF }} на них укажет. 
 
  3. Назначьте роли.
  
     Если в конфигурации нет ошибок, выполните команду:

       ```
       terraform apply
       ```
     После этого в указанной организации будут назначены роли.

- API {#api}

  Воспользуйтесь методом `updateAccessBindings` для соответствующего ресурса.

  1. Выберите роль, которую хотите назначить. Описание ролей можно найти в документации {{ iam-full-name }} в разделе [{#T}](../../iam/concepts/access-control/roles.md).

  1. [Получите идентификатор пользователя](../operations/users-get.md).

  1. Сформируйте тело запроса, например, в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` — тип `userAccount` и идентификатор пользователя:

      Пример файла `body.json`:

      ```json
      {
        "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
            "roleId": "organization-manager.admin",
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
      export IAM_TOKEN=CggaAT********
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

     Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса в документации {{ iam-full-name }} и {{ resmgr-full-name }}:
     * [{#T}](../../iam/operations/sa/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/cloud/set-access-bindings.md)
     * [{#T}](../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}

Аналогичным образом можно [назначить роль](../../iam/operations/sa/assign-role-for-sa.md#binding-role-organization) на организацию сервисному аккаунту.

### Отозвать роль у пользователя {#revoke}

Если вы хотите запретить пользователю доступ к ресурсу, отзовите у него соответствующие роли на этот ресурс и на ресурсы, от которых наследуются права доступа. Подробнее об управлении доступом в {{ yandex-cloud }} читайте в документации [{{ iam-full-name }}](../../iam/concepts/access-control/index.md).

Отозвать роль может пользователь с ролью администратора `organization-manager.admin` или владельца `organization-manager.organizations.owner` организации. О том, как назначить пользователю роль, читайте в разделе [Роли](#admin).

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

  Чтобы отозвать роль у субъекта, удалите соответствующую привязку прав доступа для соответствующего ресурса:

  1. Посмотрите, кому и какие роли назначены на ресурс:

      ```bash
      yc <имя_сервиса> <ресурс> list-access-bindings <имя_или_идентификатор_ресурса>
      ```

      * `<имя_сервиса>` — имя сервиса, которому принадлежит ресурс, например `organization-manager`.
      * `<ресурс>` — категория ресурса. Для организации всегда имеет значение `organization`.
      * `<имя_или_идентификатор_ресурса>` — имя или идентификатор ресурса. Для организации в качестве имени используйте [техническое название](../operations/org-profile.md).

      Например, посмотрите, кому и какие роли назначены в организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      yc organization-manager organization list-access-bindings bpf3crucp1v2********
      ```

      Результат:

      ```bash
      +------------------------------------------+--------------+----------------------+
      |                 ROLE ID                  | SUBJECT TYPE |      SUBJECT ID      |
      +------------------------------------------+--------------+----------------------+
      | organization-manager.organizations.owner | userAccount  | aje3r40rsemj******** |
      | organization-manager.admin               | userAccount  | aje6o61dvog2******** |
      +------------------------------------------+--------------+----------------------+
      ```


  1. Чтобы удалить привязку прав доступа, выполните команду:

      ```bash
      yc <имя_сервиса> <ресурс> remove-access-binding <имя_или_идентификатор_ресурса> \
          --role <идентификатор_роли> \
          --subject <тип_субъекта>:<идентификатор_субъекта>
      ```

      * `--role` — идентификатор роли, которую надо отозвать, например `organization-manager.admin`.
      * `--subject` — тип и идентификатор [субъекта](../../iam/concepts/access-control/index.md#subject), у которого отзывается роль.

      Например, чтобы отозвать роль у пользователя с идентификатором `aje6o61dvog2********`:

      ```bash
      yc organization-manager organization remove-access-binding bpf3crucp1v2******** \
          --role organization-manager.admin \
          --subject userAccount:aje6o61dvog2********
      ```


- API {#api}

  Чтобы отозвать роль у субъекта на ресурс, удалите соответствующую привязку прав доступа:

  1. Посмотрите, кому и какие роли назначены на ресурс с помощью метода `listAccessBindings`. Например, чтобы посмотреть роли в организации с идентификатором `bpf3crucp1v2********`:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=CggaAT********
      curl -H "Authorization: Bearer ${IAM_TOKEN}" "https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:listAccessBindings"
      ```

      Результат:

      ```bash
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

  1. Сформируйте тело запроса, например в файле `body.json`. В теле запроса укажите, какую привязку прав доступа необходимо удалить. Например, отзовите у пользователя `aje6o61dvog2********` роль `organization-manager.admin`:

      Пример файла `body.json`:

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

  1. Отзовите роль, удалив указанную привязку прав доступа:

      ```bash
      export ORGANIZATION_ID=bpf3crucp1v2********
      export IAM_TOKEN=CggaAT********
      curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \	"https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/${ORGANIZATION_ID}:updateAccessBindings"
      ```

{% endlist %}

### Назначить роль группе пользователей {#access-group-users}

Назначьте [группе пользователей](../../organization/operations/manage-groups.md) роль, чтобы предоставить доступ к какому-либо ресурсу. Воспользуйтесь инструкцией [{#T}](../../iam/operations/groups/access-binding-object.md), чтобы дать [субъекту](../../iam/concepts/access-control/index.md#subject) права на доступ к группе.

В сервисе {{ org-full-name }} группе можно назначить роль на организацию, облако, каталог, другую группу или сервисный аккаунт.

#### Назначить роль на облако или каталог {#access-binding-cloud}

{% include [accessbinding-group-as-object](../../_includes/organization/accessbinding-group-as-subject.md) %}

#### Назначить роль на организацию {#access-binding-organization}

{% include [accessbinding-group-as-subject-org](../../_includes/organization/accessbinding-group-as-subject-org.md) %}
