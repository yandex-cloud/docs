# Установить права доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [[!TITLE]](assign-role-for-sa.md).

Через консоль управления нельзя установить права доступа к сервисному аккаунту. Вы можете [назначить роль на каталог](../../../resource-manager/operations/folder/set-access-bindings.md), которому принадлежит сервисный аккаунт.

## Как назначить роль на сервисный аккаунт

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

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
    ```
4. Узнайте ID пользователя по логину или адресу электронной почты:

    ```
    $ yc iam user-account get test-user
    id: gfei8n54hmfhuk5nogse
    yandex_passport_user_account:
        login: test-user
        default_email: test-user@yandex.ru
    ```

    Чтобы назначить роль сервисному аккаунту или системной группе используйте [примеры](#examples) ниже.
5. Назначьте пользователю роль `editor` на сервисный аккаунт `my-robot`. В субъекте укажите тип `userAccount` и ID пользователя:

    ```
    $ yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject userAccount:gfei8n54hmfhuk5nogse
    ```

**[!TAB API]**

Воспользуйтесь методом [updateAccessBindings](../../api-ref/ServiceAccount/updateAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md). Вам понадобится ID сервисного аккаунта и ID пользователя, которому назначается роль на сервисный аккаунт.

1. Узнайте ID сервисного аккаунта с помощью метода [list](../../api-ref/ServiceAccount/list.md):
    ```bash
    $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob03goohplct641
    {
     "serviceAccounts": [
      {
       "id": "aje6o61dvog2h6g9a33s",
       "folderId": "b1gvmob03goohplct641",
       "createdAt": "2018-10-19T13:26:29Z",
       "name": "my-robot"
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
3. Назначьте пользователю роль `editor` на сервисный аккаунт `my-robot`. В поле `action` укажите `ADD`, а в субъекте укажите тип `userAccount` и ID пользователя:

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

---

## Примеры {#examples}

* [[!TITLE]](#multiple-roles)
* [[!TITLE]](#access-to-sa)
* [[!TITLE]](#access-to-all)

### Назначить несколько ролей {#multiple-roles}

---

**[!TAB CLI]**

Команда `add-access-binding` позволяет добавить только одну роль. Вы можете назначить несколько ролей с помощью команды `set-access-binding`.

> [!WARNING]
>
> Команда `set-access-binding` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс, будут удалены.

1. Убедитесь, что на ресурс не назначено ролей, которые вы не хотите потерять:
    ```
    $ yc iam service-account list-access-binding my-robot
    ```
2. Например, назначьте роль нескольким пользователям:
    ```
    $ yc iam service-account set-access-bindings my-robot \
        --access-binding role=editor,subject=userAccount:gfei8n54hmfhuk5nogse
        --access-binding role=viewer,subject=userAccount:helj89sfj80aj24nugsz
    ```

**[!TAB API]**

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

> [!WARNING]
>
> Метод `setAccessBindings` полностью перезаписывает права доступа к ресурсу! Все текущие роли на ресурс, будут удалены.

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

---


### Доступ сервисного аккаунта к другому сервисному аккаунту {#access-to-sa}

Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

---

**[!TAB CLI]**

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

**[!TAB API]**

1. Узнайте ID сервисного аккаунта `test-sa`, которому вы хотите назначить роль. Чтобы узнать ID, получите список доступных сервисных аккаунтов:

    ```bash
    $ curl -H "Authorization: Bearer <IAM-TOKEN>" \
    https://iam.api.cloud.yandex.net/iam/v1/serviceAccounts?folderId=b1gvmob03goohplct641
    {
     "serviceAccounts": [
      {
       "id": "ajebqtreob2dpblin8pe",
       "folderId": "b1gvmob03goohplct641",
       "createdAt": "2018-10-18T13:42:40Z",
       "name": "test-sa",
       "description": "test-description"
      },
      {
       "id": "aje6o61dvog2h6g9a33s",
       "folderId": "b1gvmob03goohplct641",
       "createdAt": "2018-10-15T18:01:25Z",
       "name": "my-robot"
      }
     ]
    }
    ```

2. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его ID в субъекте. В типе субъекта укажите `serviceAccount`:

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

---

### Доступ к ресурсу любому пользователю {#access-to-all}

Вы можете предоставить доступ к ресурсу любому пользователю Яндекс.Облака. Для этого назначьте роль [системной группе](../../concepts/users/users.md#system) `allAuthenticatedUsers`.

Разрешите любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`:

---

**[!TAB CLI]**

Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

```
$ yc iam service-account add-access-binding my-robot \
    --role viewer \
    --subject system:allAuthenticatedUsers
```

**[!TAB API]**


Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

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

---