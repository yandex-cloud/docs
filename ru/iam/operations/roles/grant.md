---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---
# Назначение роли

Чтобы предоставить доступ к ресурсу, назначьте субъекту [роль](../../../iam/concepts/access-control/roles.md) на сам ресурс или ресурс, от которого наследуются права доступа, например на каталог или облако. Подробнее читайте в разделе [{#T}](../../concepts/access-control/index.md).

## Назначить роль пользователю {#access-to-user}

В этом разделе описывается, как назначить роль пользователю с аккаунтом на Яндексе. В примерах ниже описано, как назначить роль [сервисному аккаунту](#access-to-sa), [пользователю федерации](#access-to-federated-user) или [всем пользователям сразу](#access-to-all).

{% list tabs %}

- Консоль управления

  В консоли управления можно назначить роль только на облако или каталог:

  {% include [grant-role-console](../../../_includes/grant-role-console.md) %}


- CLI

  1. Выберите роль из списка в разделе [Роли](../../../iam/concepts/access-control/roles.md).
  1. [Получите идентификатор пользователя](../users/get.md).
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

      Например, назначьте роль `viewer` на [облако](../../../resource-manager/concepts/resources-hierarchy.md#folder) `mycloud`:

      ```
      $ yc resource-manager cloud add-access-binding mycloud \
          --role viewer \
          --subject userAccount:aje6o61dvog2h6g9a33s
      ```

- API

  Воспользуйтесь методом `updateAccessBindings` для соответствующего ресурса.

  1. Выберите роль из списка в разделе [Роли](../../../iam/concepts/access-control/roles.md).
  1. [Получите идентификатор пользователя](../users/get.md).
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
  1. {% include [grant-role-folder-via-curl-step](../../../_includes/iam/grant-role-folder-via-curl-step.md) %}

  Вы можете ознакомиться с подробной инструкцией назначения роли для соответствующего ресурса:
  * [{#T}](../sa/set-access-bindings.md)
  * [{#T}](../../../resource-manager/operations/cloud/set-access-bindings.md)
  * [{#T}](../../../resource-manager/operations/folder/set-access-bindings.md)

{% endlist %}

## Примеры {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-federated-user)
* [{#T}](#access-to-all)

### Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- Консоль управления

  Воспользуйтесь инструкцией в [начале раздела](#access-to-user) и назначьте пользователю несколько ролей.

  Чтобы назначить роль другому пользователю, выполните заново все шаги инструкции.

- CLI

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  Например, чтобы назначить несколько ролей на каталог:

  1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
      ```
      $ yc resource-manager folder list-access-binding my-folder
      ```
  2. Назначьте роли. Например, назначьте одному пользователю роль `editor`, а другому `viewer`:
      ```
      $ yc resource-manager folder set-access-bindings my-folder \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API

  1. Чтобы назначить одному пользователю роль `editor`, а другому `viewer`, в файл с телом запроса добавьте несколько привязок прав доступа в `accessBindingDeltas`.

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
          },{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "viewer",
                  "subject": {
                      "id": "helj89sfj80aj24nugsz",
                      "type": "userAccount"
                  }
              }
          }]
      }
      ```
  2. Назначьте указанные роли, например на каталог с идентификатором `b1gvmob95yysaplct532`:

      {% include [grant-role-folder-via-curl](../../../_includes/iam/grant-role-folder-via-curl.md) %}

  Вы также можете назначать роли с помощью метода `setAccessBindings`.

  {% note alert %}

  Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. В теле запроса укажите список новых привязок прав доступа.

      **body.json:**
      ```json
      {
          "accessBindings": [{
              "roleId": "editor",
              "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
          },{
              "roleId": "viewer",
              "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
          }]
      }
      ```

  2. Назначьте роли:

      ```bash
      $ export FOLDER_ID=b1gvmob95yysaplct532
      $ export IAM_TOKEN=CggaATEVAgA...
      $ curl -X POST \
          -H "Content-Type: application/json" \
          -H "Authorization: Bearer ${IAM_TOKEN}" \
          -d '@body.json' \
          "https://resource-manager.api.cloud.yandex.net/resource-manager/v1/folders/${FOLDER_ID}:setAccessBindings"
      ```

{% endlist %}


### Доступ к ресурсу для сервисного аккаунта {#access-to-sa}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-sa.md) %}

### Доступ к ресурсу для федеративного пользователя {#access-to-federated-user}

{% include [include](../../../_includes/saml-assign-role-note.md) %}

Сейчас [федеративному пользователю](../../../organization/add-federation.md) можно назначить роль только в консоли управления.

{% list tabs %}

- Консоль управления

  Назначение роли происходит так же, как назначение роли пользователю с аккаунтом на Яндексе. Рядом с именем пользователя будет указано имя федерации, к которой он относится.

  В консоли управления можно назначить роль только на облако или каталог:

  {% include [grant-role-console](../../../_includes/grant-role-console.md) %}

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [grant-role-for-sa](../../../_includes/iam/grant-role-for-all.md) %}
