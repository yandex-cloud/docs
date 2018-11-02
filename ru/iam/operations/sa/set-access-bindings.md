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
4. Узнайте идентификатор и [тип субъекта](../../concepts/users/users.md), которому назначается роль.

    Чтобы назначить роль [обычному пользователю](../../concepts/users/users.md#passport), узнайте его идентификатор по логину или адресу электронной почты:

    ```
    $ yc iam user-account get test-user
    id: gfei8n54hmfhuk5nogse
    yandex_passport_user_account:
        login: test-user
        default_email: test-user@yandex.ru
    ```

    Чтобы назначить роль сервисному аккаунту или системной группе используйте [примеры](#examples) ниже.
5. Назначьте пользователю `test-user` роль `editor` на сервисный аккаунт `my-robot`. В типе субъекта укажите `userAccount`:

    ```
    $ yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject userAccount:gfei8n54hmfhuk5nogse
    ```

**[!TAB API]**

Чтобы назначить роль на сервисный аккаунт как на ресурс, воспользуйтесь методом [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

---

## Примеры {#examples}

### Предоставить доступ сервисному аккаунту на другой сервисный аккаунт



Разрешите сервисному аккаунту `test-sa` управлять сервисным аккаунтом `my-robot`:

---

**[!TAB CLI]**

1. Узнайте идентификатор сервисного аккаунта, которому вы хотите назначить роль. Чтобы узнать идентификатор, получите список доступных сервисных аккаунтов:

    ```
    $ yc iam service-account list
    +----------------------+----------+------------------+
    |          ID          |   NAME   |   DESCRIPTION    |
    +----------------------+----------+------------------+
    | ajebqtreob2dpblin8pe | test-sa  | test-description |
    | aje6o61dvog2h6g9a33s | my-robot |                  |
    +----------------------+----------+------------------+
    ```

2. Назначьте роль `editor` сервисному аккаунту `test-sa`, указав его идентификатор. В типе субъекта укажите `serviceAccount`:

    ```
    $ yc iam service-account add-access-binding my-robot \
        --role editor \
        --subject serviceAccount:ajebqtreob2dpblin8pe
    ```

---

### Предоставить доступ любому пользователю

Вы можете предоставить доступ к ресурсу любому пользователю, прошедшему аутентификацию. Для этого назначьте роль [системной группе](../../concepts/users/users.md#system) `allAuthenticatedUsers`.

Разрешите любому прошедшему аутентификацию пользователю просматривать информацию о сервисном аккаунте `my-robot`:

---

**[!TAB CLI]**

Назначьте роль `viewer` системной группе `allAuthenticatedUsers`. В типе субъекта укажите `system`:

```
$ yc iam service-account add-access-binding my-robot \
    --role viewer \
    --subject system:allAuthenticatedUsers
```

---