# Управление пользователями

С помощью инструкций в этом пункте чек-листа вы добавите пользователей к созданной организации, назначите администратора и определите роли пользователей. 

## Добавьте пользователя Яндекса {#add-user-yandex}

Если у сотрудников компании есть аккаунты на Яндексе (например, `login@yandex.ru`), они могут использовать эти аккаунты для доступа к сервисам {{yandex-cloud}}, подключенным к вашей организации.

Чтобы добавить аккаунты сотрудников в организацию:

1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
1. На левой панели выберите раздел [Пользователи](https://org.cloud.yandex.ru/users) ![icon-users](../../_assets/organization/icon-users.svg).
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_org.page.users.action.invite-users }}**.
1. Введите почтовые адреса пользователей Яндекса, которых вы хотите пригласить в организацию (например, `login@yandex.ru`).
1. Нажмите кнопку **{{ ui-key.yacloud_org.entity.invitation.action_send-invitation }}**. Пользователи будут подключены к организации, как только примут отправленное им приглашение.

Чтобы получить доступ к сервисам, которые подключены к организации, приглашенным пользователям будет достаточно войти в свой аккаунт на Яндексе.

## Добавьте федеративных пользователей {#add-user-sso}

Для добавления федеративных пользователей вам необходимо знать Name ID пользователей, которые возвращает сервер поставщика удостоверений (IdP) вместе с ответом об успешной аутентификации. Обычно это основной email пользователя. Если вы не знаете, что возвращает сервер в качестве Name ID, обратитесь к администратору, который настраивал аутентификацию в вашей федерации.

Чтобы добавить пользователей федерации в организацию:

{% list tabs %}

- Консоль управления

  1. [Войдите в аккаунт]({{ link-passport-login }}) администратора организации.
  1. Перейдите в сервис [{{ org-full-name }}]({{ link-org-main }}).
  1. На левой панели выберите раздел [Пользователи](https://org.cloud.yandex.ru/users) ![icon-users](../../_assets/organization/icon-users.svg).
  1. В правом верхнем углу нажмите ![icon-users](../../_assets/datalens/arrow-down.svg) → **Добавить федеративных пользователей**.
  1. Выберите федерацию, из которой необходимо добавить пользователей.
  1. Перечислите Name ID пользователей, разделяя их переносами строк.
  1. Нажмите кнопку **Добавить**. Пользователи будут подключены к организации.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды добавления пользователей:

    ```
    yc organization-manager federation saml add-user-accounts --help
    ```

  1. Добавьте пользователей, перечислив их Name ID через запятую:

    ```
    yc organization-manager federation saml add-user-accounts --name my-federation \
    --name-ids=alice@example.com,bob@example.com,charlie@example.com
    ```

- API

  Чтобы добавить пользователей федерации в облако:

  1.  Сформируйте файл с телом запроса, например `body.json`. В теле запроса укажите массив Name ID пользователей, которых необходимо добавить:

    ```json
    {
    "nameIds": [
      "alice@example.com",
      "bob@example.com",
      "charlie@example.com"
    ]
    }
    ```
  1.  Отправьте запрос, указав в параметрах идентификатор федерации:

    ```bash
    $ curl -X POST \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer <IAM-токен>" \
    -d '@body.json' \
    https://iam.api.cloud.yandex.net/iam/v1/saml/federations/<ID федерации>:addUserAccounts
    ```

{% endlist %}

## Назначьте роли пользователям {#add-role}

{% list tabs %}

- Консоль управления

  В консоли управления можно назначить роль только на облако или каталог:

  {% include [grant-role-console](../../_includes/grant-role-console.md) %}


- CLI

  1. Выберите роль из списка в разделе [Роли](../../iam/concepts/access-control/roles.md).
  1. [Получите идентификатор пользователя](../../organization/operations/users-get.md).
  1. Назначьте роль с помощью команды:

    ```
    yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
      --role <ROLE-ID> \
      --subject userAccount:<USER-ACCOUNT-ID>
    ```

    где:

    * `<SERVICE-NAME>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
    * `<RESOURCE>` — категория ресурса, например `cloud`.
    * `<RESOURCE-NAME>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
    * `<RESOURCE-ID>` — идентификатор ресурса.
    * `<ROLE-ID>` — идентификатор роли, например `{{ roles-cloud-owner }}`.
    * `<USER-ACCOUNT-ID>` — идентификатор аккаунта пользователя, которому назначается роль.

    Например, назначьте роль `viewer` на [облако](../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

    ```
    $ yc resource-manager cloud add-access-binding mycloud \
      --role viewer \
      --subject userAccount:aje6o61dvog2h6g9a33s
    ```

- API

  Воспользуйтесь методом `updateAccessBindings` для соответствующего ресурса.

  1. Выберите роль из списка в разделе [Роли](../../iam/concepts/access-control/roles.md).
  1. [Получите идентификатор пользователя](../../organization/operations/users-get.md).
  1. Сформируйте тело запроса, например в файле `body.json`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и идентификатор пользователя:

    **body.json:**
    ```json
    {
      "accessBindingDeltas": [{
        "action": "ADD",
        "accessBinding": {
          "roleId": "editor",
          "subject": {
            "id": "gfei8n54hmfhuk5nogse",
            "type": "userAccount"
            }
          }
        }
      ]
    }
    ```
    
  1. {% include [grant-role-folder-via-curl-step](../../_includes/iam/grant-role-folder-via-curl-step.md) %} 
  
{% endlist %}


## Назначьте администратора {#admin}

Чтобы дать пользователю права на управление организацией, назначьте ему одну из ролей:

* `organization-manager.admin` — роль администратора организации.
  
  Роль дает возможность редактировать настройки организации, создавать федерации удостоверений, добавлять и удалять пользователей, назначать других администраторов, управлять ресурсами облаков организации.

* `organization-manager.organizations.owner` — роль владельца организации.
  
  Роль дает возможность назначать владельцев организации, а также пользоваться всеми полномочиями администратора.
  
  По умолчанию владелец организации — это пользователь, который ее создал.

* `organization-manager.viewer` — роль дает возможность просматривать настройки организации, но не редактировать их.