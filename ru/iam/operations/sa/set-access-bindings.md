# Настройка прав доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [{#T}](assign-role-for-sa.md).

Через консоль управления нельзя установить права доступа к сервисному аккаунту. Вы можете [назначить роль на каталог](../../../resource-manager/operations/folder/set-access-bindings.md), которому принадлежит сервисный аккаунт.

## Назначить роль на сервисный аккаунт {#assign-role-to-sa}

{% list tabs %}

- Консоль управления

    1. Перейдите в каталог, которому принадлежит сервисный аккаунт.
    1. Выберите вкладку **Сервисные аккаунты**.
    1. Выберите сервисный аккаунт и нажмите на строку с его именем.
    1. Перейдите в раздел **Права доступа к сервисному аккаунту** (кнопка **Права доступа** на панели слева).
    1. Нажмите кнопку **Назначить роли**.
    1. В окне **Настройка прав доступа** каталога нажмите кнопку **Выбрать пользователя**.
    1. Выберите пользователя из списка или воспользуйтесь поиском по пользователям.
    1. Нажмите кнопку **Добавить роль**.
    1. Выберите роль.
    1. Нажмите **Сохранить**.

- CLI

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    1. Посмотрите описание команды для назначения роли на сервисный аккаунт как на ресурс:

        ```
        $ yc iam service-account add-access-binding --help
        ```

    2. Выберите сервисный аккаунт, например `my-robot`:

        ```
        $ yc iam service-account list
        +----------------------+----------+------------------+
        |          ID          |   NAME   |   DESCRIPTION    |
        +----------------------+----------+------------------+
        | ajebqtreob2dpblin8pe | test-sa  | test-description |
        | aje6o61dvog2h6g9a33s | my-robot |                  |
        +----------------------+----------+------------------+
        ```

    3. Выберите [роль](../../concepts/access-control/roles.md):

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
    4. Узнайте ID пользователя по логину или адресу электронной почты. Чтобы назначить роль не пользователю, а сервисному аккаунту или группе пользователей, воспользуйтесь [примерами](#examples) ниже.

        ```
        $ yc iam user-account get test-user
        id: gfei8n54hmfhuk5nogse
        yandex_passport_user_account:
            login: test-user
            default_email: test-user@yandex.ru
        ```
    5. Назначьте пользователю `test-user` роль `editor` на сервисный аккаунт `my-robot`. В субъекте укажите тип `userAccount` и ID пользователя:

        ```
        $ yc iam service-account add-access-binding my-robot \
            --role editor \
            --subject userAccount:gfei8n54hmfhuk5nogse
        ```

- API

    Воспользуйтесь методом [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md). Вам понадобится ID сервисного аккаунта и ID пользователя, которому назначается роль на сервисный аккаунт.

    1. Узнайте ID сервисного аккаунта с помощью метода [list](../../api-ref/ServiceAccount/list.md):
        ```bash
        $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
            https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob95yysaplct532

        {
        "serviceAccounts": [
            {
            "id": "aje6o61dvog2h6g9a33s",
            "folderId": "b1gvmob95yysaplct532",
            "createdAt": "2018-10-19T13:26:29Z",
            "name": "my-robot"
            }
            ...
        ]
        }
        ```
    2. Узнайте ID пользователя по логину с помощью метода [getByLogin](../../api-ref/YandexPassportUserAccount/getByLogin.md):
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
    3. Назначьте пользователю роль `editor` на сервисный аккаунт `my-robot`. В свойстве `action` укажите `ADD`, а в свойстве `subject` - тип `userAccount` и ID пользователя:

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
            https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
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
        $ yc iam service-account list-access-bindings my-robot
        ```
    2. Например, назначьте роль нескольким пользователям:
        ```
        $ yc iam service-account set-access-bindings my-robot \
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
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
    ```

    Вы также можете назначать роли с помощью метода [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md).

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
        https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:setAccessBindings
    ```

{% endlist %}


### Доступ сервисного аккаунта к другому сервисному аккаунту {#access-to-sa}

Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

{% list tabs %}

- CLI

  1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

      ```
      $ yc iam service-account list
      +----------------------+----------+------------------+
      |          ID          |   NAME   |   DESCRIPTION    |
      +----------------------+----------+------------------+
      | ajebqtreob2dpblin8pe | test-sa  | test-description |
      | aje6o61dvog2h6g9a33s | my-robot |                  |
      +----------------------+----------+------------------+
      ```

  2. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его ID. В типе субъекта укажите `serviceAccount`:

      ```
      $ yc iam service-account add-access-binding my-robot \
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
        },
        {
         "id": "aje6o61dvog2h6g9a33s",
         "folderId": "b1gvmob95yysaplct532",
         "createdAt": "2018-10-15T18:01:25Z",
         "name": "my-robot"
        }
       ]
      }
      ```

  2. Назначьте сервисному аккаунту `test-sa` роль `editor` на другой сервисный аккаунт `my-robot`. В свойстве `subject` укажите тип `serviceAccount` и ID `test-sa`. В URL запроса в качестве ресурса укажите ID `my-robot`:

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
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
  ```

{% endlist %}

### Доступ к ресурсу всем пользователям {#access-to-all}

{% include [set-access-to-all](../../../_includes/iam/set-access-to-all.md) %}

Например, разрешите любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`:

{% list tabs %}

- CLI

  Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

  ```
  $ yc iam service-account add-access-binding my-robot \
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
      https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts/aje6o61dvog2h6g9a33s:updateAccessBindings
  ```

{% endlist %}
