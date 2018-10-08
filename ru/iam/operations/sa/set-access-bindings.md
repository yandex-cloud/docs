# Установить права доступа к сервисному аккаунту

Этот раздел про назначение [роли](../../concepts/access-control/roles.md) на [сервисный аккаунт](../../concepts/users/service-accounts.md) как на ресурс. Чтобы выдать роль сервисному аккаунту на другой ресурс, воспользуйтесь инструкцией [[!TITLE]](assign-role-for-sa.md).

Через консоль управления нельзя установить права доступа к сервисному аккаунту. Вы можете [назначить роль на каталог](../../../resource-manager/operations/folder/set-access-bindings.md), которому принадлежит сервисный аккаунт.

---

**[!TAB CLI]**

Назначьте пользователю (субъекту) роль на сервисный аккаунт в вашем каталоге по умолчанию:

```
yc iam service-account add-access-binding <SERVICE-ACCOUNT-NAME>|<SERVICE-ACCOUNT-ID> \
    --role <ROLE-ID> \
    --subject <SUBJECT-TYPE>:<SUBJECT-ID>
```

где:

* `<SERVICE-ACCOUNT-NAME>` — имя сервисного аккаунта, на который субъекту назначается роль. Вы можете указать сервисный аккаунт по имени или идентификатору.
* `<SERVICE-ACCOUNT-ID>` — идентификатор сервисного аккаунта.
* `<ROLE-ID>` — идентификатор роли, например `[!KEYREF roles-cloud-owner]`.
* `<SUBJECT-TYPE>` — тип субъекта: `system`, `userAccount` или `serviceAccount`. Подробнее о субъектах читайте в разделе [[!TITLE]](../../concepts/users/users.md).
* `<SUBJECT-ID>` — идентификатор субъекта, которому назначается роль.

Например, назначьте пользователю роль `editor` на сервисный аккаунт `myrobot`:

```
yc iam service-account add-access-binding myrobot \
    --role editor \
    --subject userAccount:ajeptmgeb3f2q56bifci
```

Если сервисный аккаунт принадлежит другому каталогу, вы можете указать каталог с помощью флагов `--folder-id` или `folder-name`:

```
yc iam service-account add-access-binding myrobot \
    --role editor \
    --subject userAccount:ajeptmgeb3f2q56bifci \
    --folder-name yet-another-folder
```

**[!TAB API]**

Чтобы назначить роль на сервисный аккаунт, воспользуйтесь методом `SetAccessBindings` для ресурса `ServiceAccount`.

---