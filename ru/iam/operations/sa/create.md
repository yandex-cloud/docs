# Создать сервисный аккаунт

Создайте [сервисный аккаунт](../../concepts/users/service-accounts.md), чтобы управлять ресурсами от имени другой учетной записи.

## Как создать сервисный аккаунт

---

**[!TAB Консоль управления]**

1. Выберите каталог.
2. Выберите вкладку **Сервисные аккаунты**.
3. Нажмите кнопку **Создать сервисный аккаунт**.
4. Введите имя сервисного аккаунта.
5. Вы можете сразу назначить сервисному аккаунту [роль](../../concepts/access-control/roles.md) на каталог, в котором он будет создан.
    Для этого нажмите **Добавить роль** и выберите роль.

    Чтобы назначить роль на другой ресурс, воспользуйтесь CLI или API по инструкции [[!TITLE]](assign-role-for-sa.md).
6. Нажмите кнопку **Добавить**.

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

1. Посмотрите описание команды создания сервисного аккаунта:

    ```
    $ yc iam service-account create --help
    ```

2. Создайте сервисный аккаунт с именем `my-robot`:

    ```
    $ yc iam service-account create --name my-robot
    ```

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

**[!TAB API]**

Чтобы создать сервисный аккаунт, воспользуйтесь методом [create](../../api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../api-ref/ServiceAccount/index.md).

---


## Примеры

Создайте сервисный аккаунт с именем и описанием:

---

**[!TAB CLI]**

```
$ yc iam service-account create --name my-robot \
    --description "this is my favorite service account"
```

---