# Установить права доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [[!TITLE]](assign-role-for-sa.md).

Через консоль управления нельзя установить права доступа к сервисному аккаунту. Вы можете [назначить роль на каталог](../../../resource-manager/operations/folder/set-access-bindings.md), которому принадлежит сервисный аккаунт.

---

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды для назначения роли на сервисный аккаунт как на ресурс:

    ```
    $ yc iam service-account add-access-binding --help
    ```

1. Выберите сервисный аккаунт, например `my-robot`:

    ```
    $ yc iam service-account list
    +----------------------+------------------+-------------------------------+
    |          ID          |       NAME       |          DESCRIPTION          |
    +----------------------+------------------+-------------------------------+
    | aje6o61dvog2h6g9a33s | my-robot         |                               |
    | aje9sda1ufvqcmfksd3f | blabla           | bla bla bla is my description |
    +----------------------+------------------+-------------------------------+
    ```

1. Выберите [роль](../../concepts/access-control/roles.md):

    ```
    $ yc iam role list
    ```
1. Узнайте идентификатор и [тип субъекта](../../concepts/users/users.md), которому назначается роль.

    Например, чтобы назначить роль обычному пользователю, узнайте его идентификатор по логину или адресу электронной почты:

        ```
        $ yc iam user-account get test-user
        id: gfei8n54hmfhuk5nogse
        yandex_passport_user_account:
          login: test-user
          default_email: test-user@yandex.ru
        ```
2. Назначьте субъекту роль на сервисный аккаунт. Вы можете назначать роли разным типам субъектов:

    * Чтобы назначить роль [пользователю](../../concepts/users/users.md#passport), используйте тип субъекта `userAccount`. Например, назначьте пользователю `test-user` роль `editor` на сервисный аккаунт `my-robot`:

        ```
        yc iam service-account add-access-binding my-robot \
            --role editor \
            --subject userAccount:gfei8n54hmfhuk5nogse
        ```
    * Чтобы назначить роль [сервисному аккаунту](../../concepts/users/users.md#sa), используйте тип субъекта `serviceAccount`. Например, разрешите сервисному аккаунту `blabla` управлять `my-robot`. Идентификатор `blabla` вы уже получили при выборе сервисного аккаунта:

        ```
        yc iam service-account add-access-binding my-robot \
            --role editor \
            --subject serviceAccount:aje9sda1ufvqcmfksd3f
        ```
    * Чтобы назначить роль [системной группе](../../concepts/users/users.md#system), используйте тип субъекта `system`. Например, разрешите любому пользователю Яндекс.Облака просматривать информацию о сервисном аккаунте `my-robot`:

        ```
        yc iam service-account add-access-binding my-robot \
            --role viewer \
            --subject system:allAuthenticatedUsers
        ```

**[!TAB API]**

Чтобы назначить роль на сервисный аккаунт как на ресурс, воспользуйтесь методом [setAccessBindings](../../api-ref/ServiceAccount/setAccessBindings.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

---