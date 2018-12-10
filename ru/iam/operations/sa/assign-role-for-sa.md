# Назначить роль сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) сервисному аккаунту на какой либо ресурс. Чтобы назначить другому пользователю роль на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс, воспользуйтесь инструкцией [[!TITLE]](set-access-bindings.md).

Через консоль управления сервисному аккаунту можно назначить роль только на каталог, в котором он был создан. Чтобы назначить ему роль на другой ресурс, используйте CLI или API.

---

**[!TAB Консоль управления]**

Чтобы назначить сервисному аккаунту роль на каталог, в котором он был создан:

[!INCLUDE [grant-role-console-sa](../../../_includes/grant-role-console-sa.md)]

**[!TAB CLI]**

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы назначить сервисному аккаунту роль на ресурс, выполните команду:

```
yc <SERVICE-NAME> <RESOURCE> add-access-binding <RESOURCE-NAME>|<RESOURCE-ID> \
    --role <ROLE-ID> \
    --subject serviceAccount:<SERVICE-ACCOUNT-ID>
```

где:

* `<SERVICE-NAME>` — имя сервиса, на чей ресурс назначается роль, например `resource-manager`.
* `<RESOURCE>` — категория ресурса, например `cloud`.
* `<RESOURCE-NAME>` — имя ресурса. Вы можете указать ресурс по имени или идентификатору.
* `<RESOURCE-ID>` — идентификатор ресурса.
* `<ROLE-ID>` — идентификатор роли, например `[!KEYREF roles-cloud-owner]`.
* `<SERVICE-ACCOUNT-ID>` — идентификатор сервисного аккаунта, которому назначается роль.

Например, чтобы назначить сервисному аккаунту роль `viewer` на [облако](../../../resource-manager/concepts/resources-hierarchy.md#cloud) `mycloud`:

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


1. Назначьте роль сервисному аккаунту `my-robot`, используя его идентификатор:

    ```
    $ yc resource-manager cloud add-access-binding mycloud \
        --role viewer \
        --subject serviceAccount:aje6o61dvog2h6g9a33s
    ```

**[!TAB API]**

Чтобы назначить сервисному аккаунту роль на ресурс, воспользуйтесь методом `setAccessBindings` для того ресурса, на который нужно назначить роль.

---

#### Что дальше

- [[!TITLE]](create-access-key.md)
- [[!TITLE]](set-access-bindings.md)