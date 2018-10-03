# Установить права доступа к сервисному аккаунту

Этот раздел про то, как назначить [роль](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md), как на ресурс. О том, как выдать роль сервисному аккаунту на другой ресурс, читайте в разделе [[!TITLE]](assign-role-for-sa.md).

На данный момент через консоль управления можно [установить права доступа к каталогу](../../../resource-manager/operations/folder/set-access-bindings.md), в котором был создан сервисный аккаунт и только для [пасспортного пользователя](../../concepts/users/users.md#passport).

На сам сервисный аккаунт назначьте роль с помощью CLI или API.

---

**[!TAB CLI]**

Чтобы назначить сервисному аккаунту роль на ресурс, выполните команду:

```
yc iam service-account add-access-binding <SERVICE-ACCOUNT-NAME>|<SERVICE-ACCOUNT-ID> \
    --role <ROLE-ID> \
    --subject <SUBJECT-TYPE>:<SUBJECT-ID>
```

где:

* `<SERVICE-ACCOUNT-NAME>` — имя сервисного аккаунта, на который назначается роль субъекту.
* `<SERVICE-ACCOUNT-ID>` — идентификатор сервисного аккаунта, на который назначается роль субъекту. Вы можете выбрать, указать сервисный аккаунт по имени или идентификатору.
* `<ROLE-ID>` — идентификатор роли, например `[!KEYREF roles-cloud-owner]`.
* `<SERVICE-ACCOUNT-ID>` — идентификатор сервисного аккаунта, которому назначается роль.

Например, назначьте пользователю роль `editor` на сервисный аккаунт `myrobot`:

```
yc iam service-account add-access-binding myrobot \
    --role editor
    --subject userAccount:ajeptmgeb3f2q56bifci
```

**[!TAB API]**

Чтобы назначить роль на сервисный аккаунт, воспользуйтесь методом `SetAccessBindings` для ресурса `ServiceAccount`.

---