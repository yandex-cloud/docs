---

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---
# Настройка права доступа к облаку

Чтобы предоставить пользователю доступ ко всем ресурсам в облаке, назначьте ему [роль](../../../iam/concepts/access-control/roles.md) на это облако.

## Назначить роль на облако {#access-to-user}

{% list tabs %}

- Консоль управления

  1. {% include [grant-role-console-first-steps](../../../_includes/iam/grant-role-console-first-steps.md) %}
  1. {% include [configure-roles-console](../../../_includes/iam/configure-roles-console.md) %}
  1. Нажмите значок ![image](../../../_assets/plus-sign.svg) в блоке **Роли на облако <имя облака>**.
  1. Выберите необходимую роль из списка.

- CLI

  1. Посмотрите описание команды для назначения роли на облако:

      ```
      $ yc resource-manager cloud add-access-binding --help
      ```

  2. Выберите облако, например `my-cloud`:

      ```
      $ yc resource-manager cloud list
      +----------------------+----------+
      |          ID          |   NAME   |
      +----------------------+----------+
      | b1gg8sgd16g7qca5onqs | my-cloud |
      +----------------------+----------+
      ```

  3. Выберите [роль](../../../iam/concepts/access-control/roles.md):

      ```
      $ yc iam role list
      +--------------------------------+-------------+
      |               ID               | DESCRIPTION |
      +--------------------------------+-------------+
      | admin                          |             |
      | compute.images.user            |             |
      | editor                         |             |
      | ...                            |             |
      +--------------------------------+-------------+
      ```
  4. Узнайте ID пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или системной группе используйте [примеры](#examples) ниже.

      ```
      $ yc iam user-account get test-user
      id: gfei8n54hmfhuk5nogse
      yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
      ```


  5. Назначьте пользователю `test-user` роль `editor` на облако `my-cloud`. В субъекте укажите тип `userAccount` и ID пользователя:

      ```
      $ yc resource-manager cloud add-access-binding my-cloud \
          --role editor \
          --subject userAccount:gfei8n54hmfhuk5nogse
      ```

- API

  Воспользуйтесь методом [updateAccessBindings](../../api-ref/Cloud/updateAccessBindings.md) для ресурса [Cloud](../../api-ref/Cloud/index.md). Вам понадобится ID облака и ID пользователя, которому назначается роль на облако.

  1. Узнайте ID облака с помощью метода [list](../../api-ref/Cloud/list.md):
      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds

      {
       "clouds": [
        {
         "id": "b1gg8sgd16g7qca5onqs",
         "createdAt": "2018-09-23T12:14:45Z",
         "name": "cloud-b1gg8sgd16g7qc"
        }
       ]
      }
      ```
  2. Узнайте ID пользователя по логину с помощью метода [getByLogin](../../../iam/api-ref/YandexPassportUserAccount/getByLogin.md):
      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/yandexPassportUserAccounts:byLogin?login=test-user

      {
       "id": "gfei8n54hmfhuk5nogse",
       "yandexPassportUserAccount": {
        "login": "test-user",
        "defaultEmail": "test-user@yandex.ru"
       }
      }
      ```
  3. Назначьте пользователю роль `editor` на облако `my-cloud`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и ID пользователя:

      ```bash
      $ curl -X POST \
          -H 'Content-Type: application/json' \
          -H "Authorization: Bearer <IAM-TOKEN>" \
          -d '{
          "accessBindingDeltas": [{
              "action": "ADD",
              "accessBinding": {
                  "roleId": "editor",
                  "subject": {
                      "id": "gfei8n54hmfhuk5nogse",
                      "type": "userAccount"
          }}}]}' \
          https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
      ```

{% endlist %}

## Примеры {#examples}

* [{#T}](#multiple-roles)
* [{#T}](#access-to-sa)
* [{#T}](#access-to-all)

### Назначить несколько ролей {#multiple-roles}

{% list tabs %}

- CLI

  Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

  {% note alert %}

  Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
      ```
      $ yc resource-manager cloud list-access-binding my-cloud
      ```
  2. Например, назначьте роль нескольким пользователям:
      ```
      $ yc resource-manager cloud set-access-bindings my-cloud \
          --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
          --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
      ```

- API

  Назначьте одному пользователю роль `editor`, а другому `viewer`:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
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
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

  Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/Cloud/setAccessBindings.md).

  {% note alert %}

  Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс будут удалены.

  {% endnote %}

  ```bash
  curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindings": [{
          "roleId": "editor",
          "subject": { "id": "ajei8n54hmfhuk5nog0g", "type": "userAccount" }
      },{
          "roleId": "viewer",
          "subject": { "id": "helj89sfj80aj24nugsz", "type": "userAccount" }
      }]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:setAccessBindings
  ```

{% endlist %}


### Доступ к облаку для сервисного аккаунта {#access-to-sa}

Сервисному аккаунту можно назначать роли только на облако, которому он принадлежит.

Разрешите сервисному аккаунту `test-sa` управлять облаком `my-cloud` и ресурсами в нем:

{% list tabs %}

- CLI

  1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

      ```
      $ yc iam service-account list
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      +----------------------+----------+------------------+
      ```

  2. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его ID. В типе субъекта укажите `serviceAccount`:

      ```
      $ yc resource-manager cloud add-access-binding my-cloud \
          --role editor \
          --subject serviceAccount:ajebqtreob2dpblin8pe
      ```

- API

  1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

      ```bash
      $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
          https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532

      {
       "serviceAccounts": [
        {
         "id": "ajebqtreob2dpblin8pe",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-18T13:42:40Z",
         "name": "test-sa",
         "description": "test-description"
        }
       ]
      }
      ```

  2. Назначьте сервисному аккаунту `test-sa` роль `editor` на облако `my-cloud`. В свойстве `subject` укажите тип `serviceAccount` и ID `test-sa`. В URL запроса в качестве ресурса укажите ID `my-cloud`:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "editor",
              "subject": {
                  "id": "ajebqtreob2dpblin8pe",
                  "type": "serviceAccount"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию об облаке `my-cloud` и ресурсах в нем:

{% list tabs %}

- CLI

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

  ```
  $ yc resource-manager cloud add-access-binding my-cloud \
      --role viewer \
      --subject system:allAuthenticatedUsers
  ```

- API

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В свойстве `subject` укажите тип `system`:

  ```bash
  $ curl -X POST \
      -H 'Content-Type: application/json' \
      -H "Authorization: Bearer <IAM-TOKEN>" \
      -d '{
      "accessBindingDeltas": [{
          "action": "ADD",
          "accessBinding": {
              "roleId": "viewer",
              "subject": {
                  "id": "allAuthenticatedUsers",
                  "type": "system"
      }}}]}' \
      https://resource-manager.api.cloud.yandex.net/resource-manager/v1/clouds/b1gg8sgd16g7qca5onqs:updateAccessBindings
  ```

{% endlist %}

#### Что дальше {#what-is-next}

* [{#T}](../folder/create.md)
* [{#T}](../folder/set-access-bindings.md)
* [{#T}](../../concepts/resources-hierarchy.md)
