# Создать сервисный аккаунт

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
    $ yc iam service-account create -h
    ```

2. Создайте сервисный аккаунт, указав его имя, например `my-robot`:

    ```
    $ yc iam service-account create --name my-robot
    ```

    [!INCLUDE [name-format](../../../_includes/name-format.md)]

    Вы можете добавить произвольное описание сервисного аккаунта с помощью флага `--description`:

    ```
    $ yc iam service-account create --name my-robot \
        --description "this is my favorite service account"
    ```

**[!TAB API]**

Чтобы создать сервисный аккаунт, воспользуйтесь методом `create` для ресурса `ServiceAccount`.

---